import 'package:business_manager/core/theme/app_font_family.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/widgets/buttons/button_wrappers/button_wrapper_one.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Constants.padding24),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 6,
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
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: AppFontFamily.orbitron,
                    color: Colors.white,
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
