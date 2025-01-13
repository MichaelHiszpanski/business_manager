import 'package:business_manager/core/theme/app_font_family.dart';
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
            color: Colors.white,
          ),
          SizedBox(width: Constants.padding8),
          Text(
            "Select from list:",
            style: TextStyle(
              fontFamily: AppFontFamily.suse,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
      iconDisabledColor: Pallete.gradient1,
      dropdownColor: Colors.white,
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
            padding: const EdgeInsets.symmetric(horizontal: Constants.padding4),
            child: Text(
              widget.getFullNameDetails(item),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: AppFontFamily.suse,
                fontSize: 18,
                color: Pallete.colorOne,
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
