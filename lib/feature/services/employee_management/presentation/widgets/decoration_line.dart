import 'package:flutter/material.dart';

class DecorationLine extends StatelessWidget {
  final Color lineColor;

  const DecorationLine({
    super.key,
    required this.lineColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 1,
      color: lineColor,
    );
  }
}
