import 'package:arab_conversation/data/model/course.dart';
import 'package:arab_conversation/ui/screens/course_ccontent/course_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseWidget extends StatefulWidget {
  Course course;
  CourseWidget({super.key, required this.course});

  @override
  State<CourseWidget> createState() => _CourseWidgetState();
}

class _CourseWidgetState extends State<CourseWidget> {
  String heartIcon = 'assets/icons/heart_light.png';
  double scaleHeart = 1;
  Color hearColor = Colors.white;
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CourseContent.route,
            arguments: widget.course);
      },
      child: Material(
        borderRadius: BorderRadius.circular(12.r),
        elevation: 10,
        shadowColor: Colors.black,
        child: Container(
          width: 159.w,
          height: 186.h,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background.withOpacity(.8),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Container(
            padding: EdgeInsetsDirectional.only(start: 8.w, end: 8.w, top: 8.w),
            decoration: BoxDecoration(
                color: Colors.white12,
                borderRadius: BorderRadius.circular(12.r)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '${widget.course.price} \$',
                        style: GoogleFonts.roboto(
                            fontSize: 14.sp, color: Colors.white),
                      ),
                    ),
                    Expanded(
                        child: SizedBox(
                      width: double.infinity,
                    )),
                  ],
                ),
                SizedBox(
                  height: 8.h,
                ),
                Image.asset(
                  'assets/images/learn.png',
                  width: 106.12.w,
                  height: 79.07.h,
                ),
                SizedBox(
                  height: 10.93.h,
                ),
                Expanded(
                  child: Text(
                    widget.course.name ?? "",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
