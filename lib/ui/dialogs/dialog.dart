import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showCustomDialog(
  BuildContext context, {
  Widget? icon,
  Widget? title,
  Widget? content,
  VoidCallback? positive,
  String? positiveText,
  VoidCallback? negative,
  String? negativeText,
}) {
  List<Widget> actions = [];
  if (positiveText != null) {
    actions.add(TextButton(
        onPressed: () {
          positive?.call();
        },
        child: Text(
          positiveText,
          style: TextStyle(fontSize: 15),
        )));
  }
  if (negativeText != null) {
    actions.add(TextButton(
        onPressed: () {
          negative?.call();
        },
        child: Text(
          negativeText,
          style: TextStyle(
            fontSize: 15,
            color: Colors.red,
          ),
        )));
  }

  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            icon: icon,
            title: title,
            content: content,
            actions: actions,
          ));
}

void loadingDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            content: Row(
              children: [
                const CircularProgressIndicator(),
                SizedBox(
                  width: 20.w,
                ),
                Text(
                  'Loading...',
                  style: Theme.of(context)
                      .textTheme
                      .labelLarge
                      ?.copyWith(fontSize: 15.sp),
                )
              ],
            ),
          ),
      barrierDismissible: false);
}

void closeDialog(BuildContext context) {
  Navigator.pop(context);
}
