import 'package:flutter/material.dart';

class FlashcardView extends StatelessWidget {
  final String question;
  final String answer;
  final bool showAnswer;
  final VoidCallback onReveal;

  const FlashcardView({
    super.key,
    required this.question,
    required this.answer,
    required this.showAnswer,
    required this.onReveal,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: Container(
          key: ValueKey(showAnswer),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: showAnswer ? Colors.greenAccent : Colors.transparent,
              width: 2,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                showAnswer ? answer : question,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 22),
              ),
              const SizedBox(height: 20),
              if (!showAnswer)
                TextButton.icon(
                  onPressed: onReveal,
                  icon: const Icon(Icons.lightbulb, color: Colors.yellow),
                  label: const Text("Show Answer",
                      style: TextStyle(color: Colors.white)),
                ),
              if (showAnswer)
                const Padding(
                  padding: EdgeInsets.only(top: 12.0),
                  child: Text("Rate this card? 🧐",
                      style: TextStyle(color: Colors.white70)),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
