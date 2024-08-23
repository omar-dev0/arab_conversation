import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef valid = String? Function(String?);

class CustomTextFormField extends StatelessWidget {
  final Widget? icon;
  final String? hint;
  final String? label;
  final valid? validFunction;
  final bool? isPassword;
  final double? top;
  final double? bottom;
  final TextEditingController? controller;

  const CustomTextFormField(
      {super.key,
      this.icon,
      this.hint,
      this.label,
      this.validFunction,
      this.isPassword,
      this.top,
      this.bottom,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: top ?? 0, bottom: bottom ?? 0),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword ?? false,
        obscuringCharacter: '*',
        validator: validFunction,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 2.w),
                borderRadius: BorderRadius.circular(8)),
            hintText: hint,
            hintStyle: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: const Color(0xFF808080), fontSize: 12),
            labelText: label,
            labelStyle: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(fontSize: 18.sp),
            suffixIcon: icon),
      ),
    );
  }
}
