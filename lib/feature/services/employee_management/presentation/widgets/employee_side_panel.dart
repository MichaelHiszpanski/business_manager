import 'package:flutter/material.dart';

class EmployeeSidePanel extends StatelessWidget {
  const EmployeeSidePanel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: [
          Text("New Employee"),
          Spacer(),
          Text("Delete Employee")
        ],
      ),
    );
  }
}
