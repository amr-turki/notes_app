import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      onChanged: (value) {},
      decoration: InputDecoration(
        hintText: 'Search for a note...',
        prefixIcon: Icon(Icons.arrow_back),
        suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
