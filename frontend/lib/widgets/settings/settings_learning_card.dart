import 'package:flutter/material.dart';

class SettingsLearningCard extends StatelessWidget {
  const SettingsLearningCard({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    final Set<int> checked = {2, 3}; // à générer dynamiquement plus tard

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Learning",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF2A2A2A),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Text("Consecutive revision days",
                      style: TextStyle(color: Colors.white)),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white12,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text("2 🔥",
                        style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(days.length, (index) {
                  final isChecked = checked.contains(index);
                  return Column(
                    children: [
                      Icon(
                        isChecked ? Icons.check_circle : Icons.circle,
                        color: isChecked ? Colors.white : Colors.grey,
                        size: 20,
                      ),
                      const SizedBox(height: 4),
                      Text(days[index],
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 12)),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
