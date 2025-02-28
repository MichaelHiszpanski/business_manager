import 'package:business_manager/core/theme/colors.dart';
import 'package:flutter/material.dart';

class BgSweepContainer extends StatelessWidget {
  final Widget child;
  final List<Color>? colors;
  final double? startAngle;
  final double? endAngle;
  final Alignment? center;

  const BgSweepContainer({
    super.key,
    required this.child,
    this.colors,
    this.startAngle,
    this.endAngle,
    this.center,
  });

  @override
  Widget build(BuildContext context) {
    final gradientColors =
        colors ?? [Colors.white, Pallete.colorSix.withOpacity(0.55)];

    final stops = gradientColors.length > 1
        ? List.generate(gradientColors.length,
            (index) => index / (gradientColors.length - 1))
        : null;

    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: SweepGradient(
          center: center ?? Alignment.center,
          startAngle: startAngle ?? 0.0,
          endAngle: endAngle ?? 2 * 3.1415926535897932,
          colors: gradientColors,
          stops: stops,
        ),
      ),
      child: child,
    );
  }
}
