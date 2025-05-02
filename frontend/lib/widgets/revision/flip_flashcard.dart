import 'dart:math' as math;
import 'package:flutter/material.dart';

class FlipFlashcard extends StatefulWidget {
  final String question;
  final String answer;

  const FlipFlashcard({
    super.key,
    required this.question,
    required this.answer,
  });

  @override
  State<FlipFlashcard> createState() => _FlipFlashcardState();
}

class _FlipFlashcardState extends State<FlipFlashcard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl = AnimationController(
    duration: const Duration(milliseconds: 350),
    vsync: this,
  );

  bool get _isBack => _ctrl.value >= 0.5;

  void _toggle() {
    if (_isBack) {
      _ctrl.reverse(); // repasse vers 0 ⇒ recto
    } else {
      _ctrl.forward(); // passe à 1 ⇒ verso
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, cst) {
        final w = cst.maxWidth;
        final h = cst.maxHeight;

        return Center(
          child: GestureDetector(
            onTap: _toggle,
            child: AnimatedBuilder(
              animation: _ctrl,
              builder: (_, __) {
                final angle = _ctrl.value * math.pi; // 0 → π
                final isBack = angle > math.pi / 2;

                // on remet le texte dans le bon sens côté verso
                final transform = Matrix4.identity()
                  ..setEntry(3, 2, 0.001)
                  ..rotateY(angle);

                return Transform(
                  alignment: Alignment.center,
                  transform: transform,
                  child: Container(
                    width: w,
                    height: h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2A2A2A),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 10,
                            offset: Offset(0, 4))
                      ],
                    ),
                    child: isBack
                        ? _buildBack() // verso
                        : _buildFront(), // recto
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  // ---------- faces ----------
  Widget _buildFront() => _buildContent(
        icon: Icons.volume_up,
        text: widget.question,
        footer: TextButton.icon(
          onPressed: _toggle,
          icon: const Icon(Icons.lightbulb, color: Colors.amber),
          label:
              const Text('Show Answer', style: TextStyle(color: Colors.white)),
        ),
      );

  Widget _buildBack() => Transform(
        alignment: Alignment.center,
        transform: Matrix4.rotationY(math.pi), // remet le texte à l’endroit
        child: _buildContent(
          icon: Icons.volume_up,
          text: widget.answer,
          footer: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
            ),
            child: const Text('✨ Explain me'),
          ),
        ),
      );

  // ---------- gabarit ----------
  Widget _buildContent({
    required IconData icon,
    required String text,
    required Widget footer,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Icon(icon, color: Colors.white70)),
            Text(text,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white, fontSize: 22)),
            footer,
          ],
        ),
      );
}
