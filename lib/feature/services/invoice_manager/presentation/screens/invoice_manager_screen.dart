import 'package:business_manager/core/theme/colors.dart';
import 'package:flutter/material.dart';
class InvoiceManagerScreen extends StatelessWidget {
  const InvoiceManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Pallete.colorThree,
        appBar: AppBar(
          backgroundColor: Pallete.colorThree,
          title: const Text(
            'Invoice Service ',
            style: TextStyle(
              color: Pallete.colorTwo,
              fontFamily: "Jaro",
              fontSize: 24,
            ),
          ),
          iconTheme: IconThemeData(
            color: Pallete.colorOne,
            size: 28,
            shadows: [
              BoxShadow(
                color: Colors.black38.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(2, 4),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.menu,
                color: Pallete.colorOne,
              ),
              onPressed: (){},
            ),
          ],
        ),
        body: Column()
    );
  }
}
