import 'package:arab_conversation/di/di.dart';
import 'package:arab_conversation/ui/dialogs/dialog.dart';
import 'package:arab_conversation/ui/screens/authintication_screens/forget_password/forget_password_cubit/forget_password_state.dart';
import 'package:arab_conversation/ui/screens/authintication_screens/forget_password/forget_password_cubit/forget_password_view_model.dart';
import 'package:arab_conversation/ui/screens/authintication_screens/login/login.dart';
import 'package:arab_conversation/ui/shared_widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassword extends StatefulWidget {
  static const String route = "ForgetPage";

  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final ForgetPasswordViewModel passwordViewModel =
      getIt.get<ForgetPasswordViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsDirectional.only(
            top: 92.h,
          ),
          child: BlocProvider(
            create: (context) => passwordViewModel,
            child: BlocConsumer<ForgetPasswordViewModel, ForgetPasswordState>(
              listener: (context, state) {
                if (state is Loading) {
                  loadingDialog(context);
                }
                if (state is Success) {
                  closeDialog(context);
                  showCustomDialog(
                    context,
                    icon: CircleAvatar(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        child: const ImageIcon(
                          AssetImage('assets/icons/email.png'),
                          color: Colors.white,
                        )),
                    title: Text(
                      'Check your email',
                      style: TextStyle(
                          fontSize: 18.sp, fontWeight: FontWeight.bold),
                    ),
                    content: const Text(
                      'We have send password recovery instruction to your email',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xFF7D848D), fontSize: 16),
                    ),
                    positive: () {
                      Navigator.pushReplacementNamed(
                          context, LoginScreen.route);
                    },
                    positiveText: 'Ok',
                  );
                }
                if (state is Error) {
                  closeDialog(context);
                  showCustomDialog(context,
                      icon: Icon(
                        Icons.error,
                        color: Colors.red,
                        size: 35.sp,
                      ),
                      content: Text(
                        state.error,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Color(0xFF7D848D), fontSize: 16),
                      ),
                      negativeText: 'Ok', negative: () {
                    Navigator.pop(context);
                  });
                }
              },
              builder: (context, state) => Form(
                key: passwordViewModel.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Forgot password',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    Text(
                      'Enter your email account to reset',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: null,
                            color: const Color(0xFF7D848D),
                          ),
                    ),
                    Text(
                      'your password',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                            fontWeight: null,
                            color: const Color(0xFF7D848D),
                          ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.symmetric(horizontal: 16.w),
                      child: TextFormField(
                        controller: passwordViewModel.email,
                        validator: passwordViewModel.validEmail,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFEAEAEB),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.r)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.r)),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12.r)),
                          hintText: 'Email',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.only(
                        start: 12.w,
                        end: 20.w,
                      ),
                      child: CustomButton(
                          text: 'Reset Password',
                          onPress: passwordViewModel.resetPassword),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
