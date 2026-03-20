import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class NoteTakingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note Taking App',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}