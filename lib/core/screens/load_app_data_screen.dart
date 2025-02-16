import 'package:business_manager/core/theme/colors.dart';
import 'package:business_manager/core/tools/constants.dart';
import 'package:business_manager/core/tools/flutter_helper.dart';
import 'package:flutter/material.dart';

class LoadAppDataScreen extends StatelessWidget {
  const LoadAppDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: AlignmentDirectional.center,
        decoration: const BoxDecoration(color: Pallete.colorSix),
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearProgressIndicator(
                minHeight: 10.0,
                color: Colors.red,
                borderRadius: BorderRadius.circular(Constants.radius10),
              ),
              const SizedBox(height: 20),
              Text(
                context.strings.loading_message,
                style: context.text.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
