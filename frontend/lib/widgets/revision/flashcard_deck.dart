// lib/widgets/revision/flashcard_deck.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:frontend/widgets/revision/draggable_flip_card.dart';
import 'package:frontend/widgets/revision/flip_flashcard.dart';

class FlashcardDeck extends StatelessWidget {
  final List<Map<String, String>> cards;
  final int index;
  final void Function(bool mastered) onAnswered;

  const FlashcardDeck({
    super.key,
    required this.cards,
    required this.index,
    required this.onAnswered,
  });

  @override
  Widget build(BuildContext context) {
    final visible = cards.skip(index).take(4).toList();

    return Stack(
      alignment: Alignment.center,
      children: List.generate(visible.length, (i) {
        final depth = visible.length - 1 - i;
        final card = visible[i];

        // paramètres d’inclinaison légers
        const pattern = [-3.0, 2.0, -1.0];
        final angle = pattern[depth % pattern.length] * math.pi / 180;

        final offsetY = depth * 0.2;
        final opacity = 1 - depth * 0.22;
        const double kCardMargin = 20.0;
        // Carte active avec swipe+flip
        if (depth == 0) {
          return Padding(
            padding: const EdgeInsets.all(kCardMargin),
            child: DraggableFlipCard(
              key: ValueKey(
                  card['id'] ?? '$index-$depth'), // ← key change à chaque carte
              card: card,
              onDecision: onAnswered,
            ),
          );
        }

        // cartes passives dessous
        return Positioned(
          top: offsetY, // simple décalage vertical
          child: Transform.rotate(
            angle: angle,
            child: Opacity(
              opacity: opacity,
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
                // même hauteur que l’active
                height: MediaQuery.of(context).size.height * 0.75,
                child: FlipFlashcard(
                  // <-- mêmes coins, ombre, etc.
                  question: card['question']!,
                  answer: card['answer']!,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
