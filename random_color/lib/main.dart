import 'package:flutter/material.dart';
import 'package:random_color/background_color_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Color backgroundColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          backgroundColor = BackgroundColorService.getRandomRGBColor();
        });
      },
      child: Scaffold(
        backgroundColor: backgroundColor,
        body: Center(
          child: Text(
            'Hello there',
            style: TextStyle(
                fontSize: 24,
                color: BackgroundColorService.isDarkColor(backgroundColor)
                    ? Colors.white
                    : Colors.black),
          ),
        ),
      ),
    );
  }
}
