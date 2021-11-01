import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kilo/models/prod.dart';

class ListImg extends StatefulWidget {
  ListImg({required this.prod});
  final Prod prod;
  @override
  _ListImgState createState() => _ListImgState();
}

class _ListImgState extends State<ListImg> {
  PageController controller =
      PageController(initialPage: 0, viewportFraction: 1);
  int checkPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.only(right: 10, top: 10, left: 10),
      child: Stack(
        children: [
          Container(

              // height: 213,
              width: MediaQuery.of(context).size.width,
              child: PageView.builder(
                itemCount: widget.prod.image.length,
                controller: controller,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(14),
                    ),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: widget.prod.image[index],
                    ),
                  );
                },
              )),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                shape: CircleBorder(),
                padding: EdgeInsets.all(1),
              ),
              onPressed: () {
                controller.previousPage(
                    duration: Duration(milliseconds: 250),
                    curve: Curves.easeIn);
              },
              child: Icon(
                Icons.chevron_left,
                size: 25,
                color: Colors.black,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Color.fromRGBO(255, 255, 255, 1),
                shape: CircleBorder(),
                padding: EdgeInsets.all(1),
              ),
              onPressed: () {
                controller.nextPage(
                    duration: Duration(milliseconds: 250),
                    curve: Curves.easeIn);
              },
              child: Icon(
                Icons.chevron_right,
                size: 25,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
