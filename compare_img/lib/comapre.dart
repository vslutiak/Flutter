import 'dart:io' as io;
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;

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
