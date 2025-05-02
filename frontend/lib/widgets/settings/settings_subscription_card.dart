import 'package:flutter/material.dart';

class SettingsSubscriptionCard extends StatelessWidget {
  const SettingsSubscriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          const ListTile(
            title: Text("Current plan", style: TextStyle(color: Colors.white)),
            trailing: Text("Free", style: TextStyle(color: Colors.white70)),
          ),
          const Divider(color: Colors.grey),
          const ListTile(
            title: Text("CoachAI Messages Available",
                style: TextStyle(color: Colors.white)),
            trailing: Text("8/10", style: TextStyle(color: Colors.white70)),
          ),
          const Divider(color: Colors.grey),
          const ListTile(
            title: Text("Manual Flashcards Available",
                style: TextStyle(color: Colors.white)),
            trailing: Text("2/2", style: TextStyle(color: Colors.white70)),
          ),
          const Divider(color: Colors.grey),
          const ListTile(
            title: Text("AI Flashcards Available",
                style: TextStyle(color: Colors.white)),
            trailing: Text("3/3", style: TextStyle(color: Colors.white70)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
              child: const Text("Get premium",
                  style: TextStyle(color: Colors.white)),
            ),
          )
        ],
      ),
    );
  }
}
