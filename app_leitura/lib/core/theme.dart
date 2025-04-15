import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Cores personalizadas
const Color primaryColor = Color(0xFF6A4C93);
const Color secondaryColor = Color(0xFF8A6FBE);
const Color accentColor = Color(0xFFFFA69E);
const Color backgroundLightColor = Color(0xFFF8F9FA);
const Color backgroundDarkColor = Color(0xFF2E294E);
const Color textColorLight = Color(0xFF444444);
const Color textColorDark = Color(0xFFF8F9FA);

final ThemeData appTheme = ThemeData(
  primaryColor: primaryColor,
  colorScheme: ColorScheme.light(
    primary: primaryColor,
    secondary: secondaryColor,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    surface: Colors.white,
    background: backgroundLightColor,
    error: Colors.redAccent,
  ),
  scaffoldBackgroundColor: backgroundLightColor,
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    displayLarge: GoogleFonts.poppins(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: textColorLight,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: textColorLight,
    ),
    bodyLarge: GoogleFonts.poppins(
      fontSize: 16,
      color: textColorLight,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      color: textColorLight,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  ),
  cardTheme: CardTheme(
    elevation: 3,
    shadowColor: primaryColor.withOpacity(0.3),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    clipBehavior: Clip.antiAlias,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      elevation: 3,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      textStyle: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      textStyle: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: primaryColor, width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.redAccent, width: 1.0),
    ),
    labelStyle: GoogleFonts.poppins(color: Colors.grey[700]),
  ),
  sliderTheme: SliderThemeData(
    activeTrackColor: primaryColor,
    inactiveTrackColor: primaryColor.withOpacity(0.2),
    thumbColor: accentColor,
    overlayColor: primaryColor.withOpacity(0.2),
    trackHeight: 4,
    thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 12),
    overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey.withOpacity(.2);
        }
        return primaryColor;
      },
    ),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
