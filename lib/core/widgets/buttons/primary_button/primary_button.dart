import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:business_manager/core/widgets/buttons/button_wrappers/button_wrapper_one.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final TextStyle? customStyle;
  final Color? shadowColor;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.customStyle,
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
        ),
        child: ButtonWrapperOne(
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
      ),
    );
  }
}
