import 'package:flutter/material.dart';
import 'package:project_splashscreen/navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'aplikasi flutter media pemelajaran',
      home: const BottomNavBar(),
    );
  }
}
