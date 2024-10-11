import 'package:flutter/material.dart';

class AnimatedItemContainerSideMenu extends StatefulWidget {
  final int minDuration;
  final int maxDuration;
  final IconData icon;
  final Alignment alignment;
  final bool toggleButton;
  final double size;
  final Function onTap;
  final Color color;

  const AnimatedItemContainerSideMenu({
    Key? key,
    required this.minDuration,
    required this.maxDuration,
    required this.icon,
    required this.alignment,
    required this.toggleButton,
    required this.size,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  @override
  _AnimatedItemContainerSideMenuState createState() =>
      _AnimatedItemContainerSideMenuState();
}

class _AnimatedItemContainerSideMenuState
    extends State<AnimatedItemContainerSideMenu> {
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      isExpanded = widget.toggleButton;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return AnimatedAlign(
      duration: widget.toggleButton
          ? Duration(milliseconds: widget.minDuration)
          : Duration(milliseconds: widget.maxDuration),
      alignment: widget.alignment,
      curve: widget.toggleButton ? Curves.easeIn : Curves.elasticOut,
      child: GestureDetector(
        onTap: () {
          widget.onTap();
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(seconds: 2),
          curve: Curves.easeOutExpo,
          // duration: const Duration(microseconds: 300),
          // curve: widget.toggleButton ? Curves.easeIn : Curves.easeOut,
          height: widget.size, //isExpanded ? screenSize.height : widget.size,
          width: widget.size, //isExpanded ? screenSize.width : widget.size,
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(80.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10.0,
                offset: Offset(4, 4),
              ),
            ],
          ),
          child: Icon(
            widget.icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
