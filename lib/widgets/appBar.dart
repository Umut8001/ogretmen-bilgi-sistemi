import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StdWidgets {
  static AppBar standartAppBar(String title, Color color) {
    return AppBar(
      iconTheme: IconThemeData(color: color),
      backgroundColor: Colors.transparent,
      title: Text(
        title,
        style: GoogleFonts.kanit(fontWeight: FontWeight.bold, color: color),
      ),
    );
  }
}
