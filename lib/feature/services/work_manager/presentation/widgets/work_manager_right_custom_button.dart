import 'dart:math';

import 'package:business_manager/core/widgets/containers/animated_item_container/animated_item_container.dart';
import 'package:business_manager/feature/services/work_manager/presentation/widgets/custom_box_decoration.dart';
import 'package:flutter/material.dart';

class WorkManagerRightCustomButton extends StatefulWidget {
  final Function(int) onItemClicked;
  const WorkManagerRightCustomButton({super.key, required this.onItemClicked});

  @override
  State<WorkManagerRightCustomButton> createState() =>
      _WorkManagerRightCustomButtonState();
}

class _WorkManagerRightCustomButtonState
    extends State<WorkManagerRightCustomButton>
    with SingleTickerProviderStateMixin {
  bool toggleButton = true;
  late AnimationController _controller;
  late Animation _animation;
  bool isClickable = true;
  bool isClickedToNavigate = false;
  Alignment defaultAlignment = const Alignment(1, 1);
  late Alignment alignment1;
  late Alignment alignment2;
  late Alignment alignment3;
  double size1 = 50.0;
  double size2 = 50.0;
  double size3 = 50.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration:const Duration(milliseconds: 300),
        reverseDuration:const Duration(milliseconds: 250));

    _animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn);

    _controller.addListener(() {
      setState(() {});
    });
    alignment1 = alignment2 = alignment3 = defaultAlignment;
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250.0,
        width: 250.0,
        child: Stack(
          children: [
            if (!toggleButton)
              AnimatedItemContainer(
                minDuration: 275,
                maxDuration: 875,
                icon: Icons.message,
                alignment: alignment1,
                toggleButton: toggleButton,
                size: toggleButton ? 0 : size1,
                onTap: () => _onTap(0),
                backgroundColor: Colors.red,
              ),
            if (!toggleButton)
              AnimatedItemContainer(
                minDuration: 275,
                maxDuration: 875,
                icon: Icons.phone,
                alignment: alignment2,
                toggleButton: toggleButton,
                size: toggleButton ? 0 : size2,
                onTap: () => _onTap(1),
                backgroundColor: Colors.orange,
              ),
            if (!toggleButton)
              AnimatedItemContainer(
                minDuration: 275,
                maxDuration: 875,
                icon: Icons.camera,
                alignment: alignment3,
                toggleButton: toggleButton,
                size: toggleButton ? 0 : size3,
                onTap: () => _onTap(2),
                backgroundColor: Colors.yellow,
              ),
            Align(
              alignment: defaultAlignment,
              child: Transform.rotate(
                angle: _animation.value * pi * (3 / 4),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 375),
                  curve: Curves.easeOut,
                  height: toggleButton ? 70.0 : 60.0,
                  width: toggleButton ? 70.0 : 60.0,
                  decoration: CustomBoxDecorations.customDecoration(),
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      splashColor: Colors.orange[400],
                      splashRadius: 32.0,
                      onPressed: isClickable
                          ? () {
                              setState(() {
                                _onTap(999);
                              });
                            }
                          : null,
                      icon: const Icon(
                        Icons.add_comment,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  void _onTap(int index) {
    {
      if (!isClickable) return;

      setState(() {
        isClickable = false;
        isClickedToNavigate = true;
      });

      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          isClickable = true;
          isClickedToNavigate = false;
        });
      });

      switch (index) {
        case 0:
          widget.onItemClicked(0);
          break;
        case 1:
          widget.onItemClicked(1);
          break;
        case 2:
          widget.onItemClicked(2);
          break;
        case 999:
          break;
        default:
      }
      if (toggleButton) {
        toggleButton = !toggleButton;
        _controller.forward();
        Future.delayed(const Duration(milliseconds: 100), () {
          alignment1 = const Alignment(0.9, 0.0);
          size1 = 50.0;
        });
        Future.delayed(const Duration(milliseconds: 200), () {
          alignment2 = const Alignment(0.0, 0.2);
          size2 = 50.0;
        });
        Future.delayed(const Duration(milliseconds: 300), () {
          alignment3 = const Alignment(0.0, 1);
          size3 = 50.0;
        });
      } else {
        toggleButton = !toggleButton;
        _controller.reverse();
        alignment1 = alignment2 = alignment3 = defaultAlignment;

        size1 = size2 = size3 = 20.0;
      }
    }
  }
}
