import 'package:flutter/material.dart';

class SettingsProfileCard extends StatelessWidget {
  final String username;
  final int cardsGenerated;

  const SettingsProfileCard({
    super.key,
    required this.username,
    required this.cardsGenerated,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          ListTile(
            title:
                const Text("Username", style: TextStyle(color: Colors.white)),
            trailing:
                Text(username, style: const TextStyle(color: Colors.white70)),
          ),
          const Divider(color: Colors.grey),
          ListTile(
            title: const Text("Flashcards generated",
                style: TextStyle(color: Colors.white)),
            trailing: Text("$cardsGenerated",
                style: const TextStyle(color: Colors.white70)),
          ),
        ],
      ),
    );
  }
}
