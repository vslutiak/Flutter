import 'package:flutter/material.dart';

class ImageDownloadError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          padding: EdgeInsets.all(16),
          alignment: Alignment.center,
          child: Text(
            "Error download",
            style: TextStyle(color: Colors.blue),
            // ontSize: 8,
            maxLines: 3,
          )),
    );
  }
}
