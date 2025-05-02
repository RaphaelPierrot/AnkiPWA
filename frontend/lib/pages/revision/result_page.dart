import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final int score; // en pourcentage

  const ResultPage({super.key, this.score = 60});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _scaleAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void goHome() => Navigator.popUntil(context, ModalRoute.withName('/'));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E1E1E),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/Trophy.webp', // ajoute une image de trophée
                  width: 150,
                  height: 150,
                ),
                const SizedBox(height: 20),
                const Text("Congratulations",
                    style: TextStyle(fontSize: 26, color: Colors.white)),
                const SizedBox(height: 10),
                const Text("You have scored",
                    style: TextStyle(fontSize: 18, color: Colors.white70)),
                const SizedBox(height: 30),
                Text(
                  "${widget.score} %",
                  style: const TextStyle(
                      fontSize: 40,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: goHome,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 14),
                  ),
                  child: const Text("Back Home"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
