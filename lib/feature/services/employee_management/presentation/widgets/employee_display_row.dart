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
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Column(

        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 36,
                color: Pallete.gradient2,
              ),
              const SizedBox(width: Constants.padding16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ' $label',
                    style: textStyle ??
                        Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: Colors.black),
                  ),
                  const SizedBox(width: Constants.padding8),
                  Text(
                    text,
                    style: textStyle ??
                        Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: Colors.black),
                  ),
                ],
              ),
            ],
          ),

        ],
      ),
    );
  }
}
