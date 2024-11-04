import 'package:business_manager/core/tools/constants.dart';
import 'package:flutter/material.dart';

class ExpansionTileWrapper extends StatefulWidget {
  final List<Widget> children;
  final String title;
  final bool defaultValue;
  final ValueChanged<bool>? onExpandedChanged;

  const ExpansionTileWrapper({
    super.key,
    required this.children,
    required this.title,
    this.defaultValue = false,
    this.onExpandedChanged,
  });

  @override
  State<ExpansionTileWrapper> createState() => _ExpansionTileWrapperState();
}

class _ExpansionTileWrapperState extends State<ExpansionTileWrapper> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.defaultValue;
  }

  void _handleChangedExpansion(bool expanded) {
    setState(() {
      _isExpanded = expanded;
    });
    if (widget.onExpandedChanged != null) {
      widget.onExpandedChanged!(expanded);
    }
  }

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
          widget.title,
          style: const TextStyle(
            fontFamily: 'Jaro',
            fontSize: 20,
          ),
        ),
        initiallyExpanded: _isExpanded,
        onExpansionChanged: _handleChangedExpansion,
        children: widget.children,
      ),
    );
  }
}
