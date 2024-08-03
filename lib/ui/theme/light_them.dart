import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class LightTheme {
  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: const Color(0xFFFFFFFF),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xF04BB5D2),
        primary: const Color(0xFF1F8CAB),
        secondary: const Color(0xFF0D3F48),
        background: const Color(0xFF5CBFD8),
        secondaryContainer: const Color(0xFFECEDED),
      ),
      textTheme: TextTheme(
          labelMedium: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 24.sp,
              fontWeight: FontWeight.w600),
          labelSmall: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 16.sp,
          ),
          labelLarge: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 26.sp,
          )));
}
