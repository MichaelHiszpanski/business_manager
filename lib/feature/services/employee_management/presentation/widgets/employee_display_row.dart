import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:flutter/material.dart';

class EmployeeDisplayRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final TextStyle? textStyle;

  const EmployeeDisplayRow({
    super.key,
    required this.icon,
    required this.text,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 32,
          color: Pallete.gradient2,
        ),
        const SizedBox(width: Constants.padding16),
        Expanded(
          child: Text(
            text,
            style: textStyle ??
                Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
