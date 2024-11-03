import 'package:flutter/material.dart';

class SearchInputField extends StatelessWidget {
  final Function(String)? onSearchChanged;

  SearchInputField({this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Color(0xFF7C7C7C).withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: TextField(
        onChanged: onSearchChanged,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.black),
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 14), // Centers text
        ),
      ),
    );
  }
}
