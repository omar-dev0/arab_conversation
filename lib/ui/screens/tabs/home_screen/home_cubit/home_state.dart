import 'package:arab_conversation/data/model/course.dart';
import 'package:arab_conversation/data/model/course_item.dart';

abstract class HomeStates {}

class HomeInitState extends HomeStates {}

class HomeLoadingState extends HomeStates {
  String text;

  HomeLoadingState(this.text);
}

class HomeSuccessState extends HomeStates {
  List<Course> courses;
  HomeSuccessState(this.courses);
}

class SuccessLoadingChpaters extends HomeStates {
  List<CourseItem> chapters;

  SuccessLoadingChpaters(this.chapters);
}

class SuccessLoadingUrl extends HomeStates {
  String url;

  SuccessLoadingUrl(this.url);
}
class SuccessPlay extends HomeStates{
  String courseItemName;
  int courseIndex;
  SuccessPlay(this.courseItemName , this.courseIndex);
}
