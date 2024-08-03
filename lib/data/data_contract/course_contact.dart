import 'package:arab_conversation/data/model/course.dart';
import 'package:arab_conversation/data/model/course_item.dart';

abstract class CourseDataSource {
  Future<List<Course>> getCourserApp();

  Future<List<CourseItem>> getCourseContent(String folderPath);

  Future<String> getUrl(String path);
  Future<void> addToPayCourse(Course course, String userId);
  Future<List<Course>> getPaidCourse(String userId);
  Future<List<Course>> getavailableCourses();
}
