import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
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

          ElevatedButton.icon(
            onPressed: onNewEmployeePressed,
            icon: const Icon(
              Icons.person_add_alt_1,
              size: 32,
            ),
            label: Text(
              "",
              style: context.text.titleSmall?.copyWith(
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              elevation: 4,
              padding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Constants.padding42),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
