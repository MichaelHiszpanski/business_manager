import 'package:business_manager/core/theme/app_font_family.dart';
import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

class DropDownList<T extends Equatable> extends StatefulWidget {
  final List<T> itemList;
  final String Function(T) getFullNameDetails;
  final ValueChanged<T?>? onValueSelected;
  final ValueChanged<T>? onRemoveItem;

  const DropDownList({
    super.key,
    required this.itemList,
    required this.getFullNameDetails,
    this.onValueSelected,
    required this.onRemoveItem,
  });

  @override
  _DropDownListState<T> createState() => _DropDownListState<T>();
}

class _DropDownListState<T extends Equatable> extends State<DropDownList<T>> {
  T? _itemSelected;
  OverlayEntry? _dropdownOverlay;

  void _openDropDown() {
    _cloeDropDown();
    _dropdownOverlay = _createOverlayEntry();
    Overlay.of(context).insert(_dropdownOverlay!);
  }

  void _cloeDropDown() {
    _dropdownOverlay?.remove();
    _dropdownOverlay = null;
  }

  OverlayEntry _createOverlayEntry() {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _cloeDropDown,
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Positioned(
            left: offset.dx,
            top: offset.dy + size.height,
            width: size.width,
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(Constants.padding16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: widget.itemList.map((item) {
                    return StatefulBuilder(
                      builder: (context, setStateDropdown) {
                        return ListTile(
                          title: Text(
                            widget.getFullNameDetails(item),
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontFamily: AppFontFamily.suse,
                              fontSize: 18,
                              color: Pallete.gradient1,
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              widget.onRemoveItem!(item);
                              _cloeDropDown();
                              if (_itemSelected == item) {
                                setState(() {
                                  _itemSelected = null;
                                });
                              }
                              setStateDropdown(() {});
                            },
                          ),
                          onTap: () {
                            setState(() {
                              _itemSelected = item;
                            });
                            _cloeDropDown();
                            if (widget.onValueSelected != null) {
                              widget.onValueSelected!(item);
                            }
                          },
                        );
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _openDropDown,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Constants.padding16),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: Constants.padding8, vertical: Constants.padding8),
          decoration: BoxDecoration(
            border: const Border(
              bottom: BorderSide(color: Pallete.gradient1),
            ),
            borderRadius: BorderRadius.circular(Constants.padding4),
          ),
          child: Row(
            children: [
              const Icon(Icons.list_rounded, color: Pallete.gradient1),
              const SizedBox(width: Constants.padding8),
              Expanded(
                child: Text(
                  _itemSelected == null
                      ? widget.itemList.isEmpty
                          ? "Empty list"
                          : "Select from list:"
                      : widget.getFullNameDetails(_itemSelected!),
                  style: const TextStyle(
                    fontFamily: AppFontFamily.suse,
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ),
              const Icon(Icons.arrow_drop_down, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
