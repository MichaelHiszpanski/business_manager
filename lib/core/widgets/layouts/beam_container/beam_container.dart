import 'package:business_manager/core/tools/constants.dart';
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
      reverseDuration: const Duration(seconds: 10),
    )..repeat(reverse: true);
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
                    width: MediaQuery.of(context).size.width * 0.35,
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      color:Colors.black87,// Colors.blue.shade800,
                      borderRadius: BorderRadius.circular(Constants.radius40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.shade300.withOpacity(0.5),
                          blurRadius: 50,
                          spreadRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            bool isHalfway = _controller.value > 0.40 &&
                                _controller.value < 0.50;
                            return Positioned(
                              top: MediaQuery.of(context).size.height * 0.1 +
                                  (_controller.value *
                                      MediaQuery.of(context).size.height *
                                      0.5),
                              left: MediaQuery.of(context).size.width * 0.1,
                              right: MediaQuery.of(context).size.width * 0.1,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isHalfway
                                      ? Colors.red.shade800
                                      : Colors.white60,
                                  boxShadow: [
                                    BoxShadow(
                                      color: isHalfway
                                          ? Colors.orange.shade500
                                          : Colors.white54,
                                      blurRadius: isHalfway ? 60 : 30,
                                      spreadRadius: isHalfway ? 50 : 10,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            bool isHalfway = _controller.value > 0.40 &&
                                _controller.value < 0.50;
                            return Positioned(
                              bottom: MediaQuery.of(context).size.height * 0.6 -
                                  ((_controller.value - 1).abs() *
                                      MediaQuery.of(context).size.height *
                                      0.5),
                              left: MediaQuery.of(context).size.width * 0.1,
                              right: MediaQuery.of(context).size.width * 0.1,
                              child: Container(
                                height: 60,
                                width: 60,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isHalfway
                                      ? Colors.red.shade800
                                      : Colors.white60,
                                  boxShadow: [
                                    BoxShadow(
                                      color: isHalfway
                                          ? Colors.orange.shade500
                                          : Colors.white54,
                                      blurRadius: isHalfway ? 60 : 30,
                                      spreadRadius: isHalfway ? 50 : 10,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
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
