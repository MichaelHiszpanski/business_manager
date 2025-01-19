import 'package:flutter/material.dart';

class EmployeeSidePanel extends StatelessWidget {
  final VoidCallback onNewEmployeePressed;

  const EmployeeSidePanel({
    super.key,
    required this.onNewEmployeePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: [
          const Spacer(),
          TextButton(
            onPressed: onNewEmployeePressed,
            child: const Text("New Employee"),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
