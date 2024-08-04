import 'package:arab_conversation/di/di.dart';
import 'package:arab_conversation/ui/app_cubit.dart';
import 'package:arab_conversation/ui/screens/authintication_screens/forget_password/forget_password.dart';
import 'package:arab_conversation/ui/screens/authintication_screens/login/login.dart';
import 'package:arab_conversation/ui/screens/authintication_screens/register/register.dart';
import 'package:arab_conversation/ui/screens/course_ccontent/course_content.dart';
import 'package:arab_conversation/ui/screens/listien_screen/listen_screen.dart';
import 'package:arab_conversation/ui/screens/tabs/home.dart';
import 'package:arab_conversation/ui/theme/light_them.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'bloc_observer.dart';
import 'firebase_options.dart';
Widget? firstScreen;
Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform);
  configureDependencies();
  firstScreen = await getIt.get<AppViewModel>().firstScreen();
  await getIt.get<AppViewModel>().getAvailableCourses();

  runApp(
    const MyApp(),
  );
  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, home) => MaterialApp(
        theme: LightTheme.lightTheme,
        home: home,
        debugShowCheckedModeBanner: false,
        routes: {
          Registration.route: (_) => Registration(),
          LoginScreen.route: (_) => LoginScreen(),
          ForgetPassword.route: (_) => const ForgetPassword(),
          Home.route: (_) => const Home(),
          CourseContent.route: (_) => CourseContent(),
          ListenScreen.route : (_)=>  ListenScreen(),
        },
      ),
      child: firstScreen,
    );
  }

}
