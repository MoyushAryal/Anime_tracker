import 'package:flutter/material.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'English';
  final List<String> _languages = [
    'English',
    'Japanese',
    'Spanish',
    'French',
    'German',
    'Korean',
    'Chinese',
    'Hindi',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Language Settings'),
        backgroundColor: const Color(0xFF3B2A8B),
      ),
      backgroundColor: const Color(0xFF0A0131),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Select your preferred language for the app interface:',
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
            ),
          ),
          ..._languages.map((language) {
            return ListTile(
              tileColor: const Color(0xFF12084F),
              leading: const Icon(Icons.language, color: Colors.purpleAccent),
              title: Text(
                language,
                style: const TextStyle(color: Colors.white),
              ),
              trailing: _selectedLanguage == language
                  ? const Icon(Icons.check_circle, color: Colors.purpleAccent)
                  : null,
              onTap: () {
                setState(() {
                  _selectedLanguage = language;
                });
               
              },
            );
          }).toList(),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
              
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Language changed to $_selectedLanguage'),
                    backgroundColor: Colors.purpleAccent,
                  ),
                );
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purpleAccent,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Save Language',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}