import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woo_theme_mode/woo_theme_mode.dart';

// proprieter pour theme claire
final themeClair = WooTheme.modeClair(
  scaffolBackground: Colors.white,
  primary: const Color(0xFF8000FF),
  secondary: const Color(0xFF0066FF),
  tertiary: const Color(0xFFDCDCDC),

  /// bottom nav
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(
      color: Color(0xFF0066FF),
    ),
    showSelectedLabels: false,
    showUnselectedLabels: false,
    backgroundColor: Colors.white,
  ),

  /// appbar
  appBarTheme: AppBarTheme(
    titleTextStyle: GoogleFonts.indieFlower(
      fontSize: 30.0,
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
);

// proprieter pour theme dark
final themeDark = WooTheme.modeDark(
  scaffolBackground: const Color(0xFF292929),
  primary: const Color(0xFFBA4DFF),
  secondary: const Color(0xFF6B93FF),
  tertiary: const Color(0xFF292929),

  /// bottom nav
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedIconTheme: IconThemeData(
      color: Color(0xFF6B93FF),
    ),
    showSelectedLabels: false,
    showUnselectedLabels: false,
    backgroundColor: Color(0xFF292929),
  ),

  /// appbar
  appBarTheme: AppBarTheme(
    titleTextStyle: GoogleFonts.indieFlower(
      color: Colors.white,
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: const Color(0xFFBA4DFF),
    iconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
);
