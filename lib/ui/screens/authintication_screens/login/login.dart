import 'package:arab_conversation/di/di.dart';
import 'package:arab_conversation/ui/dialogs/dialog.dart';
import 'package:arab_conversation/ui/screens/authintication_screens/forget_password/forget_password.dart';
import 'package:arab_conversation/ui/screens/authintication_screens/login/login_cubit/login_cubit.dart';
import 'package:arab_conversation/ui/screens/authintication_screens/login/login_cubit/login_state.dart';
import 'package:arab_conversation/ui/screens/authintication_screens/register/register.dart';
import 'package:arab_conversation/ui/screens/tabs/home.dart';
import 'package:arab_conversation/ui/shared_widgets/custom_button.dart';
import 'package:arab_conversation/ui/shared_widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  static const String route = 'loginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var loginViewModel = getIt.get<LoginViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: BlocProvider(
            create: (context) => loginViewModel,
            child: BlocConsumer<LoginViewModel, LoginStates>(
              listener: (context, state) {
                if (state is Loading) {
                  loadingDialog(context);
                }
                else if (state is Success) {
                  closeDialog(context);
                  Navigator.pushReplacementNamed(context, Home.route);
                }
                else if (state is Error) {
                  closeDialog(context);
                  showCustomDialog(
                    context,
                    icon: Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 35.sp,
                    ),
                    content: Text(
                      state.error,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Color(0xFF7D848D), fontSize: 16),
                    ),
                    negative: () {
                      Navigator.pop(context);
                    },
                    negativeText: 'ok',
                  );
                }
              },
              builder: (context, state) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Login',
                    style: Theme.of(context).textTheme.labelMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Expanded(child: Image.asset('assets/images/login.png')),
                  SizedBox(
                    height: 27.h,
                  ),
                  Expanded(
                      flex: 3,
                      child: Form(
                        key: loginViewModel.formKey,
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.symmetric(horizontal: 16),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  controller: loginViewModel.email,
                                  validFunction: loginViewModel.validEmail,
                                  hint: 'Enter your email',
                                  label: 'Email',
                                  top: 29.31.h,
                                ),
                                CustomTextFormField(
                                  controller: loginViewModel.password,
                                  validFunction: loginViewModel.validPassword,
                                  label: 'Password',
                                  top: 24.h,
                                  bottom: 8.h,
                                  isPassword: !loginViewModel.showPassword,
                                  icon: IconButton(
                                    onPressed: () {
                                      loginViewModel.changeVisibility();
                                    },
                                    icon: Icon(
                                      loginViewModel.passwordEye,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Expanded(
                                        child: SizedBox(
                                      width: double.infinity,
                                    )),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, ForgetPassword.route);
                                      },
                                      child: Text(
                                        'Forget password ?',
                                        style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 12.sp,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(top: 16.h),
                                  child: CustomButton(
                                      text: "Login",
                                      onPress: () {
                                        loginViewModel.login();
                                      }),
                                ),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelSmall,
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
                                  onTap: (){
                                     loginViewModel.loginWithGoogle();
                                  },
                                  child: Container(
                                    width: 320.w,
                                    padding: EdgeInsetsDirectional.symmetric(
                                        vertical: 11.h),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade400,
                                            width: 1),
                                        borderRadius: BorderRadius.circular(4)),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w600),
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
                                      'Don’t have an account ?',
                                      style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 12.sp),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushReplacementNamed(
                                            context, Registration.route);
                                      },
                                      child: Text(
                                        'Sign Up',
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
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
