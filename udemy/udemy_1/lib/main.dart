import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Counter'),
            centerTitle: true,
          ),
          backgroundColor: Colors.blue,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Tap \'-\' to decrement'),
                Container(
                  width: 120,
                  decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(10)),
                  child: CounterWidget(),
                ),
                Text('Tap \'+\' to increment'),
              ],
            ),
          )),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  int _count = 50;

  void _increment() {
    setState(() {
      _count++;
    });
  }

  void _decrement() {
    setState(() {
      _count -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      IconButton(
          icon: Icon(Icons.remove),
          onPressed: () {
            _decrement();
          }),
      Text('$_count'),
      IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _increment();
          }),
    ]);
  }
}
