import 'package:arab_conversation/data/dao/course_dao.dart';
import 'package:arab_conversation/data/data_contract/course_contact.dart';
import 'package:arab_conversation/data/model/course.dart';
import 'package:arab_conversation/data/model/course_item.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CourseDataSource)
class CourseDataSourceImp extends CourseDataSource {
  final CourseDao courseDao;

  @factoryMethod
  CourseDataSourceImp(this.courseDao);

  @override
  Future<List<Course>> getCourserApp()async {
    return courseDao.getAppCourses();
  }

  @override
  Future<List<CourseItem>> getCourseContent(String folderPath)async {
    return courseDao.getCourseContent(folderPath);
  }

  @override
  Future<String> getUrl(String path) async {
    return courseDao.getUrl(path);
  }

  @override
  Future<void> addToPayCourse(Course course, String userId) {
    return courseDao.addToPayCourse(course, userId);
  }

  @override
  Future<List<Course>> getPaidCourse(String userId) {
    return courseDao.getPaidCourse(userId);
  }

  @override
  Future<List<Course>> getavailableCourses()async{
    return courseDao.getAvailableCourses();
  }
}
