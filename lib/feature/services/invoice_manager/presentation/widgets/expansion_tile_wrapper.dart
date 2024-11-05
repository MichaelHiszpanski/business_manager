import 'package:business_manager/core/tools/constants.dart';
import 'package:flutter/material.dart';

class ExpansionTileWrapper extends StatelessWidget {
  final List<Widget> children;
  final String title;


  const ExpansionTileWrapper({
    super.key,
    required this.children,
    required this.title,

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
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Racing',
            fontSize: 20,
          ),
        ),

        children: children,
      ),
    );
  }
}
