import 'package:business_manager/core/theme/app_font_family.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final Color backgroundColor;

  const CustomFloatingButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all<Color>(backgroundColor),
          padding: WidgetStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 8.0,
            ),
          ),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.padding24),
            ),
          ),
          textStyle: WidgetStateProperty.all<TextStyle>(
            const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: AppFontFamily.orbitron,
            ),
          ),
        ),
        child: Text(
          buttonText,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
