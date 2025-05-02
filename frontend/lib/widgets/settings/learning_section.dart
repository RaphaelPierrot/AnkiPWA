import 'package:flutter/material.dart';

class LearningSection extends StatelessWidget {
  const LearningSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Learning",
      style: TextStyle(color: Colors.white, fontSize: 18),
    );
    // Tu pourras y ajouter plus tard une liste des decks ou sessions en cours.
  }
}
