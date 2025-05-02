import '../models/flashcard.dart';

class FlashcardService {
  Future<List<Flashcard>> fetchDueCards() async {
    // Simulation de cartes à réviser
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Flashcard(
        id: '1',
        question: 'Qu’est-ce que Flutter ?',
        answer: 'Un framework UI développé par Google.',
        dueDate: DateTime.now(),
        isLearned: false,
      ),
    ];
  }

  Future<List<Flashcard>> fetchLearnedCards() async {
    // Simulation de cartes déjà apprises
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Flashcard(
        id: '2',
        question: 'Qu’est-ce qu’un widget stateless ?',
        answer: 'Un widget immuable.',
        dueDate: DateTime.now().subtract(const Duration(days: 3)),
        isLearned: true,
      ),
    ];
  }
}
