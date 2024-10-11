import 'package:flutter/material.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dissertation_project_app/core/tools/constants.dart';

extension BuildContextExtension on BuildContext {
  double get deviceHeight => MediaQuery.of(this).size.height;

  double get deviceWidth => MediaQuery.of(this).size.width;

  // AppLocalizations get strings => AppLocalizations.of(this);

  bool get isMobile => MediaQuery.of(this).size.width < Constants.MOBILE_WIDTH;

  bool get isTablet => MediaQuery.of(this).size.width >= Constants.MOBILE_WIDTH;

  double get workspaceHeight {
    final screenHeight = MediaQuery.of(this).size.height;
    final basicAppBarHeight = MediaQuery.of(this).padding.top + kToolbarHeight;
    final basicBottomBarHeight =
        MediaQuery.of(this).padding.bottom + kBottomNavigationBarHeight;
    return screenHeight - basicAppBarHeight - basicBottomBarHeight;
  }

  void navigateBackSafe() {
    if (Navigator.of(this).canPop()) Navigator.of(this).pop();
  }
}
