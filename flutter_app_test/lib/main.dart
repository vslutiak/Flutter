import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class RandomColor {
  static final Random _random = Random();

  static Color change() {
    var rgb = _random.nextInt(0x00FFFFFF);
    print(rgb);
    return new Color(0xFF000000 + rgb);
  }
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _color;

  void changeColor() {
    setState(() {
      _color =  RandomColor.change();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => changeColor(),
        child: Container(
          color: _color,
          child: NewText(),
        ),
      ),
    );
  }
}

class NewText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Tap the screen',
        textDirection: TextDirection.ltr,
      ),
    );
  }
}
