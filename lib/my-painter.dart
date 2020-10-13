// CAMBRIDGE
// Generative Art with Flutter - Live Coding [Part 2] (2020)
// 174 visualizações•14 de ago. de 2020
// Coding with Indy

import 'dart:math';

import 'package:flutter/material.dart';

import './my-painter-canvas.dart';
import './particle.dart';

class MyPainter extends StatefulWidget {
  MyPainter({Key key}) : super(key: key);

  @override
  _MyPainterState createState() => _MyPainterState();
}

Color getRandomColor(random) {
  var a = random.nextInt(255);
  var r = random.nextInt(255);
  var g = random.nextInt(255);
  var b = random.nextInt(255);
  return Color.fromARGB(a, r, g, b);
}

class _MyPainterState extends State<MyPainter>
    with SingleTickerProviderStateMixin {
  List<Particle> particles;
  Animation<double> animation;
  AnimationController controller;
  Random random = Random(DateTime.now().millisecondsSinceEpoch);
  double maxRadius = 200.0;
  double maxSpeed = 2.5;
  double maxTheta = 1.0 * pi;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
    );

    animation = Tween<double>(
      begin: 0,
      end: 600,
    ).animate(
      controller,
    )
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.fling();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.fling();
    // scontroller.forward();

    this.particles = List.generate(20, (index) {
      var p = Particle();
      p.color = getRandomColor(random);
      p.position = Offset(-5, 5);
      p.speed = random.nextDouble() * maxSpeed;
      p.theta = random.nextDouble() * maxTheta;
      p.radius = random.nextDouble() * maxRadius;
      return p;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: MediaQuery.of(context).size,
            painter: MyPainterCanvas(
              particles,
              random,
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              child: FlatButton.icon(
                color: Color.fromARGB(50, 255, 0, 0),
                onPressed: controller.stop,
                icon: Icon(Icons.stop),
                label: Text("Stop"),
                textColor: Colors.black87,
              ),
            ),
            Container(
              child: FlatButton.icon(
                // shape: ,
                color: Color.fromARGB(50, 0, 100, 0),
                onPressed: controller.fling,
                icon: Icon(Icons.play_circle_outline),
                label: Text("Play"),
                textColor: Colors.green,
              ),
            ),
          ])
        ],
      ),
    );
  }
}
