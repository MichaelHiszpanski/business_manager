import 'dart:math';

import 'package:dissertation_project_app/core/widgets/containers/animated_item_container/animated_item_container_side_menu.dart';
import 'package:dissertation_project_app/main.dart';
import 'package:dissertation_project_app/core/main_utils/app_routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSideButtonMenu extends StatefulWidget {
  const CustomSideButtonMenu({super.key});

  @override
  State<CustomSideButtonMenu> createState() => _CustomSideButtonMenuState();
}

class _CustomSideButtonMenuState extends State<CustomSideButtonMenu>
    with SingleTickerProviderStateMixin {
  bool toggleButton = true;
  late AnimationController _controller;
  late Animation _animation;
  bool isClickable = true;
  bool isClickedToNavigate = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      reverseDuration: Duration(milliseconds: 250),
    );

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

  Alignment alignment1 = Alignment(-1.0, 0.0);
  Alignment alignment2 = Alignment(-1.0, 0.0);
  Alignment alignment3 = Alignment(-1.0, 0.0);
  Alignment alignment4 = Alignment(-1.0, 0.0);
  Alignment alignment5 = Alignment(-1.0, 0.0);
  double size1 = 50.0;
  double size2 = 50.0;
  double size3 = 80.0;
  double size4 = 80.0;
  double size5 = 80.0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Align(
      alignment: Alignment.centerLeft, // const Alignment(-1.0, 0.0),
      child: Container(
        height: 450.0, // screenSize.height, //
        width: screenSize.width,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Stack(
          children: [
            AnimatedItemContainerSideMenu(
              key: Key('icon1'),
              minDuration: 275,
              maxDuration: 875,
              icon: Icons.message,
              alignment: alignment1,
              toggleButton: toggleButton,
              size: size1,
              onTap: () {
                _onTap(0);
              },
              color: Colors.red[400] ?? Colors.red,
            ),
            AnimatedItemContainerSideMenu(
                key: Key('icon2'),
                minDuration: 275,
                maxDuration: 875,
                icon: Icons.phone,
                alignment: alignment2,
                toggleButton: toggleButton,
                size: size1,
                onTap: () {
                  // MainApp.navigatorKey.currentState!
                  //     .pushNamed(AppRoutes.homePage);
                  _onTap(1);
                },
                color: Colors.green[400] ?? Colors.green),
            AnimatedItemContainerSideMenu(
              key: Key('icon3'),
              minDuration: 275,
              maxDuration: 875,
              icon: Icons.computer,
              alignment: alignment3,
              toggleButton: toggleButton,
              size: size1,
              onTap: () {
                // MainApp.navigatorKey.currentState!
                //     .pushNamed(AppRoutes.weatherPage);
                _onTap(2);
              },
              color: Colors.blue[400] ?? Colors.blue,
            ),
            AnimatedItemContainerSideMenu(
              key: Key('icon4'),
              minDuration: 275,
              maxDuration: 675,
              icon: Icons.today,
              alignment: alignment4,
              toggleButton: toggleButton,
              size: size1,
              onTap: () {
                // MainApp.navigatorKey.currentState!
                //     .pushNamed(AppRoutes.weatherPage);
                _onTap(3);
              },
              color: Colors.yellow[400] ?? Colors.yellow,
            ),
            AnimatedItemContainerSideMenu(
              key: Key('icon5'),
              minDuration: 520,
              maxDuration: 675,
              icon: Icons.shop,
              alignment: alignment5,
              toggleButton: toggleButton,
              size: size1,
              onTap: () {
                // MainApp.navigatorKey.currentState!
                //     .pushNamed(AppRoutes.weatherPage);
                _onTap(4);
              },
              color: Colors.orange[400] ?? Colors.orange,
            ),
            Align(
              alignment: Alignment.centerLeft, // Alignment.center,
              child: Transform.translate(
                offset: Offset(-85.0, 0.0),
                child: Transform.rotate(
                  angle: _animation.value * pi * (3 / 4),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 1675),
                    curve: Curves.easeOut,
                    height:
                        // isClickedToNavigate
                        //     ? screenSize.height
                        // :
                        toggleButton ? 300.0 : 160.0,
                    width:
                        //  isClickedToNavigate
                        //     ? screenSize.width
                        //     :
                        toggleButton ? 300.0 : 160.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent, //blue[600],
                      borderRadius:
                          // isClickedToNavigate
                          //     ? BorderRadius.circular(0)
                          //     :
                          BorderRadius.circular(300.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          blurRadius: 10.0,
                          offset: Offset(8, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      animationDuration: Duration(milliseconds: 675),
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
                        icon: Image.asset(
                          "assets/images/earth.png",
                          height: 280.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
    //   ),
    // );
  }

  void _onTap(int iconIndex) {
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

    switch (iconIndex) {
      case 0:
        MainApp.navigatorKey.currentState!.pushNamed(AppRoutes.toDoPage);
        print("Icon 0 (Message) tapped");
        break;
      case 1:
        MainApp.navigatorKey.currentState!
            .pushNamed(AppRoutes.loadAppDataScreen);
        print("Icon 1 (Phone) tapped");
        break;
      case 2:
        MainApp.navigatorKey.currentState!.pushNamed(AppRoutes.testScreen);
        print("Icon 2 (Computer) tapped");
        break;
      case 3:
        MainApp.navigatorKey.currentState!
            .pushNamed(AppRoutes.workManagerScreen);
        print("Icon 3 (Today) tapped");
        break;
      case 4:
        print("Icon 4 (Shop) tapped");
        break;
      case 999:
        print("Icon 999 (Shop) tapped");
        break;
      default:
        print("Unknown icon tapped");
    }
    if (toggleButton) {
      toggleButton = !toggleButton;
      _controller.forward();
      Future.delayed(const Duration(milliseconds: 100), () {
        alignment1 = const Alignment(-0.8, -1.0);
        size1 = 50.0;
      });
      Future.delayed(const Duration(milliseconds: 150), () {
        alignment2 = const Alignment(0.4, -0.8);
        size2 = 50.0;
      });
      Future.delayed(const Duration(milliseconds: 200), () {
        alignment3 = const Alignment(0.8, 0.0);
        size3 = 50.0;
      });
      Future.delayed(const Duration(milliseconds: 250), () {
        alignment4 = const Alignment(0.4, 0.8);
        size3 = 50.0;
      });
      Future.delayed(const Duration(milliseconds: 300), () {
        alignment5 = const Alignment(-0.8, 1.0);
        size3 = 50.0;
      });
    } else {
      toggleButton = !toggleButton;
      _controller.reverse();

      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          alignment1 = alignment2 =
              alignment3 = alignment4 = alignment5 = const Alignment(-1.0, 0.0);
          size1 = size2 = size3 = size4 = size5 = 20.0;
        });
      });
    }
  }
}
