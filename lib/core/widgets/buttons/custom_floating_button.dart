import 'package:flutter/material.dart';

class CustomFloatingButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;

  const CustomFloatingButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor:
          WidgetStateProperty.all<Color>(Colors.blue),
          padding: WidgetStateProperty.all<EdgeInsets>(
            const EdgeInsets.symmetric(
                horizontal: 32.0, vertical: 16.0),
          ),
          elevation: WidgetStateProperty.all<double>(6.0),
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          textStyle: WidgetStateProperty.all<TextStyle>(
            const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        child: Text(buttonText),
      ),
    );
  }
}
