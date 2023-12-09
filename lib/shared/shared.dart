import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color backgroundColour = const Color(0xFFFFF9E8);
Color primaryColour = const Color(0xFFF8D038);
Color secondaryColour = const Color(0xFFFFEFCA);
Color tertiaryColour = const Color(0xFFC29B17);
Color blackColour = const Color(0xFF1B3D2F);
Color whiteColour = Colors.white;
Gradient gradient = const LinearGradient(
  colors: [
    Color(0xffe9cf25),
    Color(0xffdda90e),
    Color(0xffbe7521),
    Color(0xff995507)
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

// Color(0xFFFDFCF9)
// Color(0xFFA08F65)

TextStyle defaultText = GoogleFonts.poppins(
    fontSize: 36, color: blackColour, fontWeight: FontWeight.w500);
