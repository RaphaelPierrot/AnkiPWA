import 'package:flutter/material.dart';
import 'deck_card.dart';
import '../../pages/decks/deck_detail_page.dart';

class DeckList extends StatelessWidget {
  const DeckList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> decks = [
      {'title': "Korean Verbs", 'count': 42, 'progress': 0.6},
      {'title': "Flutter Basics", 'count': 20, 'progress': 0.3},
      {'title': "Math Formulas", 'count': 15, 'progress': 0.9},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("My Decks",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        const SizedBox(height: 10),
        ...decks.map((deck) => DeckCard(
              title: deck['title']!,
              cardCount: deck['count']!,
              progress: deck['progress']!,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        DeckDetailPage(deckName: deck['title'] as String),
                  ),
                );
              },
            )),
      ],
    );
  }
}
