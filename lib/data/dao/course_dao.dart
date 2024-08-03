import 'package:arab_conversation/data/dao/user_dao.dart';
import 'package:arab_conversation/data/model/course.dart';
import 'package:arab_conversation/data/model/course_item.dart';
import 'package:arab_conversation/di/di.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';

@singleton
@injectable
class CourseDao {
  FirebaseStorage storage = FirebaseStorage.instance;
  UserDao appUser;
  @factoryMethod CourseDao(this.appUser);
  Future<List<Course>> getAppCourses() async {
    var coursesRef = storage.ref().child('courses/');
    ListResult coursesStorage = await coursesRef.listAll();
    List<Course> courses = [];
    await Future.forEach(coursesStorage.prefixes, (folder) async {
      String price = folder.name.substring(folder.name.indexOf('#')+1);
      String name = folder.name.substring(0 , folder.name.indexOf('#'));
      Course course = Course(name: name, fullPath: folder.fullPath , price: price);
      courses.add(course);
    });
    return courses;
  }

  Future<List<CourseItem>> getCourseContent(String folderPath) async {
    List<CourseItem> courseChapters = [];
    var courseFolder = storage.ref().child('$folderPath/');
    ListResult courseContent = await courseFolder.listAll();
    for (var courseChapter in courseContent.items) {
      courseChapters.add(CourseItem(
          name: courseChapter.name, fullPath: courseChapter.fullPath));
    }
    return courseChapters;
  }

  Future<String> getUrl(String path) async {
    return storage.ref().child(path).getDownloadURL();
  }

  CollectionReference<Course> getCoursesCollection(String? userId) {
    return appUser.collection
        .doc(userId)
        .collection("paidCourses")
        .withConverter(
            fromFirestore: (snapshot, options) =>
                Course.fromFireStore(snapshot.data()),
            toFirestore: (taskObject, options) => taskObject.toFirebase());
  }

  Future<void> addToPayCourse(Course course, String userId) {
    var courseCollection = getCoursesCollection(userId);
    var courseDoc = courseCollection.doc(course.name);
    return courseDoc.set(course);
  }

  Future<List<Course>> getPaidCourse(String userId) async {
    List<Course> paidCourses = [];
    CollectionReference<Course> courses = getCoursesCollection(userId);
   var coursesSnapshot =  await courses.get();
   List<QueryDocumentSnapshot<Course>> coursesQueryList = coursesSnapshot.docs;
    for(QueryDocumentSnapshot<Course> course in coursesQueryList)
      {
       paidCourses.add(course.data());
      }
    return paidCourses;

  }

  CollectionReference<Course> get availableCourses =>
      FirebaseFirestore.instance.collection('courses').withConverter(
          fromFirestore: (snapshot, options) =>
              Course.fromFireStore(snapshot.data()),
          toFirestore: (courseObject, options) => courseObject.toFirebase());


  Future<List<Course>> getAvailableCourses() async {
    List<Course> availableCoursesList = [];
    CollectionReference<Course> courses = availableCourses;
    var coursesSnapshot =  await courses.get();
    List<QueryDocumentSnapshot<Course>> coursesQueryList = coursesSnapshot.docs;
    for(QueryDocumentSnapshot<Course> course in coursesQueryList)
    {
      availableCoursesList.add(course.data());
    }
    return availableCoursesList;

  }


}
