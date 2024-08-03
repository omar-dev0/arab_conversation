import 'package:arab_conversation/data/model/course_item.dart';
import 'package:arab_conversation/ui/screens/listien_screen/listen_screen.dart';
import 'package:arab_conversation/ui/screens/payment/payment_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/model/course.dart';

class CourseItemWidget extends StatefulWidget {
  String courseName;
  CourseItem? courseItem;
  List<CourseItem>? chapters;
  bool inPlayList;
  bool isRun;
  int index;
  bool isPayment;
  Course? course;
  CourseItemWidget(
      {super.key,
      required this.courseItem,
      required this.courseName,
      this.chapters,
      this.inPlayList = false,
      this.isRun = false,
      this.isPayment = false,
        this.course,
      required this.index});

  @override
  State<CourseItemWidget> createState() => _CourseItemWidgetState();
}

class _CourseItemWidgetState extends State<CourseItemWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await homeCubit.getPaidCourses();
        if (!widget.isPayment) {
            {
          if (homeCubit.userPaidCourses.contains(widget.course) ||
              widget.index < 2) {
            if (!widget.inPlayList) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListenScreen(
                            index: widget.index,
                            chapters: widget.chapters,
                            chapter: widget.courseItem,
                            name: widget.courseName,
                          )));
            } else {
              await homeCubit.getUrl(
                  widget.courseItem ?? CourseItem(), widget.index);
              Navigator.pop(context);
            }
          }
          else {
            showDialog(
                context: context,
                builder: (context) => Container(
                        child: Dialog(
                      backgroundColor: Colors.white,
                      surfaceTintColor: Colors.white,
                      insetPadding: EdgeInsets.only(right: 1),
                      child: Container(
                        padding: EdgeInsets.only(top: 16.h),
                        width: 349.w,
                        height: 219.h,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(child: SizedBox()),
                                Text(
                                  'Subscribe now',
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
                                ),
                                Expanded(child: SizedBox()),
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(Icons.close)),
                              ],
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Image.asset(
                              'assets/icons/subnow.png',
                              width: 81.83.w,
                              height: 75.54.h,
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              child: Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 143.w,
                                      height: 48.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        border: Border.all(
                                            width: 1, color: Colors.black),
                                      ),
                                      child: Text('Cancel',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                fontSize: 20.sp,
                                              )),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 17.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => PaymentScreen(
                                                course: widget.course!,
                                                  )));
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 143.w,
                                      height: 48.h,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.r),
                                        color: Color(0xFF0D3F48),
                                      ),
                                      child: Text('Ok',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall
                                              ?.copyWith(
                                                  fontSize: 20.sp,
                                                  color: Colors.white)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )));
          }
          }
        }
      },
      child: Material(
        elevation: 5,
        color: Colors.black54,
        child: Container(
          width: 343.w,
          height: 90.h,
          decoration: BoxDecoration(
            color: Color(0xFFF7FAFB),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.only(end: 8.w),
            child: Row(
              children: [
                Container(
                  width: 70.w,
                  height: 90.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/course_item.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.courseName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      widget.courseItem?.name ?? "",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                  ],
                ),
                Expanded(
                    child: SizedBox(
                  width: double.infinity,
                )),
                !widget.isRun
                    ? CircleAvatar(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        radius: 15.r,
                        child: ImageIcon(
                          AssetImage('assets/icons/headset.png'),
                          color: Colors.white,
                        ),
                      )
                    : ImageIcon(AssetImage('assets/icons/play_list.svg')),
              ],
            ),
          ),
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }
}
