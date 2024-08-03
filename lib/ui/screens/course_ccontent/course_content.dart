import 'package:arab_conversation/data/model/course.dart';
import 'package:arab_conversation/data/model/course_item.dart';
import 'package:arab_conversation/di/di.dart';
import 'package:arab_conversation/ui/screens/tabs/home_screen/home_cubit/home_cubit.dart';
import 'package:arab_conversation/ui/screens/tabs/home_screen/home_cubit/home_state.dart';
import 'package:arab_conversation/ui/shared_widgets/course_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseContent extends StatefulWidget {
  static const String route = "courseContent";

  CourseContent({super.key});

  @override
  State<CourseContent> createState() => _CourseContentState();
}

class _CourseContentState extends State<CourseContent> {
  Course? course;

  HomeViewModel homeCubit = getIt.get<HomeViewModel>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      course = ModalRoute.of(context)?.settings.arguments as Course;

      await homeCubit.getCourseContent(course?.fullPath ?? "");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/app_screen.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFECEDED),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              homeCubit.cashedCourses();
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            course?.name ?? "",
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(fontSize: 20.sp),
          ),
        ),
        body: Padding(
          padding:
              EdgeInsetsDirectional.only(top: 16.h, start: 16.w, end: 16.w),
          child: Column(
            children: [
              BlocProvider(
                create: (context) => homeCubit,
                child: BlocConsumer<HomeViewModel, HomeStates>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is SuccessLoadingChpaters) {
                      return Expanded(
                          child: ListView.separated(
                              itemBuilder: (context, index) => CourseItemWidget(
                                course: course,
                                index: index,
                                chapters: state.chapters,
                                  courseItem: state.chapters[index],
                                  courseName: course?.name ?? ""),
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 16.h,
                                  ),
                              itemCount: state.chapters.length));
                    } else if (state is HomeLoadingState) {
                      return Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              width: 10.w,
                            ),
                            Text(
                              state.text,
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      );
                    }
                    return const Column();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
