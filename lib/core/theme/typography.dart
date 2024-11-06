import 'package:flutter/material.dart';

TextTheme getTextTheme(Color defaultTextColor) {
  return TextTheme(
    displayMedium: TextStyle(
      fontSize: 24,
      height: 1.3,
      fontWeight: FontWeight.w500,
      color: defaultTextColor,
    ),
    displaySmall: TextStyle(
      fontSize: 18,
      height: 1.3,
      fontWeight: FontWeight.w500,
      color: defaultTextColor,
    ),
    headlineLarge: TextStyle(
      fontSize: 28,
      height: 1.2,
      fontWeight: FontWeight.w700,
      color: defaultTextColor,
    ),
    headlineMedium: TextStyle(
      fontSize: 20,
      height: 1.25,
      fontWeight: FontWeight.w700,
      color: defaultTextColor,
    ),
    headlineSmall: TextStyle(
      fontSize: 19,
      height: 1.25,
      fontWeight: FontWeight.w700,
      color: defaultTextColor,
    ),
    titleLarge: TextStyle(
      fontSize: 18,
      height: 1.25,
      fontWeight: FontWeight.w400,
      color: defaultTextColor,
    ),
    titleMedium: TextStyle(
      fontSize: 16,
      height: 1.25,
      fontWeight: FontWeight.w400,
      color: defaultTextColor,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      height: 1.25,
      fontWeight: FontWeight.w400,
      color: defaultTextColor,
    ),
    bodySmall: TextStyle(
      fontSize: 13,
      height: 1.2,
      fontWeight: FontWeight.w400,
      color: defaultTextColor,
    ),
    labelLarge: TextStyle(
      fontSize: 12,
      height: 1.2,
      fontWeight: FontWeight.w400,
      color: defaultTextColor,
    ),
    labelMedium: TextStyle(
      fontSize: 11,
      height: 1.2,
      fontWeight: FontWeight.w400,
      color: defaultTextColor,
    ),
    labelSmall: TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: defaultTextColor,
    ),
  );
}
