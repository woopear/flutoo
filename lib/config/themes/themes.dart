import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woo_theme_mode/woo_theme_mode.dart';

// proprieter pour theme claire
final themeClair = WooTheme.modeClair(
  scaffolBackground: Colors.white,
  primary: const Color(0xFF8000FF),
  secondary: const Color(0xFF0066FF),
  tertiary: const Color(0xFFDCDCDC),

  /// text
  tbodyPrincipal: GoogleFonts.indieFlower(),
  tbodySecondaire: GoogleFonts.indieFlower(),
  tPrincipalBoxDialogue: GoogleFonts.indieFlower(),
  tButton: GoogleFonts.indieFlower(),
  tBoxDialogue: GoogleFonts.indieFlower(),
  t1: GoogleFonts.indieFlower(),
  t2: GoogleFonts.indieFlower(),
  t3: GoogleFonts.indieFlower(),
  t4: GoogleFonts.indieFlower(),
  textButtonStyle: ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle?>(
      GoogleFonts.indieFlower(),
    ),
  ),

  /// checklist
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all<Color?>(Colors.green),
    fillColor: MaterialStateProperty.all<Color?>(
        const Color.fromARGB(255, 236, 236, 236)),
    side: const BorderSide(color: Color.fromARGB(255, 43, 43, 43)),
  ),

  /// elveted button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder?>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      foregroundColor: MaterialStateProperty.all<Color?>(Colors.white),
      textStyle: MaterialStateProperty.all<TextStyle?>(
        const TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
        const EdgeInsets.only(
          top: 15.0,
          bottom: 15.0,
          left: 20.0,
          right: 20.0,
        ),
      ),
    ),
  ),

  /// input
  inputDecorationTheme: const InputDecorationTheme(
    isDense: true,
    contentPadding:
        EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30.0, right: 20.0),
    isCollapsed: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(50.0),
      ),
    ),
  ),

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

  /// text
  tbodyPrincipal: GoogleFonts.indieFlower(),
  tbodySecondaire: GoogleFonts.indieFlower(),
  tPrincipalBoxDialogue: GoogleFonts.indieFlower(),
  tButton: GoogleFonts.indieFlower(),
  tBoxDialogue: GoogleFonts.indieFlower(),
  t1: GoogleFonts.indieFlower(),
  t2: GoogleFonts.indieFlower(),
  t3: GoogleFonts.indieFlower(),
  t4: GoogleFonts.indieFlower(),
  textButtonStyle: ButtonStyle(
    textStyle: MaterialStateProperty.all<TextStyle?>(
      GoogleFonts.indieFlower(),
    ),
  ),

  /// checklist
  checkboxTheme: CheckboxThemeData(
    checkColor: MaterialStateProperty.all<Color?>(Colors.green),
    fillColor:
        MaterialStateProperty.all<Color?>(const Color.fromARGB(255, 0, 0, 0)),
    side: const BorderSide(color: Color.fromARGB(255, 235, 235, 235)),
  ),

  /// elveted button
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder?>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      foregroundColor: MaterialStateProperty.all<Color?>(Colors.white),
      textStyle: MaterialStateProperty.all<TextStyle?>(
        const TextStyle(
          fontSize: 18.0,
          color: Colors.white,
        ),
      ),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry?>(
        const EdgeInsets.only(
          top: 15.0,
          bottom: 15.0,
          left: 20.0,
          right: 20.0,
        ),
      ),
    ),
  ),

  /// input
  inputDecorationTheme: const InputDecorationTheme(
    isDense: true,
    contentPadding:
        EdgeInsets.only(top: 15.0, bottom: 15.0, left: 30.0, right: 20.0),
    isCollapsed: true,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(50.0),
      ),
    ),
  ),

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
