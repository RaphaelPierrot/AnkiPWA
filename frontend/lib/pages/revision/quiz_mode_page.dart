import 'package:flutter/material.dart';

class QuizModePage extends StatefulWidget {
  const QuizModePage({super.key});

  @override
  State<QuizModePage> createState() => _QuizModePageState();
}

class _QuizModePageState extends State<QuizModePage> {
  int currentQuestion = 0;
  int score = 0;
  bool isLocked = false;
  int? selectedIndex;

  final List<Map<String, dynamic>> questions = [
    {
      "question": "Comment dire le mois en coréen ?",
      "options": ["둘", "백만", "nombre + 월\nEx : 4월 (avril)", "아홉"],
      "answerIndex": 2
    },
    // Ajoute d'autres questions ici
  ];

  void selectOption(int index) {
    if (isLocked) return;
    setState(() {
      selectedIndex = index;
      isLocked = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      if (selectedIndex == questions[currentQuestion]["answerIndex"]) {
        score++;
      }
      if (currentQuestion < questions.length - 1) {
        setState(() {
          currentQuestion++;
          isLocked = false;
          selectedIndex = null;
        });
      } else {
        final percent = ((score / questions.length) * 100).round();
        Navigator.pushReplacementNamed(context, '/result', arguments: percent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.close),
        title: Text("${currentQuestion + 1}/${questions.length}"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
        child: Column(
          children: [
            Text(
              question["question"],
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 22),
            ),
            const SizedBox(height: 30),
            ...List.generate(question["options"].length, (i) {
              final option = question["options"][i];
              final isCorrect = i == question["answerIndex"];
              final isSelected = i == selectedIndex;

              Color bgColor = Colors.grey.shade900;
              if (isLocked) {
                if (isSelected) {
                  bgColor = isCorrect ? Colors.green : Colors.red;
                } else if (isCorrect) {
                  bgColor = Colors.green;
                }
              }

              return GestureDetector(
                onTap: () => selectOption(i),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: isLocked
                        ? null
                        : const LinearGradient(
                            colors: [Color(0xFFE96443), Color(0xFF904E95)],
                          ),
                    color: isLocked ? bgColor : null,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      option,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
