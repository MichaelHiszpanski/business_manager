import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AddBusinessOwnerScreen extends StatelessWidget {
  const AddBusinessOwnerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add your Business Details",
        onMenuPressed: () {},
      ),
      body: Column(),
    );
  }
}
