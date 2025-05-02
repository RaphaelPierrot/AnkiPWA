import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class FlashcardList extends StatelessWidget {
  final List<Flashcard> cards;

  const FlashcardList({super.key, required this.cards});

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      return const Text("Aucune carte");
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: cards.length,
      itemBuilder: (context, index) {
        final card = cards[index];
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 0.5,
          margin: const EdgeInsets.symmetric(vertical: 6),
          child: ListTile(
            title: Text(card.question),
            subtitle: Text(
                "À revoir le ${card.dueDate.toLocal().toIso8601String().substring(0, 10)}"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Navigation future vers la carte
            },
          ),
        );
      },
    );
  }
}
