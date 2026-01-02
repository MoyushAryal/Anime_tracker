import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 40,
      child: TextField(
        style: const TextStyle(color: Colors.white),
        cursorColor: Colors.purpleAccent,
        decoration: InputDecoration(
          hintText: 'Search anime',
          hintStyle: TextStyle(color: Colors.white54),
          filled: true,
          fillColor: const Color(0xFF12084F), // dark card background
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          prefixIcon: const Icon(Icons.search, color: Colors.white54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none, // remove default border
          ),
        ),
      ),
    );
  }
}
