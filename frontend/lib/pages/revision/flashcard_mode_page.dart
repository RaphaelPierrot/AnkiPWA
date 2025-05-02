import 'package:flutter/material.dart';
import 'package:frontend/widgets/revision/flashcard_deck.dart';
import '../../services/revision_service.dart'; // tu dois créer ce fichier

class FlashcardModePage extends StatefulWidget {
  const FlashcardModePage({super.key});

  @override
  State<FlashcardModePage> createState() => _FlashcardModePageState();
}

class _FlashcardModePageState extends State<FlashcardModePage> {
  int currentIndex = 0;
  int score = 0;

  final List<Map<String, String>> cards = [
    {
      'id': 'c1',
      'question': 'What is the capital of France?',
      'answer': 'Paris'
    },
    {
      'id': 'c2',
      'question': 'Where is the Amazon rainforest?',
      'answer': 'Brazil'
    },
  ];

  void submitAnswer({required bool mastered}) async {
    final card = cards[currentIndex];
    final int quality = mastered ? 5 : 2;

    // 1) on incrémente tout de suite ➜ rebuild instantané
    if (mastered) score++;
    final finished = currentIndex >= cards.length - 1;
    setState(() => currentIndex++);

    // 2) appel API en arrière‑plan
    RevisionService.submitCardResult(cardId: card['id']!, quality: quality);

    // 3) si dernière carte on navigue
    if (finished) {
      final pct = (score / cards.length * 100).toInt();
      Navigator.pushReplacementNamed(context, '/result', arguments: pct);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: Column(
        children: [
          const SizedBox(height: 40),

          /// AppBar custom
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text("Close",
                      style: TextStyle(color: Colors.blue, fontSize: 16)),
                ),
                const Spacer(),
                const Text("Quiz Example 😌",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                const Spacer(),
                IconButton(
                  icon:
                      const Icon(Icons.add_circle_rounded, color: Colors.white),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          /// Progress bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: LinearProgressIndicator(
              value: (currentIndex + 1) / cards.length,
              color: Colors.purpleAccent,
              backgroundColor: Colors.grey.shade800,
              minHeight: 4,
            ),
          ),

          /// Flashcard stack
          Expanded(
            child: FlashcardDeck(
              cards: cards,
              index: currentIndex,
              onAnswered: (bool mastered) => submitAnswer(mastered: mastered),
            ),
          ),

          /// Boutons du bas
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => submitAnswer(mastered: false),
                    icon: const Icon(Icons.thumb_down_alt, color: Colors.white),
                    label: const Text("Not Learned"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => submitAnswer(mastered: true),
                    icon: const Icon(Icons.thumb_up_alt, color: Colors.white),
                    label: const Text("Mastered"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
