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
          title: Text(
            "Weather",
            style: TextStyle(color: Colors.black87),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {},
          ),
          iconTheme: IconThemeData(color: Colors.black),
          brightness: Brightness.light, // яркость appbar
          actions: [IconButton(icon: Icon(Icons.settings), onPressed: () {})],
        ),
        body: _buildBody(),
      ),
    );
  }
}

Widget _buildBody() {
  return SingleChildScrollView(
    child: Column(children: [
      _headerImage(),
      SafeArea(
          child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _weatherDescription(),
                    Divider(),
                    _temperature(),
                    Divider(),
                    _temperatureForecast(),
                    Divider(),
                    _footerRatings()
                  ])))
    ]),
  );
}

Image _headerImage() {
  return Image(
      image: NetworkImage(
          "https://images.unsplash.com/photo-1610056754746-a51f344b3205?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80"),
      fit: BoxFit.cover);
}

Column _weatherDescription() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Text(
        'Tuesday - May 22',
        style: TextStyle(
            color: Colors.black, fontSize: 32.0, fontWeight: FontWeight.bold),
      ),
      Divider(),
      Text(
        'bla-bla-bla-bla',
        style: TextStyle(color: Colors.black54),
      )
    ],
  );
}

Row _temperature() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.wb_sunny,
            color: Colors.yellow,
          )
        ],
      ),
      SizedBox(
        width: 16.0,
      ),
      Column(
        children: [
          Row(
            children: [
              Text(
                '15°С Clear',
                style: TextStyle(color: Colors.deepPurple),
              )
            ],
          ),
          Row(
            children: [
              Text(
                'kiev obl, bla bla bla',
                style: TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      )
    ],
  );
}

Wrap _temperatureForecast() {
  return Wrap(
    spacing: 10,
    children: List.generate(8, (int index) {
      return Chip(
        label: Text(
          "${index + 20}°С",
          style: TextStyle(fontSize: 15.0),
        ),
        avatar: Icon(Icons.wb_cloudy, color: Colors.blue),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
            side: BorderSide(color: Colors.grey)),
        backgroundColor: Colors.grey.shade100,
      );
    }),
  );
}

Row _footerRatings() {
  var stars = Row(
    children: List.generate(5, (int index) {
      if (index > 2) {
        return Icon(Icons.star, size: 15, color: Colors.black);
      }
      return Icon(Icons.star, size: 15, color: Colors.yellow[600]);
    }),
  );
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      Text("bla bla bla"),
      stars,
    ],
  );
}
