import 'package:flutter/material.dart';

class ToolTipWrapper extends StatefulWidget {
  final Widget child;
  final String? message;

  const ToolTipWrapper({
    super.key,
    required this.child,
    this.message="test",
  });

  @override
  State<ToolTipWrapper> createState() => _ToolTipWrapperState();
}

class _ToolTipWrapperState extends State<ToolTipWrapper> {
  Key tooltipKey = UniqueKey();

  void refreshTooltip() {
    setState(() {
      tooltipKey = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: refreshTooltip,
      child: Tooltip(
        key: tooltipKey,
        message: widget.message,
        height: 62.0,
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        preferBelow: false,
        decoration: BoxDecoration(
          color: Colors.blueGrey[700],
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: const TextStyle(
          fontSize: 18.0,
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
        // waitDuration: const Duration(milliseconds: 500),
        showDuration: const Duration(seconds: 3),
        triggerMode: TooltipTriggerMode.longPress,
        // enableFeedback: true,
        child: widget.child,
      ),
    );
  }
}
