import 'dart:math';

import 'package:dissertation_project_app/core/widgets/containers/animated_item_container/animated_item_container.dart';
import 'package:dissertation_project_app/main.dart';
import 'package:dissertation_project_app/core/main_utils/app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomFloatingButton extends StatefulWidget {
  const CustomFloatingButton({super.key});

  @override
  State<CustomFloatingButton> createState() => _CustomFloatingButtonState();
}

class _CustomFloatingButtonState extends State<CustomFloatingButton>
    with SingleTickerProviderStateMixin {
  bool toggleButton = false;
  late AnimationController _controller;
  late Animation _animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 300),
        reverseDuration: Duration(milliseconds: 250));

    _animation = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
        reverseCurve: Curves.easeIn);

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  Alignment alignment1 = Alignment(1.0, 1.0);
  Alignment alignment2 = Alignment(1.0, 1.0);
  Alignment alignment3 = Alignment(1.0, 1.0);
  double size1 = 50.0;
  double size2 = 50.0;
  double size3 = 50.0;
  @override
  Widget build(BuildContext context) {
    return
        //  Container(
        //   height: 300.0, //double.infinity, //MediaQuery.of(context).size.height,
        //   width: double.infinity, //MediaQuery.of(context).size.width,
        //   child: Center(
        // child:
      //   Align(
      // alignment: const Alignment(1.0, 1.0),
      // child:
      Container(
        height: 250.0,
        width: 250.0,
        child:
        Stack(
          children: [
            AnimatedItemContainer(
              minDuration: 275,
              maxDuration: 875,
              icon: Icons.message,
              alignment: alignment1,
              toggleButton: toggleButton,
              size: size1,
              onTap: () {
                MainApp.navigatorKey.currentState!
                    .pushNamed(AppRoutes.toDoPage);
              },
            ),
            AnimatedItemContainer(
              minDuration: 275,
              maxDuration: 875,
              icon: Icons.phone,
              alignment: alignment2,
              toggleButton: toggleButton,
              size: size2,
              onTap: () {
                MainApp.navigatorKey.currentState!
                    .pushNamed(AppRoutes.homePage);
              },
            ),
            AnimatedItemContainer(
              minDuration: 275,
              maxDuration: 875,
              icon: Icons.camera,
              alignment: alignment3,
              toggleButton: toggleButton,
              size: size3,
              onTap: () {
                MainApp.navigatorKey.currentState!
                    .pushNamed(AppRoutes.weatherPage);
              },
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Transform.rotate(
                angle: _animation.value * pi * (3 / 4),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 375),
                  curve: Curves.easeOut,
                  height: toggleButton ? 70.0 : 60.0,
                  width: toggleButton ? 70.0 : 60.0,
                  decoration: BoxDecoration(
                    color: Colors.yellow[600],
                    borderRadius: BorderRadius.circular(60.0),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                        splashColor: Colors.orange[400],
                        splashRadius: 32.0,
                        onPressed: () {
                          setState(() {
                            if (toggleButton) {
                              toggleButton = !toggleButton;
                              _controller.forward();
                              Future.delayed(const Duration(milliseconds: 100),
                                  () {
                                alignment1 = const Alignment(1, -0.4);
                                size1 = 50.0;
                              });
                              Future.delayed(const Duration(milliseconds: 200),
                                  () {
                                alignment2 = const Alignment(0.1, 0.1);
                                size2 = 50.0;
                              });
                              Future.delayed(const Duration(milliseconds: 300),
                                  () {
                                alignment3 = const Alignment(0.0, 1);
                                size3 = 50.0;
                              });
                            } else {
                              toggleButton = !toggleButton;
                              _controller.reverse();
                              alignment1 = const Alignment(1.0, 1.0);
                              alignment2 = const Alignment(1.0, 1.0);
                              alignment3 = const Alignment(1.0, 1.0);
                              size1 = size2 = size3 = 20.0;
                            }
                          });
                        },
                        icon: Image.network(
                          "https://static-00.iconduck.com/assets.00/circle-cross-icon-512x512-xqrzmbe1.png",
                          height: 42.0,
                        )),
                  ),
                ),
              ),
            )
          ],
        )
      );
    // );
    //   ),
    // );
  }
}
