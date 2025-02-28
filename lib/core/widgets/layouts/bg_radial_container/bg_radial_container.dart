import 'package:business_manager/core/theme/colors.dart';
import 'package:flutter/material.dart';

class BgRadialContainer extends StatelessWidget {
  final Widget child;
  final List<Color>? colors;
  final double? radius;

  const BgRadialContainer({
    super.key,
    required this.child,
    this.colors,
    this.radius,
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
        gradient: RadialGradient(
          center: Alignment.center,
          radius: radius ?? 1,
          colors: colors ?? [Colors.white, Pallete.colorSix.withOpacity(0.55)],
          stops: stops,
        ),
      ),
      child: child,
    );
  }
}
