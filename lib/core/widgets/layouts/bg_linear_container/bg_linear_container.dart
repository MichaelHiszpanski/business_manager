import 'package:business_manager/core/theme/colors.dart';
import 'package:flutter/material.dart';

class BgLinearContainer extends StatelessWidget {
  final Widget child;
  final List<Color>? colors;
  final Alignment? beginCustom;
  final Alignment? endCustom;

  const BgLinearContainer({
    super.key,
    required this.child,
    this.colors,
    this.beginCustom,
    this.endCustom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors ?? [Colors.white, Pallete.colorSix.withOpacity(0.55)],
          begin: beginCustom ?? Alignment.bottomLeft,
          end: endCustom ?? Alignment.topCenter,
        ),
      ),
      child: child,
    );
  }
}
