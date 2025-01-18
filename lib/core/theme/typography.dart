import 'package:business_manager/core/theme/colors.dart';
import 'package:flutter/material.dart';

import 'app_font_family.dart';

TextTheme getTextTheme(Color defaultTextColor) {
  return TextTheme(
    displayMedium: const TextStyle(
      fontSize: 22,
      height: 1.3,
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontFamily: AppFontFamily.orbitron,
    ),
    displaySmall: TextStyle(
      fontSize: 18,
      height: 1.3,
      fontWeight: FontWeight.w500,
      color: defaultTextColor,
    ),
    headlineLarge: const TextStyle(
      fontSize: 32,
      height: 1.2,
      fontWeight: FontWeight.w800,
      color: Pallete.colorOne,
      fontFamily: AppFontFamily.orbitron,
    ),
    headlineMedium: TextStyle(
      fontSize: 26,
      height: 1.25,
      fontWeight: FontWeight.w800,
      color: defaultTextColor,
      fontFamily: AppFontFamily.orbitron,
    ),
    headlineSmall: TextStyle(
      fontSize: 19,
      height: 1.25,
      fontWeight: FontWeight.w700,
      color: defaultTextColor,
      fontFamily: AppFontFamily.orbitron,
    ),
    titleLarge: TextStyle(
      fontSize: 24,
      height: 1.25,
      fontWeight: FontWeight.w600,
      color: defaultTextColor,
      fontFamily: AppFontFamily.orbitron,
    ),
    titleMedium: TextStyle(
      fontSize: 18,
      height: 1.25,
      fontWeight: FontWeight.w500,
      color: defaultTextColor,
      fontFamily: AppFontFamily.orbitron,
    ),
    titleSmall: TextStyle(
      fontSize: 14,
      height: 1.25,
      fontWeight: FontWeight.w500,
      color: defaultTextColor,
      fontFamily: AppFontFamily.orbitron,
    ),
    bodyMedium: const TextStyle(
      fontSize: 16,
      height: 1.25,
      fontWeight: FontWeight.bold,
      fontFamily: AppFontFamily.orbitron,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      fontSize: 14,
      height: 1.2,
      fontWeight: FontWeight.w400,
      color: defaultTextColor,
    ),
    labelLarge: TextStyle(
      fontSize: 14,
      height: 1.2,
      fontWeight: FontWeight.w400,
      color: defaultTextColor,
      fontFamily: AppFontFamily.suse,
    ),
    labelMedium: TextStyle(
      fontSize: 12,
      height: 1.2,
      fontWeight: FontWeight.w400,
      color: defaultTextColor,
      fontFamily: AppFontFamily.suse,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: defaultTextColor,
      fontFamily: AppFontFamily.suse,
    ),
  );
}
