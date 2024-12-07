import 'package:business_manager/core/theme/colors.dart';
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
        collapsedBackgroundColor: Colors.grey,
        collapsedShape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.padding16),
        ),
        tilePadding: const EdgeInsets.only(
          right: Constants.padding16,
          left: Constants.padding16,
        ),
        childrenPadding: const EdgeInsets.only(
          left: Constants.padding32,
          right: Constants.padding32,
          bottom: Constants.padding16,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Suse',
            fontSize: 20,
            // color: Pallete.whiteColor,
          ),
        ),

        children: children,
      ),
    );
  }
}
