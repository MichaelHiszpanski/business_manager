import 'package:business_manager/core/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onMenuPressed;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Pallete.colorSix,
      title: Text(
        title,
        style: const TextStyle(
          color: Pallete.colorOne,
          fontFamily: "Jaro",
          fontSize: 24,
        ),
      ),
      iconTheme: IconThemeData(
        color: Pallete.colorOne,
        size: 28,
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
        IconButton(
          icon: const Icon(
            Icons.menu,
            color: Pallete.colorOne,
          ),
          onPressed: onMenuPressed,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
