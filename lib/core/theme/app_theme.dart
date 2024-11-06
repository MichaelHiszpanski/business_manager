import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/theme/typography.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_font_family.dart';

ThemeData getAppTheme() {
  return ThemeData(
    fontFamily: AppFontFamily.suse,
    brightness: Brightness.light,
    primaryColor: Pallete.colorOne,
    scaffoldBackgroundColor: Pallete.whiteColor,
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      // primary: appColors.BRAND_PRIMARY,
      // onPrimary: appColors.UI_BASE_WHITE,
    ),
    textTheme: getTextTheme(Pallete.colorOne),
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
  );
}