import 'package:flutter/material.dart';

class OutlinedTextField extends StatefulWidget {
  final String labelText;
  final String hintText;
  final TextEditingController inputvalue;

  const OutlinedTextField(
      {super.key,
      required this.labelText,
      required this.hintText,
      required this.inputvalue});

  @override
  State<OutlinedTextField> createState() => _OutlinedTextFieldState();
}

class _OutlinedTextFieldState extends State<OutlinedTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.inputvalue,
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 32, 2, 2),
        ),
        hintText: widget.hintText,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: const BorderSide(color: Color.fromARGB(255, 7, 1, 0)),
        ),
        fillColor: Colors.white,
      ),
    );
  }
}
