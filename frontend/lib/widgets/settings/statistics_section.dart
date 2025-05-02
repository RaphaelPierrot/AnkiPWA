import 'package:flutter/material.dart';

class StatisticsSection extends StatelessWidget {
  const StatisticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Flashcard Stats",
            style: TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFF2A2A2A),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: const [
              ListTile(
                title: Text("Cards Reviewed Today",
                    style: TextStyle(color: Colors.white)),
                trailing: Text("0", style: TextStyle(color: Colors.white70)),
              ),
              Divider(color: Colors.white12),
              ListTile(
                title: Text("Total Cards Reviewed",
                    style: TextStyle(color: Colors.white)),
                trailing: Text("0", style: TextStyle(color: Colors.white70)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
