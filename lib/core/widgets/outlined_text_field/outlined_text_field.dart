import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:flutter/material.dart';

class OutlinedTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController inputValue;
  final bool isPassword;

  const OutlinedTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.inputValue,
    this.isPassword = false,
  });

  @override
  State<OutlinedTextField> createState() => _OutlinedTextFieldState();
}

class _OutlinedTextFieldState extends State<OutlinedTextField> {
  bool _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.inputValue,
      obscuringCharacter: '•',
      obscureText: widget.isPassword ? _isPasswordVisible : false,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Pallete.colorOne,
        ),
        hintText: widget.hintText,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.radius15),
          borderSide: const BorderSide(
            color: Pallete.colorOne,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.radius15),
          borderSide: const BorderSide(
            color: Pallete.colorOne,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.radius15),
          borderSide: const BorderSide(
            color: Pallete.colorSix,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.radius15),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Constants.radius15),
          borderSide: const BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        fillColor: Colors.white,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              )
            : null, // Only show icon for password fields
      ),
    );
  }
}
