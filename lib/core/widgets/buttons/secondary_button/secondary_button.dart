import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final TextStyle? customStyle;
  final Color? backgroundColor;
  final Color? shadowColor;

  const SecondaryButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.customStyle,
    this.backgroundColor,
    this.shadowColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        constraints:
            const BoxConstraints(minHeight: Constants.BUTTON_MIN_HEIGHT),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Constants.padding24),
          boxShadow: [
            BoxShadow(
              color: shadowColor ?? Colors.orange.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
          color: backgroundColor ?? Pallete.gradient1,
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(Constants.padding24),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 32.0,
              vertical: 12.0,
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  buttonText,
                  style: customStyle ?? context.text.displayMedium,
                  maxLines: 1,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
