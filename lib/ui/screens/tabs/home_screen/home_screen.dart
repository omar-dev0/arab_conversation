import 'package:arab_conversation/di/di.dart';
import 'package:arab_conversation/ui/screens/tabs/home_screen/home_cubit/home_cubit.dart';
import 'package:arab_conversation/ui/screens/tabs/home_screen/home_cubit/home_state.dart';
import 'package:arab_conversation/ui/shared_widgets/course_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeViewModel homeCubit = getIt.get<HomeViewModel>();
  @override
  void initState() {
    super.initState();
    homeCubit.getCourses();
    homeCubit.getPaidCourses();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => homeCubit,
        child: BlocConsumer<HomeViewModel, HomeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is HomeLoadingState) {
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
            if (state is HomeSuccessState) {
              return SafeArea(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                      top: 8.h, start: 16.w, end: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsetsDirectional.only(
                            top: 33.h, start: 16.h, end: 16.h, bottom: 14.h),
                        width: 343.w,
                        height: 186.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/searchbg.png'),
                                fit: BoxFit.cover)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '\"Unlock the Beauty of Arabic:',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: Colors.white, fontSize: 22.sp),
                            ),
                            Text(
                              'Your Gateway to Language',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: Colors.white, fontSize: 22.sp),
                            ),
                            Text(
                              'Mastery!\"',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: Colors.white, fontSize: 22.sp),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Container(
                              width: 311.w,
                              height: 38.h,
                              // child: TextField(
                              //   controller: homeCubit.searchingController,
                              //   decoration: InputDecoration(
                              //       contentPadding: EdgeInsets.zero,
                              //       fillColor: Colors.white,
                              //       filled: true,
                              //       focusedBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(12.r),
                              //       ),
                              //       enabledBorder: OutlineInputBorder(
                              //         borderRadius: BorderRadius.circular(12.r),
                              //       ),
                              //       prefixIcon: ImageIcon(
                              //         AssetImage('assets/icons/search.png'),
                              //       ),
                              //       hintText: 'Search here',
                              //       hintStyle: TextStyle(
                              //           fontSize: 16.sp,
                              //           color: Color(0xFF999999))),
                              // ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Text(
                        'Courses',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 25.w,
                                  mainAxisSpacing: 16.h,
                                  childAspectRatio: 159 / 186),
                          itemBuilder: (context, index) => CourseWidget(
                            course: state.courses[index],
                          ),
                          itemCount: state.courses.length,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
            return Column(
            );
          },
        ));
  }
}
