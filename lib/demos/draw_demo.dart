import 'package:flutter/material.dart';

class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points);

  final List<Offset> points;

  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null)
        canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  bool shouldRepaint(SignaturePainter other) => other.points != points;
}
class Signature extends StatefulWidget {
  SignatureState createState() => new SignatureState();
}
class SignatureState extends State<Signature> {
  List<Offset> _points = <Offset>[];

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Draw App"),
        ),
        body: new Stack(
          children: [
            GestureDetector(
              onPanUpdate: (DragUpdateDetails details) {

                setState(() {
                  _points = new List.from(_points)..add(details.localPosition);
                });
              },
              onPanEnd: (DragEndDetails details) => _points.add(null),
            ),
            CustomPaint(painter: SignaturePainter(_points)),
          ],
        )
    );
  }
}