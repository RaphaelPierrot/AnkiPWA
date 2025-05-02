import 'package:flutter/material.dart';

class FlashcardStack extends StatefulWidget {
  final List<Map<String, String>> cards;
  final void Function(bool mastered) onAnswered;

  const FlashcardStack({
    super.key,
    required this.cards,
    required this.onAnswered,
  });

  @override
  State<FlashcardStack> createState() => _FlashcardStackState();
}

class _FlashcardStackState extends State<FlashcardStack> {
  int index = 0;
  bool showAnswer = false;

  void next(bool mastered) {
    widget.onAnswered(mastered);
    setState(() {
      showAnswer = false;
      if (index < widget.cards.length - 1) index++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final card = widget.cards[index];

    return Stack(
      alignment: Alignment.center,
      children: [
        // Carte suivante (effet de pile)
        if (index < widget.cards.length - 1)
          Positioned(
            top: 40,
            child: Opacity(
              opacity: 0.4,
              child: flashcardContainer(
                  widget.cards[index + 1]['question']!, false),
            ),
          ),

        // Carte active
        flashcardContainer(
          showAnswer ? card['answer']! : card['question']!,
          showAnswer,
          progress: "${index + 1}/${widget.cards.length}",
        ),
      ],
    );
  }

  Widget flashcardContainer(String content, bool answered, {String? progress}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: answered ? Colors.greenAccent : Colors.transparent,
          width: 2,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Icon(Icons.volume_up, color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Text(
            content,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, color: Colors.white),
          ),
          const SizedBox(height: 30),
          if (!answered)
            TextButton.icon(
              onPressed: () => setState(() => showAnswer = true),
              icon: const Icon(Icons.lightbulb, color: Colors.yellow),
              label: const Text("Show Answer",
                  style: TextStyle(color: Colors.white)),
            ),
          if (answered) ...[
            ElevatedButton(
              onPressed: () {},
              child: const Text("✨ Explain me"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)),
              ),
            ),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.thumb_up_alt_outlined, color: Colors.white54),
                SizedBox(width: 12),
                Icon(Icons.thumb_down_alt_outlined, color: Colors.white54),
              ],
            ),
            const Text("Rate this card? 🧐",
                style: TextStyle(color: Colors.white60))
          ],
          if (progress != null)
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  progress,
                  style: const TextStyle(color: Colors.white70),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
