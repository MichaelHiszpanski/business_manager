import 'package:flutter/material.dart';
import 'dart:math' as math;

class BeamContainer extends StatefulWidget {
  final List<Widget> children;

  const BeamContainer({
    super.key,
    required this.children,
  });

  @override
  _BeamContainerState createState() => _BeamContainerState();
}

class _BeamContainerState extends State<BeamContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.blue.withOpacity(0.3),
                  Colors.white,
                ],
              ),
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.002)
                    ..rotateY(math.pi * _controller.value * 2),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade800,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.shade300.withOpacity(0.5),
                          blurRadius: 50,
                          spreadRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.children,
          ),
        ],
      ),
    );
  }
}