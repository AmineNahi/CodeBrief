import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() => runApp(const TaskManagerApp());

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Retire le bandeau "Debug" pour plus de propreté
      title: 'Task Manager',
      theme: _buildAppTheme(),
      home: HomeScreen(),
    );
  }

  ThemeData _buildAppTheme() {
    return ThemeData.dark().copyWith(
      primaryColor: Colors.blueGrey[900],
      scaffoldBackgroundColor: Colors.blueGrey[800],
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF37474F), // Couleur explicite
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.teal,
      ),
    );
  }
}
