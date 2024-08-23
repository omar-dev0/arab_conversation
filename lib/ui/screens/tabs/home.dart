import 'package:arab_conversation/ui/screens/tabs/home_screen/home_screen.dart';
import 'package:arab_conversation/ui/screens/tabs/profile_screen/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  static const String route = 'homeScreen';

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;
  List<Widget> screens = [const HomeScreen(),  Profile()];
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> items = [
      BottomNavigationBarItem(
          backgroundColor: Colors.white,
          label: '',
          icon: Container(
            padding: EdgeInsetsDirectional.only(
                start: 16.w, end: 16.w, top: 4.h, bottom: 4.h),
            decoration: BoxDecoration(
              color: index == 0
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                ImageIcon(
                  const AssetImage('assets/icons/home.png'),
                  color: index == 0 ? Colors.white : Colors.black,
                  size: 24,
                ),
                Text(
                  'Home',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: index == 0 ? Colors.white : Colors.black),
                ),
              ],
            ),
          )),
      BottomNavigationBarItem(
          backgroundColor: Colors.white,
          label: '',
          icon: Container(
            padding: EdgeInsetsDirectional.only(
                start: 16.w, end: 16.w, top: 4.h, bottom: 4.h),
            decoration: BoxDecoration(
              color: index == 1
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              children: [
                ImageIcon(
                  const AssetImage('assets/icons/person.png'),
                  color: index == 1 ? Colors.white : Colors.black,
                  size: 24,
                ),
                Text(
                  'Profile',
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: index == 1 ? Colors.white : Colors.black),
                ),
              ],
            ),
          )),
    ];
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/app_screen.png'),
              fit: BoxFit.cover)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: screens[index],
        bottomNavigationBar: BottomNavigationBar(
          items: items,
          backgroundColor: Colors.white,
          onTap: (selection) {
            setState(() {
              index = selection;
            });
          },
        ),
      ),
    );
  }
}
