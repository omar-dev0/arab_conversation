import 'package:arab_conversation/di/di.dart';
import 'package:arab_conversation/ui/dialogs/dialog.dart';
import 'package:arab_conversation/ui/screens/authintication_screens/login/login.dart';
import 'package:arab_conversation/ui/screens/authintication_screens/register/register_cubit/register_cubit.dart';
import 'package:arab_conversation/ui/screens/authintication_screens/register/register_cubit/register_state.dart';
import 'package:arab_conversation/ui/screens/tabs/home.dart';
import 'package:arab_conversation/ui/shared_widgets/custom_button.dart';
import 'package:arab_conversation/ui/shared_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Registration extends StatefulWidget {
  static const String route = 'registerScreen';

  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  var registerViewModel = getIt.get<RegisterViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 16.h,
              ),
              Text(
                'Registration',
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              BlocProvider(
                create: (context) => registerViewModel,
                child: BlocConsumer<RegisterViewModel, RegisterStates>(
                  listener: (context, state) {
                    if (state is Loading) {
                      loadingDialog(context);
                    }
                    else if (state is Success) {
                      closeDialog(context);
                      showCustomDialog(context,
                          icon: CircleAvatar(
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
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
                            'We send email to your account to verify your account',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color(0xFF7D848D), fontSize: 16),
                          ),
                          positiveText: 'Ok', positive: () {
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.route);
                      });
                    }
                    else if (state is Error) {
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
                            style: const TextStyle(
                                color: Color(0xFF7D848D), fontSize: 16),
                          ));
                    }
                    else if (state is SuccessWithGoogle)
                      {
                        Navigator.pushReplacementNamed(context, Home.route);
                      }
                  },
                  builder: (context, state) => Padding(
                    padding: EdgeInsetsDirectional.only(
                        start: 16.w, end: 16.w, top: 67.h),
                    child: Form(
                      key: registerViewModel.formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            hint: 'Enter your name',
                            controller: registerViewModel.name,
                            validFunction: registerViewModel.validName,
                            label: 'Name',
                            bottom: 24.h,
                          ),
                          CustomTextFormField(
                            hint: 'Enter your Email',
                            controller: registerViewModel.email,
                            validFunction: registerViewModel.validEmail,
                            label: 'Email',
                            bottom: 24.h,
                          ),
                          CustomTextFormField(
                            hint: '************',
                            controller: registerViewModel.password,
                            validFunction: registerViewModel.validPassword,
                            label: 'Password',
                            bottom: 24.h,
                            icon: IconButton(
                              onPressed: registerViewModel.changeVisibility,
                              icon: Icon(registerViewModel.passwordEye),
                            ),
                            isPassword: !registerViewModel.showPassword,
                          ),
                          CustomTextFormField(
                            hint: '************',
                            controller: registerViewModel.confirmPassword,
                            validFunction:
                                registerViewModel.validConfirmPassword,
                            label: 'confirm password',
                            bottom: 24.h,
                            icon: IconButton(
                              onPressed: registerViewModel.changeVisibility,
                              icon: Icon(registerViewModel.passwordEye),
                            ),
                            isPassword: !registerViewModel.showPassword,
                          ),
                          SizedBox(
                            height: 50.h,
                          ),
                          CustomButton(
                              text: 'Sign Up',
                              onPress: registerViewModel.register),
                          SizedBox(
                            height: 24.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                color: Colors.grey.shade300,
                                width: 100.w,
                                height: 2.h,
                              ),
                              SizedBox(
                                width: 14.w,
                              ),
                              Text(
                                'OR',
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                              SizedBox(
                                width: 14.w,
                              ),
                              Container(
                                color: Colors.grey.shade300,
                                width: 100.w,
                                height: 2.h,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 24.h,
                          ),
                          InkWell(
                            onTap: () {
                              registerViewModel.loginWithGoogle();
                            },
                            child: Container(
                              width: 320.w,
                              padding: EdgeInsetsDirectional.symmetric(
                                  vertical: 11.h),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade400, width: 1),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset('assets/icons/google.png'),
                                  SizedBox(
                                    width: 16.w,
                                  ),
                                  Text(
                                    'Continue with Google',
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'already have an account ?',
                                style: TextStyle(
                                    color: Colors.grey.shade500,
                                    fontSize: 12.sp),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                      context, LoginScreen.route);
                                },
                                child: Text(
                                  'login',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
