import 'package:flutter/material.dart';
import 'package:frontend/widgets/auth/login_bottom_sheet.dart';
import '../widgets/settings/settings_progress_card.dart';
import '../widgets/settings/settings_profile_card.dart';
import '../widgets/settings/settings_learning_card.dart';
import '../widgets/settings/settings_footer_links.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: Container(color: Colors.transparent),
      ),
      DraggableScrollableSheet(
        initialChildSize: 0.95,
        minChildSize: 0.85,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1E1E1E),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            ),
            child: ListView(
              controller: scrollController,
              padding: const EdgeInsets.all(20),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Settings",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    TextButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => const LoginBottomSheet(),
                        );
                      },
                      child: const Text("Log in",
                          style: TextStyle(color: Colors.white)),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),

                // Section progression
                SettingsProgressCard(),
                SizedBox(height: 20),

                // Section profil
                const SettingsProfileCard(
                  username: "raphael@example.com", // à remplacer par user.email
                  cardsGenerated: 0, // à lier à ton compteur personnalisé
                ),

                SizedBox(height: 20),

                // Section learning / jours cochés
                SettingsLearningCard(),
                SizedBox(height: 20),

                // Section footer / réseaux sociaux / suppression / version
                SettingsFooterLinks(),
              ],
            ),
          );
        },
      ),
    ]);
  }
}
