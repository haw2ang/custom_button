import 'package:flutter/material.dart';

class MyCustomPainter extends CustomPainter {
  final Color color;
  String? buttonText;
  final TextStyle? textStyle;

  MyCustomPainter({
    required this.color,
    this.buttonText = '',
    this.textStyle = const TextStyle(),
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paintFill = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Path backgroundPath = Path();
    backgroundPath.moveTo(size.width * 0.1, size.height * 0.28);
    backgroundPath.lineTo(size.width * 0.15, size.height * 0.1);
    backgroundPath.lineTo(size.width * 0.90, size.height * 0.1);
    backgroundPath.lineTo(size.width * 0.95, size.height * 0.30);
    backgroundPath.lineTo(size.width * 0.95, size.height * 0.67);
    backgroundPath.lineTo(size.width * 0.90, size.height * 0.89);
    backgroundPath.lineTo(size.width * 0.15, size.height * 0.89);
    backgroundPath.lineTo(size.width * 0.1, size.height * 0.77);
    backgroundPath.lineTo(size.width * 0.1, size.height * 0.40);
    backgroundPath.close();

    canvas.drawPath(backgroundPath, paintFill);

    Paint paintStroke = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.012
      ..strokeCap = StrokeCap.butt
      ..strokeJoin = StrokeJoin.miter;

    canvas.drawPath(backgroundPath, paintStroke);

    final textPainter = TextPainter(
      text: TextSpan(text: buttonText, style: textStyle),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    final textX = (size.width - textPainter.width) / 2;
    final textY = (size.height - textPainter.height) / 2;

    textPainter.paint(canvas, Offset(textX, textY));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
