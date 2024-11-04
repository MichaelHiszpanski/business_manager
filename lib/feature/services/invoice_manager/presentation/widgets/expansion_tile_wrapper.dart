import 'package:business_manager/core/tools/constants.dart';
import 'package:flutter/material.dart';

class ExpansionTileWrapper extends StatelessWidget {
  final List<Widget> children;

  const ExpansionTileWrapper({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.only(
          right: Constants.padding16,
        ),
        title: const Text(
          "Business Owner Details",
          style: TextStyle(
            fontFamily: 'Jaro',
            fontSize: 20,
          ),
        ),
        children: children,
      ),
    );
  }
}
