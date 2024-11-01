import 'package:flutter/material.dart';

class InvoiceInputs extends StatelessWidget {
  final TextEditingController businessOwnerName;

  final TextEditingController businessOwnerStreet;

  const InvoiceInputs({
    super.key,
    required this.businessOwnerName,
    required this.businessOwnerStreet,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: businessOwnerName,
          decoration: InputDecoration(labelText: 'Name'),
        ),
        TextFormField(
          controller: businessOwnerStreet,
          decoration: InputDecoration(labelText: 'Details'),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
