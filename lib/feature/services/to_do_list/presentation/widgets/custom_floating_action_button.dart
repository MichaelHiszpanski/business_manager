import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final String heroTag;
  final Color? backgroundColor;
  final Color? iconColor;

  const CustomFloatingActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.heroTag,
    this.backgroundColor,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: onPressed,
      backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
      child: Icon(icon, color: iconColor ?? Colors.white),
    );
  }
}
