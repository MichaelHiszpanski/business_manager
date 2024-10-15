import 'package:flutter/material.dart';

class CustomBoxDecorations {
  static BoxDecoration customDecoration({
    Color color = Colors.yellow,
    double borderRadius = 60.0,
    List<BoxShadow> boxShadow = const [
      BoxShadow(
        color: Colors.black45,
        spreadRadius: 2,
        blurRadius: 8,
        offset: Offset(2, 4),
      )
    ],
  }) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: boxShadow,
    );
  }
}
