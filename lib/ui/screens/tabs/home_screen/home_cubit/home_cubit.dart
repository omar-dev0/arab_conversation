import 'package:arab_conversation/data/model/course.dart';
import 'package:arab_conversation/data/model/course_item.dart';
import 'package:arab_conversation/data/repository/auth_repo.dart';
import 'package:arab_conversation/data/repository/course_repo.dart';
import 'package:arab_conversation/ui/screens/tabs/home_screen/home_cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:just_audio/just_audio.dart';

@injectable
class HomeViewModel extends Cubit<HomeStates> {
  final AuthRepo authRepo;
  final CourseRepo courseRepo;
  late final String chapterUrl;
  AudioPlayer audioPlayer = AudioPlayer();
  int chapterIndex = 0;
  @factoryMethod
  HomeViewModel(this.courseRepo , this.authRepo) : super(HomeInitState());

  Future<void> getCourses() async {
    if (courseRepo.courses.isEmpty) {
      emit(HomeLoadingState("Loading..."));
      await courseRepo.getCourserApp();
      emit(HomeSuccessState(courseRepo.courses));
    } else {
      emit(HomeSuccessState(courseRepo.courses));
    }
  }

  Future<void> getCourseContent(String fullPath) async {
    emit(HomeLoadingState('Loading...'));
    await courseRepo.getCourseContent(fullPath);
    late final int check = courseRepo.chapters.first.name?.indexOf(".") ?? 0;
    for (var element in courseRepo.chapters) {
      if (check != -1) {
        element.name =
            element.name?.substring(0, element.name?.indexOf("."));
      } else {
        break;
      }
    }
    courseRepo.chapters.sort((a, b) {
      const String regex = r"Chapter (\d+)";
      if (a.name?.contains('Opening') ?? false) {
        return -1;
      } else if (b.name?.contains('Opening') ?? false) {
        return 1;
      } else {
        String aName = a.name ?? "";
        String bName = b.name ?? "";
        final int chapterNumberA =
            int.parse(RegExp(regex).firstMatch(aName)?.group(1) ?? "");
        final int chapterNumberB =
            int.parse(RegExp(regex).firstMatch(bName)?.group(1) ?? "");
        return chapterNumberA.compareTo(chapterNumberB);
      }
    });
    emit(SuccessLoadingChpaters(courseRepo.chapters));
  }

  Future<void> getUrl(CourseItem courseItem , [int? index]) async {
   final String path = courseItem.fullPath ?? "";
     chapterUrl = await courseRepo.getUrl(path);
     audioPlayer.setUrl(chapterUrl);
     if(index != null)
       {
         chapterIndex = index;
       }
     emit(SuccessPlay(courseItem.name ?? "" , chapterIndex));
  }

  void cashedCourses() {
    emit(HomeSuccessState(courseRepo.courses));
  }

  void cashedCourseChapters() {
    {
      emit(SuccessLoadingChpaters(courseRepo.chapters));
    }
  }

  Future<void> addToPaidCourses(Course course) async{
    await courseRepo.addToPayCourse(course, authRepo.get().id ?? "");
  }

  Future<void> getPaidCourses()async{
 await courseRepo.getPaidCourse(authRepo.get().id ?? "");

  }
  List<Course> get userPaidCourses => courseRepo.userPaidCourses;

}
