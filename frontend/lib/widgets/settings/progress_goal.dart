import 'package:flutter/material.dart';

class ProgressGoal extends StatelessWidget {
  const ProgressGoal({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 60,
                  height: 60,
                  child: CircularProgressIndicator(
                    value: 0.0, // à remplacer par la vraie progression
                    strokeWidth: 6,
                    backgroundColor: Colors.grey.shade700,
                    color: Colors.orange,
                  ),
                ),
                const Text("0%", style: TextStyle(color: Colors.white)),
              ],
            ),
            const SizedBox(width: 20),
            const Expanded(
              child: Text(
                "Complete 1 flashcard to reach your daily goal",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
