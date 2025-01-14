import 'package:auto_route/auto_route.dart';
import 'package:business_manager/core/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:flutter/material.dart';

@RoutePage()
class EmployeeAddNewScreen extends StatelessWidget {
  const EmployeeAddNewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final int index = args['index'];
    final String item = args['item'];
    return Scaffold(
      appBar: CustomAppBar(title: "New Employee", onMenuPressed: () {}),
      body: Center(
        child: Text("Index: $index\nItem: $item"),
      ),
    );
  }
}
