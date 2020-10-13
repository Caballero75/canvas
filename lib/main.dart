import 'package:flutter/material.dart';
import './my-painter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Custom Painter',
      theme: ThemeData(
        canvasColor: Color(0xFF559DB5),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(child: MyPainter()),
    );
  }
}
