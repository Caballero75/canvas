import 'dart:math';

import 'package:flutter/material.dart';

import './particle.dart';

Offset polarToCartesian(double speed, double theta) {
  // return Offset(speed * (cos(theta)), speed * sin(theta));
  return Offset(speed * 0.2, speed * 3);
}

class MyPainterCanvas extends CustomPainter {
  List<Particle> particles;
  Random random;
  MyPainterCanvas(
    this.particles,
    this.random,
  );

  @override
  // size = MediaQuery.of(context).size.width;
  void paint(Canvas canvas, Size size) {
    // update object
    this.particles.forEach((p) {
      var velocity = polarToCartesian(p.speed, p.theta);
      var dx = p.position.dx + velocity.dx;
      var dy = p.position.dy + velocity.dy;

      if (p.position.dx < 0 || p.position.dx > size.width) {
        dx = random.nextDouble() * size.width;
      }
      if (p.position.dy < 0 || p.position.dy > size.height) {
        dy = random.nextDouble() * size.height;
      }
      p.position = Offset(dx, dy);
    });

    // paint the object
    this.particles.forEach((prtcl) {
      var paint = Paint();
      paint.color = prtcl.color;
      canvas.drawCircle(prtcl.position, prtcl.radius, paint);
      // canvas.drawColor(Colors.yellowAccent, BlendMode.difference);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
