import 'dart:ui';
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';
import 'comapre.dart';

class myImg {
  img.Image _firstIm, _secondIm, diffIm;

  myImg(this._firstIm, this._secondIm);
}

//url random Img
//"https://source.unsplash.com/random/black?fm=png&fit=crop&w=300&max-h=500"
//"https://source.unsplash.com/random/white?fm=png&fit=crop&w=300&max-h=500"
void main() async {
  var im = myImg(
      await getImg(
          "https://images.unsplash.com/photo-1579781354147-e863d998e97f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&fm=png&w=400&h=600"),
      await getImg(
          "https://images.unsplash.com/photo-1579781403313-56447cb42199?ixlib=rb-1.2.1&fm=png&w=400&h=600"));

  return (runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            title: Text("Compare Image"),
          ),
          body: myApp(im._firstIm, im._secondIm)))));
}

class myApp extends StatelessWidget {
  img.Image _firstIm, _secondIm;
  myApp(this._firstIm, this._secondIm);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://image.freepik.com/free-vector/dark-blue-polygonal-mosaic-background_1035-18012.jpg"),
              fit: BoxFit.cover)),
      child: Center(
        child: Column(children: [
          Expanded(
              child: Container(
                  width: 250,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1579781354147-e863d998e97f?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&fm=png&w=400&h=600"),
                          fit: BoxFit.fill),
                      border:
                          Border.all(width: 4.0, color: Color(0xFFFF7F7F7F)),
                      borderRadius: BorderRadius.circular(12)))),
          Expanded(
              child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SecondScreen(
                                Diff_pixel.compareImg(_firstIm, _secondIm))));
                  },
                  child: Text(
                    "Compare",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ))),
          Expanded(
              child: Container(
                  width: 250,
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                              "https://images.unsplash.com/photo-1579781403313-56447cb42199?ixlib=rb-1.2.1&fm=png&w=400&h=600"),
                          fit: BoxFit.fill),
                      border:
                          Border.all(width: 4.0, color: Color(0xFFFF7F7F7F)),
                      borderRadius: BorderRadius.circular(12))))
        ]),
      ),
    );
  }
}

// ignore: must_be_immutable
class SecondScreen extends StatelessWidget {
  img.Image _diffIm;

  SecondScreen(this._diffIm);
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Back")),
        body: Container(
            color: Colors.black,
            padding: new EdgeInsets.all(5.0),
            child: Center(
              child: new Image.memory(img.encodePng(_diffIm)),
            )));
  }
}
