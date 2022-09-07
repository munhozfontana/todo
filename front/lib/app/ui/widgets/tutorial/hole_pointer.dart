import 'package:flutter/cupertino.dart';

class HolePainter extends CustomPainter {
  final GlobalKey<State<StatefulWidget>> key;

  HolePainter({
    required this.key,
  });

  @override
  void paint(Canvas canvas, Size sizePaint) {
    final paint = Paint()..color = const Color.fromRGBO(0, 0, 0, 0.8);
    final size = key.currentContext!.size!;

    final translation = key.currentContext!
        .findRenderObject()!
        .getTransformTo(null)
        .getTranslation();
    Offset(translation.x, translation.y);

    int levelPadding = 12;

    canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          Path()
            ..addRect(Rect.fromLTWH(0, 0, sizePaint.width, sizePaint.height)),
          Path()
            ..lineTo(
              translation.x - levelPadding,
              translation.y - levelPadding,
            )
            ..lineTo(
              translation.x - levelPadding,
              translation.y + size.height + levelPadding,
            )
            ..lineTo(
              translation.x + size.width + levelPadding,
              translation.y + size.height + levelPadding,
            )
            ..lineTo(
              translation.x + size.width + levelPadding,
              translation.y - levelPadding,
            )
            ..lineTo(
              translation.x - levelPadding,
              translation.y - levelPadding,
            )
            ..close(),
        ),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
