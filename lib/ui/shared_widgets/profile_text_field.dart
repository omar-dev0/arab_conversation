import 'package:arab_conversation/ui/shared_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileTextField extends StatefulWidget {
  final TextEditingController controller;
  final valid? validator;
  final bool? isEnabled;

  const ProfileTextField(
      {super.key, required this.controller, this.validator, this.isEnabled});

  @override
  State<ProfileTextField> createState() => _ProfileTextFieldState();
}

class _ProfileTextFieldState extends State<ProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(16.r),
      elevation: 5,
      shadowColor: Colors.black54,
      child: TextFormField(
          enabled: widget.isEnabled,
          validator: widget.validator,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xFFECEDED),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide.none),
          ),
          style: const TextStyle(color: Colors.black),
          controller: widget.controller),
    );
  }
}
