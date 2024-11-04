import 'package:flutter/material.dart';

class PersonalDetailsInputs extends StatelessWidget {
  final TextEditingController firstName;
  final TextEditingController lastName;
  final TextEditingController street;
  final TextEditingController postCode;
  final TextEditingController city;
  final TextEditingController mobile;
  final TextEditingController email;
  final VoidCallback onSaveData;

  const PersonalDetailsInputs({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.street,
    required this.postCode,
    required this.city,
    required this.mobile,
    required this.email,
    required this.onSaveData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: firstName,
          decoration: const InputDecoration(labelText: 'First name'),
        ),
        TextFormField(
          controller: lastName,
          decoration: const InputDecoration(labelText: 'Last Name'),
        ),
        TextFormField(
          controller: street,
          decoration: const InputDecoration(labelText: 'Street Name'),
        ),
        TextFormField(
          controller: city,
          decoration: const InputDecoration(labelText: 'City Name'),
        ),
        TextFormField(
          controller: postCode,
          decoration: const InputDecoration(labelText: 'Post Code'),
        ),
        TextFormField(
          controller: mobile,
          decoration: const InputDecoration(labelText: 'Mobile Number'),
        ),
        TextFormField(
          controller: email,
          decoration: const InputDecoration(labelText: 'Email:'),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onSaveData,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
