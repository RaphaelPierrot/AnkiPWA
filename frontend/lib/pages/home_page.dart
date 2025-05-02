import 'package:flutter/material.dart';
import 'package:frontend/pages/settings_page.dart';
import 'package:frontend/widgets/decks/deck_list.dart';
import '../widgets/progress_tracker.dart';
import '../widgets/quiz_card.dart';
import '../widgets/section_title.dart';
import '../components/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Anki PWA"),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                isDismissible: true, // permet le clic en dehors
                enableDrag: true, // permet le swipe pour fermer
                backgroundColor: Colors.transparent,
                builder: (context) => const SettingsPage(),
              );
            },
          ),
        ],
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProgressTracker(),
              SizedBox(height: 20),
              SectionTitle(title: "Flashcards 📚"),
              QuizCard(),
              SizedBox(height: 30),
              DeckList(),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
