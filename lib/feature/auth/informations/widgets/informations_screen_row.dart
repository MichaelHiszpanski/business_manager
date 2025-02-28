import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:flutter/material.dart';

class InformationScreenRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const InformationScreenRow({
    super.key,
    required this.description,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Constants.padding8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24.0,
            backgroundColor: Colors.blueAccent.withOpacity(0.1),
            child: Icon(
              icon,
              color: Colors.blueAccent,
              size: 28.0,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.text. titleMedium,
                ),
                Text(
                  description,
                  style:  context.text.titleSmall?.copyWith(
                    color:Pallete.gradient1
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
