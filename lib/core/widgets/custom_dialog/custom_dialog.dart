import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final VoidCallback onConfirm;
  final String confirmText;
  final String cancelText;

  const CustomDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.confirmText = "Delete",
    this.cancelText = "Cancel",
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(color: Colors.red),
      ),
      content: Text(
        content,
        style: const TextStyle(color: Colors.black87),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(cancelText),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: Text(
            confirmText,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
