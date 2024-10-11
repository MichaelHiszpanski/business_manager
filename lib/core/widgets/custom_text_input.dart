// import 'package:dissertation_project_app/sign_in_app/theme/colors.dart';
import 'package:dissertation_project_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class CustomTextInput extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final List<String>? errorMessages;
  final Function() onFocus;

  const CustomTextInput({
    super.key,
    required this.hintText,
    required this.controller,
    this.errorMessages,
    required this.onFocus,
  });

  @override
  State<CustomTextInput> createState() => _CustomTextInputState();
}

class _CustomTextInputState extends State<CustomTextInput> {
  late FocusNode _focusNode;
  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        widget.onFocus();
        print('Focused on: ${widget.hintText}');
      }
    });
    widget.controller.addListener(() {
      if (_focusNode.hasFocus) {
        widget.onFocus();
        print('Typing in: ${widget.hintText}');
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: 400,
          ),
          child: TextFormField(
            focusNode: _focusNode,
            controller: widget.controller,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(27),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Pallete.borderColor,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Pallete.gradient2,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: widget.hintText,
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.shade700,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red.shade700,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        if (widget.errorMessages != null && widget.errorMessages!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.errorMessages!
                  .map(
                    (error) => Text(
                      error,
                      style: TextStyle(
                        color: Colors.red.shade700,
                        fontSize: 12,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
      ],
    );
  }
}
