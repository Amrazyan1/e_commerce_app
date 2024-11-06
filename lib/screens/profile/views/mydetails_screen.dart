import 'package:auto_route/auto_route.dart';
import 'package:e_commerce_app/constants.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MyDetailsScreen extends StatelessWidget {
  const MyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'My Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              _buildInputField(
                label: 'Name',
                defaultValue: 'John Doe',
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: 'Email',
                defaultValue: 'johndoe@example.com',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: 'Date',
                defaultValue: '1997-01-01',
                keyboardType: TextInputType.datetime,
              ),
              const SizedBox(height: 20),
              _buildInputField(
                label: 'Phone Number',
                defaultValue: '+3744567890',
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Handle save action
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Details saved!')),
                  );
                },
                child: const Text('Save Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String defaultValue,
    required TextInputType keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: defaultValue),
          keyboardType: keyboardType,
          style: TextStyle(fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            hintText: label,
            border: const UnderlineInputBorder(),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 0,
              vertical: 10,
            ),
          ),
        ),
      ],
    );
  }
}
