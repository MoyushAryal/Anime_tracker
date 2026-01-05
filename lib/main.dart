import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anime Tracker',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A0131),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF3B2A8B),
          elevation: 0,
        ),
      ),
      // Initial route
      home: const LoginScreen(),

      routes: {'/dashboard': (context) => const DashboardScreen()},
      debugShowCheckedModeBanner: false,
    );
  }
}
