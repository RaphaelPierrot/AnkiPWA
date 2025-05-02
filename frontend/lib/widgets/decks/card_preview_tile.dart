import 'package:flutter/material.dart';

class CardPreviewTile extends StatelessWidget {
  final String question;
  final String status;

  const CardPreviewTile(
      {super.key, required this.question, required this.status});

  @override
  Widget build(BuildContext context) {
    final icon = status == 'due'
        ? const Icon(Icons.access_time, color: Colors.orange)
        : const Icon(Icons.check_circle, color: Colors.green);

    return Card(
      color: const Color(0xFF2A2A2A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: ListTile(
        title: Text(question, style: const TextStyle(color: Colors.white)),
        trailing: icon,
        onTap: () {
          // Détail de la carte ou édition
        },
      ),
    );
  }
}
