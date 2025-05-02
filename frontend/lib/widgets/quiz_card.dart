import 'package:flutter/material.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: const Text("Quiz Example 😌",
            style: TextStyle(color: Colors.white)),
        subtitle: const Text("5 questions available 📚",
            style: TextStyle(color: Colors.white70)),
        trailing: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                value: 0.0,
                strokeWidth: 5,
                backgroundColor: Colors.grey.shade700,
                color: Colors.redAccent,
              ),
            ),
            const Text("0%",
                style: TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
        onTap: () {
          // Navigation vers le quiz
        },
      ),
    );
  }
}
