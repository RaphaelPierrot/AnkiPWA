import 'package:flutter/material.dart';
import 'flip_flashcard.dart';

class DraggableFlipCard extends StatefulWidget {
  final Map<String, String> card;
  final void Function(bool mastered) onDecision; // true = YES
  const DraggableFlipCard({
    super.key,
    required this.card,
    required this.onDecision,
  });

  @override
  State<DraggableFlipCard> createState() => _DraggableFlipCardState();
}

class _DraggableFlipCardState extends State<DraggableFlipCard>
    with SingleTickerProviderStateMixin {
  Offset _offset = Offset.zero; // position actuelle
  double _angle = 0; // rotation suivant X‑axis

  // seuil pour décider
  bool get _isYes => _offset.dx > 120;
  bool get _isNo => _offset.dx < -120;
  bool get _decided => _isYes || _isNo;

  void _onPanUpdate(DragUpdateDetails d) {
    setState(() {
      _offset += d.delta;
      // rotation (limite à ±10°)
      _angle = (_offset.dx / 300).clamp(-0.17, 0.17);
    });
  }

  void _onPanEnd([DragEndDetails? _]) {
    if (_decided) {
      widget.onDecision(_isYes);
      // on la rend transparente pendant la transition
      setState(() => _offset = Offset((_isYes ? 1 : -1) * 400, _offset.dy));
      return;
    } else {
      // retour au centre
      setState(() {
        _offset = Offset.zero;
        _angle = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Badge
    final badge = Positioned(
      top: 16,
      child: Opacity(
        opacity: (_offset.dx.abs() / 120).clamp(0, 1),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
          decoration: BoxDecoration(
            color: _isYes
                ? Colors.green.withOpacity(0.8)
                : _isNo
                    ? Colors.red.withOpacity(0.8)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            _isYes
                ? 'YES!'
                : _isNo
                    ? 'NOPE!'
                    : '',
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );

    // remplace la partie "card" dans DraggableFlipCard

    final card = FlipFlashcard(
      question: widget.card['question']!,
      answer: widget.card['answer']!,
    );

//  ➜ container décoré : bordure dynamique
    final decorated = Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          width: 0.5,
          color: _isYes
              ? Colors.green
              : _isNo
                  ? Colors.red
                  : Colors.transparent,
        ),
      ),
      child: card,
    );

    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Transform.translate(
        offset: _offset,
        child: Transform.rotate(
          angle: _angle,
          child: Stack(
              alignment: Alignment.topCenter, children: [decorated, badge]),
        ),
      ),
    );
  }
}
