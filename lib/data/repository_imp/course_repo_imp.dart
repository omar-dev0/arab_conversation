import 'package:arab_conversation/data/data_contract/course_contact.dart';
import 'package:arab_conversation/data/model/course.dart';
import 'package:arab_conversation/data/model/course_item.dart';
import 'package:arab_conversation/data/repository/course_repo.dart';
import 'package:injectable/injectable.dart';

@Singleton(as: CourseRepo)
@Injectable(as: CourseRepo)
class CourseRepoImp extends CourseRepo {
  final CourseDataSource source;
   List<Course> course = [];
   List<CourseItem> chapter = [];
   String fullPathOFCourse = "";
   List<Course> paidCourses = [];
  List<Course> availableCourses = [];
  @factoryMethod
  CourseRepoImp(this.source);

  @override
  Future<List<Course>> getCourserApp() async {
    course = await source.getCourserApp();
    return courses;
  }

  @override
  Future<List<CourseItem>> getCourseContent(String folderPath) async {
    if (fullPathOFCourse != folderPath) {
      fullPathOFCourse = folderPath;
      chapter = await source.getCourseContent(folderPath);
    }
    return chapters;
  }

  @override
  Future<String> getUrl(String path) {
    return source.getUrl(path);
  }

  @override
  // TODO: implement chapters
  List<CourseItem> get chapters => chapter;

  @override
  List<Course> get courses => course;

  @override
  Future<void> addToPayCourse(Course course, String userId) {
    return source.addToPayCourse(course, userId);
  }

  @override
  Future<List<Course>> getPaidCourse(String userId) async {
    if(paidCourses.isEmpty) {
      paidCourses = await source.getPaidCourse(userId);
      return paidCourses;
    }
    else {
      return paidCourses;
    }
  }

  @override
  List<Course> get userPaidCourses => paidCourses;

  @override
  Future<List<Course>> getAvailableCourse() async {
    availableCourses = await source.getavailableCourses();
    return availableCourses;
  }

  @override
  List<Course> get availableCourse => availableCourses;
}
