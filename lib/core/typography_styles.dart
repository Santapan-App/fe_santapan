import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TypographyStyles {
  static TextStyle regular(double fontSize, Color color) {
    return TextStyle(
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle medium(double fontSize, Color color) {
    return TextStyle(
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle semiBold(double fontSize, Color color) {
    return TextStyle(
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      color: color,
    );
  }

  static TextStyle bold(double fontSize, Color color) {
    return TextStyle(
      fontFamily: GoogleFonts.plusJakartaSans().fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: fontSize,
      color: color,
    );
  }
}
