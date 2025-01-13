import 'package:auto_route/annotations.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EmployeeManagementScreen extends StatelessWidget {
  const EmployeeManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Employee Management",
        onMenuPressed: () {},
      ),
      body: Column(),
    );
  }
}
