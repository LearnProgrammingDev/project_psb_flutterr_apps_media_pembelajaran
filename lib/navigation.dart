import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:project_splashscreen/Screen/materi.dart';
import 'package:project_splashscreen/Screen/quiz_screen.dart';
import 'package:project_splashscreen/Screen/bantuan.dart';
import 'package:project_splashscreen/Screen/profile.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List screens = [
    const Materi(),
    QuizScreen(),
    const Bantuan(),
    const Profile(),
  ];

  int _intpage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: _intpage,
        backgroundColor: Colors.blueAccent,
        items: <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.help, size: 30),
          Icon(Icons.quiz, size: 30),
          Icon(Icons.admin_panel_settings, size: 30),
        ],

        onTap: (index) {
          //Handle button tap
          setState(() {
            _intpage = index;
          });
        },
      ),
      body: screens[_intpage],
    );
  }
}
