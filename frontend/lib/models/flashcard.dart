class Flashcard {
  final String id;
  final String question;
  final String answer;
  final DateTime dueDate;
  final bool isLearned;

  Flashcard({
    required this.id,
    required this.question,
    required this.answer,
    required this.dueDate,
    required this.isLearned,
  });
}
