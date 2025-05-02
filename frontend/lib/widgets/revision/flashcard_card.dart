import 'package:flutter/material.dart';

class FlashcardCard extends StatefulWidget {
  final String question;
  final String answer;
  final ValueChanged<bool> onSwiped;

  const FlashcardCard({
    super.key,
    required this.question,
    required this.answer,
    required this.onSwiped,
  });

  @override
  State<FlashcardCard> createState() => _FlashcardCardState();
}

class _FlashcardCardState extends State<FlashcardCard> {
  bool showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 6,
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.volume_up, color: Colors.white70),
            const SizedBox(height: 20),
            Text(
              showAnswer ? widget.answer : widget.question,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(height: 30),
            if (!showAnswer)
              TextButton.icon(
                onPressed: () => setState(() => showAnswer = true),
                icon: const Icon(Icons.lightbulb_outline, color: Colors.amber),
                label: const Text("Show Answer",
                    style: TextStyle(color: Colors.white)),
              ),
            if (showAnswer)
              ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.auto_awesome),
                label: const Text("Explain me"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            const SizedBox(height: 10),
            if (showAnswer)
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.thumb_up_alt_outlined, color: Colors.white54),
                  SizedBox(width: 10),
                  Icon(Icons.thumb_down_alt_outlined, color: Colors.white54),
                ],
              ),
            const SizedBox(height: 10),
            if (showAnswer)
              const Text("Rate this card? 🧐",
                  style: TextStyle(color: Colors.white60)),
          ],
        ),
      ),
    );
  }
}
