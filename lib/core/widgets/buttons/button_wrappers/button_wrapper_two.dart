import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:flutter/material.dart';

class ButtonWrapperTwo extends StatelessWidget {
  final Widget child;
  Color? startColor;
  Color? endColor;

  ButtonWrapperTwo({
    super.key,
    required this.child,
    this.startColor,
    this.endColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Constants.padding16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            startColor ?? Pallete.colorFive,
            endColor ?? Pallete.colorSix,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Pallete.colorFive.withOpacity(0.45),
            offset: const Offset(0, 4),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.circular(Constants.padding24),
      ),
      child: child,
    );
  }
}
