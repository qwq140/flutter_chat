import 'package:flutter/material.dart';

class ChatBubble extends CustomPainter {
  final Color color;
  final Alignment alignment;

  ChatBubble({required this.color, required this.alignment});

  final double _radius = 10.0;
  final double _x = 10.0;

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    if (alignment == Alignment.topRight) {
      canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          0,
          0,
          size.width - 8,
          size.height,
          bottomLeft: Radius.circular(_radius),
          topLeft: Radius.circular(_radius),
          bottomRight: Radius.circular(_radius),
        ),
        Paint()
          ..color = color
          ..style = PaintingStyle.fill,
      );
      Path path = Path();
      path.moveTo(size.width, 0);
      path.lineTo(size.width - _x, 0);
      path.lineTo(size.width - _x, 20);
      canvas.clipPath(path);
      canvas.drawRRect(
        RRect.fromLTRBAndCorners(size.width - _x, 0, size.width, size.height,
            bottomRight: Radius.circular(_radius)),
        Paint()
          ..color = color
          ..style = PaintingStyle.fill,
      );
    } else {
      canvas.drawRRect(
        RRect.fromLTRBAndCorners(
          8,
          0,
          size.width,
          size.height,
          bottomLeft: Radius.circular(_radius),
          bottomRight: Radius.circular(_radius),
          topRight: Radius.circular(_radius),
        ),
        Paint()
          ..color = color
          ..style = PaintingStyle.fill,
      );
      Path path = Path();
      path.lineTo(_x, 0);
      path.lineTo(_x, 20);
      canvas.clipPath(path);
      canvas.drawRRect(
        RRect.fromLTRBAndCorners(0, 0, _x, size.height,
            bottomLeft: Radius.circular(_radius)),
        Paint()
          ..color = color
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
