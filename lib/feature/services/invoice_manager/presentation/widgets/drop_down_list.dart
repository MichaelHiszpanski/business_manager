import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class DropDownList<T extends Equatable> extends StatefulWidget {
  final List<T> itemList;
  final String Function(T) getFullNameDetails;
  final ValueChanged<T?>? onValueSelected;

  const DropDownList({
    super.key,
    required this.itemList,
    required this.getFullNameDetails,
    this.onValueSelected,
  });

  @override
  _DropDownListState<T> createState() => _DropDownListState<T>();
}

class _DropDownListState<T extends Equatable> extends State<DropDownList<T>> {
  T? _itemSelected;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<T>(
      hint: const Row(
        children: [
          Icon(
            Icons.list_rounded,
            color: Pallete.gradient1,
          ),
          SizedBox(width: Constants.padding8),
          Text(
            "Select from list:",
            style: TextStyle(
              fontFamily: 'Jaro',
              fontSize: 20,
            ),
          ),
        ],
      ),
      borderRadius: const BorderRadius.all(
        Radius.circular(
          Constants.padding16,
        ),
      ),
      value: _itemSelected,
      items: widget.itemList.map((item) {
        return DropdownMenuItem<T>(
          value: item,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Constants.padding8),
            child: Text(
              widget.getFullNameDetails(item),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: 'Jaro',
                fontSize: 16,
              ),
            ),
          ),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _itemSelected = value;
        });
        if (widget.onValueSelected != null) {
          widget.onValueSelected!(value);
        }
      },
      isExpanded: true,
    );
  }
}
