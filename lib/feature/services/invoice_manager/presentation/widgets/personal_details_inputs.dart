import 'package:business_manager/core/tools/constants.dart';
import 'package:flutter/material.dart';

class PersonalDetailsInputs extends StatelessWidget {
  final TextEditingController businessOwnerName;
  final TextEditingController businessOwnerStreet;

  const PersonalDetailsInputs({
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
          decoration:const InputDecoration(labelText: 'Company Name'),

        ),
        const  SizedBox(height: Constants.padding16),
        TextFormField(
          controller: businessOwnerStreet,
          decoration:const InputDecoration(labelText: 'Street and Postcode'),
        ),
      const  SizedBox(height: Constants.padding16),
      ],
    );
  }
}
