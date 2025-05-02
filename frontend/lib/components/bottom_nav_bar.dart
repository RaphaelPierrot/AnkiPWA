import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF2A2A2A),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white60,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "Flashcards"),
        BottomNavigationBarItem(icon: Icon(Icons.add), label: "New Quiz"),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: "Coach"),
      ],
    );
  }
}
