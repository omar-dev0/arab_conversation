import 'package:arab_conversation/data/model/course.dart';
import 'package:arab_conversation/data/model/course_item.dart';

abstract class CourseRepo {
  Future<List<Course>> getCourserApp();

  List<Course> get courses;

  Future<List<CourseItem>> getCourseContent(String folderPath);

  List<CourseItem> get chapters;

  Future<String> getUrl(String path);

  Future<void> addToPayCourse(Course course, String userId);

  Future<List<Course>> getPaidCourse(String userId);

  List<Course> get userPaidCourses;

  Future<List<Course>> getAvailableCourse();

  List<Course> get availableCourse;
}
