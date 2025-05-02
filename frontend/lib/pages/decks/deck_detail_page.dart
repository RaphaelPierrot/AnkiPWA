import 'package:flutter/material.dart';
import '../../widgets/decks/card_preview_tile.dart';
import '../../widgets/decks/review_mode_picker.dart';

class DeckDetailPage extends StatelessWidget {
  final String deckName;

  const DeckDetailPage({super.key, required this.deckName});

  @override
  Widget build(BuildContext context) {
    final cards = List.generate(
        10,
        (i) => {
              'question': 'What is item $i?',
              'status': i % 2 == 0 ? 'due' : 'learned',
            });

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E1E1E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(deckName, style: const TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              // Rediriger vers ajout carte
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text("Cards",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];
                  return CardPreviewTile(
                    question: card['question']!,
                    status: card['status']!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            isDismissible: true,
            enableDrag: true,
            backgroundColor: Colors.transparent,
            builder: (_) => const ReviewModePicker(),
          );
        },
        label: const Text("Start"),
        icon: const Icon(Icons.play_arrow),
        backgroundColor: Colors.purple,
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, // 👈 Ajoute cette ligne
    );
  }
}
