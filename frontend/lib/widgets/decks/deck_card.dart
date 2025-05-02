import 'package:flutter/material.dart';
import 'package:frontend/pages/decks/deck_detail_page.dart';

class DeckCard extends StatelessWidget {
  final String title;
  final int cardCount;
  final double progress;
  final VoidCallback onTap;

  const DeckCard({
    super.key,
    required this.title,
    required this.cardCount,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => DeckDetailPage(deckName: this.title),
            ),
          );
        },
        contentPadding: const EdgeInsets.all(16),
        title: Text(title, style: const TextStyle(color: Colors.white)),
        subtitle: Text("$cardCount cards",
            style: const TextStyle(color: Colors.white70)),
        trailing: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                value: progress, // entre 0 et 1
                strokeWidth: 6,
                backgroundColor: Colors.grey.shade800,
                color: Colors.lightGreenAccent,
              ),
            ),
            Text("${(progress * 100).toInt()}%",
                style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
