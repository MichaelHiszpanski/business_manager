import 'package:business_manager/core/theme/app_font_family.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onMenuPressed;
  final bool? isActionButtonAvailable;
  final Color titleFontColor;
  final Color iconArrowColor;
  final Color background;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onMenuPressed,
    this.isActionButtonAvailable = false,
    this.titleFontColor = Pallete.gradient1,
    this.iconArrowColor = Pallete.colorOne,
    this.background = Colors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: background,
      title: Text(
        title,
        style: TextStyle(
          color: titleFontColor,
          fontFamily: AppFontFamily.marker,
          fontSize: 24,
        ),
      ),
      iconTheme: IconThemeData(
        color: iconArrowColor,
        size: 30,
        shadows: [
          BoxShadow(
            color: Colors.black38.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      actions: [
        if (isActionButtonAvailable!) ...[
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Pallete.colorOne,
            ),
            onPressed: onMenuPressed,
          ),
        ]
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
