import "dart:math" show pi;
import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget? child;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const GradientContainer({
    this.child,
    this.height,
    this.padding,
    this.borderRadius,
    key,
  }) : super(key: key);

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
          stops: [0, 0.7],
          transform: GradientRotation(pi / 2),
        ),
        borderRadius: borderRadius,
      ),
      padding: padding,
      child: child,
    );
  }
}
