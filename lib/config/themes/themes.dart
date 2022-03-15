import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:woo_theme_mode/woo_theme_mode.dart';

// proprieter pour theme claire
final themeClair = WooTheme.modeClair(
  scaffolBackground: Colors.white,
  primary: const Color(0xFFB7CE63),
  secondary: const Color(0xFFC7D59F),
  tertiary: const Color(0xFFDADDD8),
  appBarTheme: AppBarTheme(
    titleTextStyle: GoogleFonts.indieFlower(
      fontSize: 30.0,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
  ),
);

// proprieter pour theme dark
final themeDark = WooTheme.modeDark(
  scaffolBackground: const Color.fromARGB(255, 49, 49, 49),
  primary: const Color(0xFFebff93),
  secondary: const Color(0xFFfaffd0),
  tertiary: const Color(0xFFDADDD8),
  appBarTheme: AppBarTheme(
    titleTextStyle: GoogleFonts.indieFlower(
      fontSize: 30.0,
      fontWeight: FontWeight.bold,
    ),
    backgroundColor: const Color(0xFFebff93),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
  ),
);
