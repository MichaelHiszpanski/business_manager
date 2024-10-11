import 'package:business_manager/core/theme/colors.dart';
import 'package:flutter/material.dart';

class LoadAppDataScreen extends StatelessWidget {
  const LoadAppDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional.center,
        decoration: const BoxDecoration(color: Pallete.colorTwo),
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearProgressIndicator(
                minHeight: 10.0,
                color: Colors.red,
                borderRadius: BorderRadius.circular(10.0),
              ),
              const SizedBox(height: 20),
              const Text(
                'Loading data, please wait...',
                style: TextStyle(
                  fontSize: 24,
                  color: Pallete.colorFive,
                  fontFamily: 'Suse',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
