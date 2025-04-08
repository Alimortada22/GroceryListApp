import 'package:flutter/material.dart';
import 'package:grocey/presentation/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[600],
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey[600]),
        useMaterial3: true,
      ),
      home:   const HomeScreen(),
    );
  }
}
