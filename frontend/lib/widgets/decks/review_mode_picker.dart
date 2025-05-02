import 'package:flutter/material.dart';
import 'package:frontend/pages/revision/flashcard_mode_page.dart';
import 'package:frontend/pages/revision/quiz_mode_page.dart';

class ReviewModePicker extends StatelessWidget {
  const ReviewModePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final modes = [
      {'label': "Learn New", 'icon': Icons.auto_awesome},
      {'label': "Review Due", 'icon': Icons.update},
      {'label': "Quiz", 'icon': Icons.quiz},
    ];

    return Stack(
      children: [
        // Clic en arrière-plan pour fermer
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => Navigator.of(context).pop(),
          child: Container(color: Colors.transparent),
        ),

        // La vraie popup
        DraggableScrollableSheet(
          initialChildSize: 0.4,
          maxChildSize: 0.6,
          minChildSize: 0.3,
          builder: (context, controller) {
            return GestureDetector(
              // Empêche le clic intérieur de fermer la popup
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: ListView(
                  controller: controller,
                  children: [
                    const Text("Choose mode",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    const SizedBox(height: 20),
                    ...modes.map((mode) => ListTile(
                          leading: Icon(mode['icon'] as IconData,
                              color: Colors.white),
                          title: Text(mode['label'] as String,
                              style: const TextStyle(color: Colors.white)),
                          onTap: () {
                            Navigator.pop(context);

                            final label = mode['label'];

                            if (label == "Learn New") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const FlashcardModePage()),
                              );
                            } else if (label == "Review Due") {
                              // TODO: remplacer par SpacedRepetitionPage si tu l’implémentes
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const FlashcardModePage()),
                              );
                            } else if (label == "Quiz") {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const QuizModePage()),
                              );
                            }
                          },
                        )),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
