import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.greenAccent,
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.white,
    )
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all<TextStyle>(
        GoogleFonts.bebasNeue(
          fontSize: 14,
          letterSpacing: 2,
          fontWeight: FontWeight.w500,
        )
      )
    )
  )
);