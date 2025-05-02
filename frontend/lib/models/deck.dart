import 'flashcard.dart';

class Deck {
  final String id;
  final String name;
  final List<Flashcard> cards;

  Deck({
    required this.id,
    required this.name,
    required this.cards,
  });
}
