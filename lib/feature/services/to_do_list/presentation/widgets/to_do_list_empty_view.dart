import 'dart:math' as math show pi;

import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:flutter/material.dart';

class ToDoListEmptyView extends StatefulWidget {
  const ToDoListEmptyView({super.key});

  @override
  State<ToDoListEmptyView> createState() => _ToDoListEmptyViewState();
}

class _ToDoListEmptyViewState extends State<ToDoListEmptyView>
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
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateY(math.pi * _controller.value * 2),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: Constants.padding16,
                vertical: Constants.padding8,
              ),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(Constants.radius20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.5),
                    blurRadius: 10.0,
                    offset: const Offset(4, 4),
                  ),
                ],
              ),
              child: Text(
                context.strings.to_do_list_empty_message,
                style: context.text.headlineMedium?.copyWith(
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
