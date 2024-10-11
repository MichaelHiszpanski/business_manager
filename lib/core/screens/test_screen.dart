import 'package:flutter/material.dart';
import 'dart:math';

class RotatingCirclesScreen extends StatefulWidget {
  @override
  _RotatingCirclesScreenState createState() => _RotatingCirclesScreenState();
}

class _RotatingCirclesScreenState extends State<RotatingCirclesScreen> {
  double innerRotationAngle = 0.0;
  double outerRotationAngle = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            // Calculate rotation based on user's drag on the outer circle
            setState(() {
              outerRotationAngle += details.delta.dx * 0.01;
            });
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Outer ring
              Transform.rotate(
                angle: outerRotationAngle,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 8, color: Colors.blue),
                  ),
                ),
              ),
              // Inner circle
              GestureDetector(
                onTap: () {
                  setState(() {
                    // Rotate the small circle by 90 degrees when tapped
                    innerRotationAngle += pi / 2;
                  });
                },
                child: Transform.rotate(
                  angle: innerRotationAngle,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RotatingCirclesScreen(),
  ));
}
