import 'package:business_manager/core/tools/constants.dart';
import 'package:flutter/material.dart';

class CenterColumnLayout extends StatelessWidget {
  final List<Widget> children;

  const CenterColumnLayout({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: MediaQuery.of(context).size.height,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(Constants.padding16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: children,
            ),
          ),
        ),
      ),
    );
  }
}
