import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String currentItem;
  final String question;
  final String itemType;
  final VoidCallback onConfirm;
  final String confirmText;
  final String cancelText;

  const CustomDialog({
    super.key,
    required this.title,
    required this.question,
    required this.currentItem,
    required this.itemType,
    required this.onConfirm,
    this.confirmText = "Delete",
    this.cancelText = "Cancel",
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: context.text.bodyLarge?.copyWith(color: Colors.red),
      ),
      content: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: question,
              style: context.text.headlineSmall,
            ),
            TextSpan(
              text: currentItem,
              style: context.text.headlineSmall?.copyWith(color: Colors.red),
            ),
            TextSpan(
              text: itemType,
              style: context.text.headlineSmall,
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            onConfirm();
            Navigator.of(context).pop();
          },
          child: Text(
            confirmText,
            style: context.text.bodyMedium,
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            cancelText,
            style: context.text.bodyMedium,
          ),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.radius30),
        side: const BorderSide(color: Colors.red, width: 2),
      ),
    );
  }
}
