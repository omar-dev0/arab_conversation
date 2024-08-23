import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {
  final Function? press;
  final String icon;
  final String text;

  const CustomContainer(
      {super.key, this.press, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (press != null) {
          press!.call();
        }
      },
      child: Container(
        height: 48.h,
        width: 341.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: const Color(0xFFECEDED),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38,
                offset: Offset(
                  3.0,
                  3.0,
                ),
                blurRadius: 1)
          ],
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.only(
              start: 17.55.w, top: 13.55.h, bottom: 14.45.h),
          child: Row(
            children: [
              ImageIcon(
                AssetImage(icon),
                color: Theme.of(context).colorScheme.secondary,
              ),
              SizedBox(
                width: 16.w,
              ),
              Text(
                text,
                style: Theme.of(context).textTheme.labelSmall,
              )
            ],
          ),
        ),
      ),
    );
  }
}
