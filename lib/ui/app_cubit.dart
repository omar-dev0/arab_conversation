import 'package:arab_conversation/data/model/course.dart';
import 'package:arab_conversation/data/repository/auth_repo.dart';
import 'package:arab_conversation/data/repository/course_repo.dart';
import 'package:arab_conversation/ui/app_state.dart';
import 'package:arab_conversation/ui/screens/authintication_screens/login/login.dart';
import 'package:arab_conversation/ui/screens/tabs/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AppViewModel extends Cubit<AppState> {
  AuthRepo repo;
  CourseRepo courseRepo;

  @factoryMethod
  AppViewModel(this.repo , this.courseRepo) : super(InitState());

  Future<Widget> firstScreen() async {
    if (await repo.isSigneIn()) {

      return const Home();
    } else {
      return LoginScreen();
    }
  }

  Future<List<Course>> getAvailableCourses() async {
    return courseRepo.getAvailableCourse();
  }

  List<Course> get availableCourses => courseRepo.AvailableCourse;
}
