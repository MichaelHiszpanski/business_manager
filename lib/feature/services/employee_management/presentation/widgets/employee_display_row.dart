import 'package:auto_size_text/auto_size_text.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:flutter/material.dart';

class EmployeeDisplayRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final String label;
  final TextStyle? textStyle;

  const EmployeeDisplayRow({
    super.key,
    required this.icon,
    required this.text,
    required this.label,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: Constants.padding16, vertical: Constants.padding8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Constants.radius15),
        gradient: const LinearGradient(
          colors: [Pallete.colorTwo, Pallete.colorSeven],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            offset: const Offset(2, 2),
            blurRadius: 4,
          )
        ],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 65,
        child: Row(
          children: [
            Icon(
              icon,
              size: 32,
              color: Pallete.gradient1,
            ),
            const SizedBox(width: Constants.padding16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    ' $label',
                    style: textStyle ??
                        Theme.of(context).textTheme.labelLarge?.copyWith(
                              color: Pallete.gradient1,
                              fontWeight: FontWeight.w600,
                            ),
                  ),
                  const SizedBox(width: Constants.padding4),
                  AutoSizeText(
                    text,
                    style: textStyle ??
                        Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.black),
                    maxLines: 2,
                    minFontSize: 6,
                    overflowReplacement: Text(text),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
