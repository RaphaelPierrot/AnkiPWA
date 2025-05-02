import 'package:flutter/material.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Profile",
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFF2A2A2A),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: const [
              ListTile(
                title: Text("Username", style: TextStyle(color: Colors.white)),
                trailing: Text("-", style: TextStyle(color: Colors.white70)),
              ),
              Divider(color: Colors.white12),
              ListTile(
                title: Text("Flashcards generated",
                    style: TextStyle(color: Colors.white)),
                trailing: Text("0", style: TextStyle(color: Colors.white70)),
              ),
            ],
          ),
        )
      ],
    );
  }
}
