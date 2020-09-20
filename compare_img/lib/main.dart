import 'dart:ui';
import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:flutter/material.dart';

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
      child: Center(
        child: Column(children: [
          Expanded(
              child: Container(
                  padding: new EdgeInsets.all(5.0),
                  child: new Image.memory(img.encodePng(_firstIm)))),
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
                  padding: new EdgeInsets.all(5.0),
                  child: new Image.memory(img.encodePng(_secondIm))))
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
    return Container(
        padding: new EdgeInsets.all(5.0),
        child: Center(
          child: new Image.memory(img.encodePng(_diffIm)),
        ));
  }
}

Future<dynamic> getImg(url) async {
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var myimg = img.decodeImage(response.bodyBytes);
    return myimg;
  } else {
    print("No such Image");
    io.exit(1);
  }
}

// ignore: camel_case_types
class Diff_pixel {
  static int _diffColor(firstPixel, secondPixel) {
    int firstR = img.getRed(firstPixel);
    int firstG = img.getGreen(firstPixel);
    int firstB = img.getBlue(firstPixel);

    int secondR = img.getRed(secondPixel);
    int secondG = img.getGreen(secondPixel);
    int secondB = img.getBlue(secondPixel);

    int diff = (firstR - secondR).abs() +
        (firstG - secondG).abs() +
        (firstB - secondB).abs();

    if (diff == 0) return img.Color.fromRgba(firstR, firstG, firstB, 225);
    if (firstR == 0 && firstG == 0 && firstB == 0)
      return img.Color.fromRgba(secondR, secondG, secondB, 225);
    if (secondR == 0 && secondG == 0 && secondB == 0)
      return img.Color.fromRgba(firstR, firstG, firstB, 225);
    else
      return img.Color.fromRgba(225, 0, 0, 200);
  }

  static int checkSize(img.Image firstImg, img.Image secondImg) {
    print(firstImg.width);
    print(secondImg.width);
    print(firstImg.height);
    print(secondImg.height);
    if (firstImg.height > secondImg.height) return secondImg.height;
    return firstImg.height;
  }

  static img.Image compareImg(img.Image firstImg, img.Image secondImg) {
    int widht = firstImg.width;
    int height = checkSize(firstImg, secondImg);
    img.Image diffImg = img.Image(widht, height);

    for (var x = 0; x < widht; x++) {
      var firstPixel, secondPixel;
      for (var y = 0; y < height; y++) {
        firstPixel = firstImg.getPixel(x, y);
        secondPixel = secondImg.getPixel(x, y);
        diffImg.setPixel(x, y, _diffColor(firstPixel, secondPixel));
      }
    }
    return diffImg;
  }
}
