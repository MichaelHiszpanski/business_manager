import "dart:math" show pi;
import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget? child;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const GradientContainer({
    super.key,
    this.child,
    this.height,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green[300] ?? Colors.green,
            Colors.red[300] ?? Colors.red,
          ],
          stops: const [0, 0.7],
          transform: const GradientRotation(pi / 2),
        ),
        borderRadius: borderRadius,
      ),
      padding: padding,
      child: child,
    );
  }
}
