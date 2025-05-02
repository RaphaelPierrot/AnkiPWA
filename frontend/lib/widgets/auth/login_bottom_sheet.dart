import 'package:flutter/foundation.dart'; // pour kIsWeb
import 'package:flutter/material.dart';

class LoginBottomSheet extends StatelessWidget {
  const LoginBottomSheet({super.key});

  bool get showAppleButton {
    if (kIsWeb) return false;
    // Tu pourras affiner avec un test de plateforme natif plus tard
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      maxChildSize: 0.75,
      minChildSize: 0.4,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1E1E1E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: ListView(
            controller: scrollController,
            children: [
              const Text(
                "Connect to Anki PWA",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 20),

              /// Google
              _LoginButton(
                label: "Continue with Google",
                icon: Icons.g_mobiledata,
                onTap: () {
                  // à implémenter
                },
              ),

              const SizedBox(height: 10),

              /// Apple (uniquement si !web)
              if (showAppleButton)
                _LoginButton(
                  label: "Continue with Apple",
                  icon: Icons.apple,
                  onTap: () {
                    // à implémenter
                  },
                ),

              const SizedBox(height: 10),

              /// Email
              _LoginButton(
                label: "Continue with Email",
                icon: Icons.mail_outline,
                onTap: () {
                  // formulaire email/mot de passe à afficher
                },
              ),

              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    // rediriger vers inscription
                  },
                  child: const Text(
                    "Don’t have an account? Sign up",
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _LoginButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF2A2A2A),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      icon: Icon(icon, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white)),
      onPressed: onTap,
    );
  }
}
