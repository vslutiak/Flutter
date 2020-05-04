import 'dart:math';
import 'package:flutter/material.dart';


void main(){
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget
{
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State <MyApp>
{
  Random _random = Random();
  Color _color = Color(0xFFFFFFFF);
  void ChangeColor(){
    setState(() {
      _color = Color.fromRGBO(
          _random.nextInt(256),
          _random.nextInt(256),
          _random.nextInt(256),
          _random.nextDouble());
    });
  }
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => ChangeColor(),
        child: Container(
         color: _color,
          child: NewText(),
        ),
      ),
    );
  }
}

class NewText extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return Center(

      child: Text(
        'Hey there',
        textDirection: TextDirection.ltr,
      ),
    );
  }
}