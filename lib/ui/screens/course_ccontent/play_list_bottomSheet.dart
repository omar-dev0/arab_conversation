import 'package:arab_conversation/data/model/course_item.dart';
import 'package:arab_conversation/ui/shared_widgets/course_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlayListBottomSheet extends StatelessWidget {
  List<CourseItem>? courseItem;
  String courseName;
  PlayListBottomSheet(
      {super.key, required this.courseItem, required this.courseName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      width: 375.w,
      height: 350.h,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_down_outlined,
              size: 35.h,
              color: Colors.black,
            ),
          ),
          SizedBox(
            height: 7.h,
          ),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) => CourseItemWidget(
                      courseItem: courseItem?[index],
                      courseName: courseName,
                      inPlayList: true,
                  index: index,
                    ),
                separatorBuilder: (context, index) => SizedBox(
                      height: 16.h,
                    ),
                itemCount: courseItem?.length ?? 0),
          )
        ],
      ),
    );
  }
}
