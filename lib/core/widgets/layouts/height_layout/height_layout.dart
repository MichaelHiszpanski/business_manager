import 'package:business_manager/core/tools/constants.dart';
import 'package:flutter/material.dart';

class HeightLayout extends StatelessWidget {
  final Widget childWidget;

  const HeightLayout({
    super.key,
    required this.childWidget,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(Constants.padding16),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: constraints.maxHeight,
          ),
          child: IntrinsicHeight(
            child: Padding(
              padding: const EdgeInsets.all(Constants.padding16),
              child: childWidget,
            ),
          ),
        ),
      );
    });
  }
}
