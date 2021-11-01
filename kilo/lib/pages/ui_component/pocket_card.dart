import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:kilo/models/poket_data.dart';
import 'package:kilo/models/prod.dart';
import 'package:kilo/pages/ui_component/image_error.dart';

class PocketCard extends StatefulWidget {
  PocketCard(
      {required this.prod,
      required this.index,
      required this.remove,
      required this.reload});

  final int index;
  final Prod prod;
  final VoidCallback remove;
  final VoidCallback reload;
  @override
  _PocketCardState createState() => _PocketCardState();
}

class _PocketCardState extends State<PocketCard> {
  late Prod prod;
  late num kg;
  @override
  void initState() {
    print(myPoket.count.first);
    kg = widget.prod.packing;

    super.initState();
    prod = widget.prod;
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 94.2,
              height: 94.2,
              child: Container(
                  width: 94,
                  height: 94,
                  decoration: BoxDecoration(
                      //color: Colors.black,
                      borderRadius: BorderRadius.circular(16)),
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                      child: CachedNetworkImage(
                          fit: BoxFit.fill,
                          imageUrl: prod.image.first,
                          errorWidget: (context, error, _) =>
                              ImageDownloadError())))),
          const SizedBox(
            width: 10,
          ),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        prod.name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      )),
                      InkWell(
                        onTap: () => widget.remove(),
                        child: SizedBox(
                          height: 25,
                          width: 25,
                          child: Container(
                              alignment: Alignment.topRight,
                              // decoration: BoxDecoration(
                              //     border: Border.all(color: Colors.black)),
                              child: Icon(
                                Icons.close,
                                color: Color.fromRGBO(179, 179, 179, 1),
                              )),
                        ),
                      ),
                    ]),
                // const SizedBox(
                //   height: 5,
                // ),
                Text(
                  prod.shortDescr,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(124, 124, 124, 1)),
                ),
                Row(children: [
                  Container(
                      //margin: EdgeInsets.all(1),
                      //  padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.green, width: 1))),
                      child: Row(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                                maximumSize: Size(45, 45),
                                minimumSize: Size(45, 45),
                                alignment: Alignment.bottomLeft,
                                primary: Colors.green,
                                onSurface: Colors.green),
                            onPressed: () {
                              setState(() {
                                if (myPoket.count[widget.index] > kg) {
                                  myPoket.count[widget.index] =
                                      myPoket.count[widget.index] - kg;
                                }
                                widget.reload();
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5,
                                    color: Color.fromRGBO(124, 124, 124, 1)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Icon(
                                Icons.remove,
                                size: 15,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(myPoket.count[widget.index].toStringAsFixed(1),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.black)),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(prod.type.first),
                          TextButton(
                            style: TextButton.styleFrom(
                                maximumSize: Size(45, 45),
                                minimumSize: Size(45, 45),
                                alignment: Alignment.center,
                                primary: Colors.green,
                                onSurface: Colors.green),
                            onPressed: () {
                              setState(() {
                                myPoket.count[widget.index] =
                                    myPoket.count[widget.index] + kg;
                              });
                              widget.reload();
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5,
                                    color: Color.fromRGBO(124, 124, 124, 1)),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      )),
                  Expanded(
                      child: SizedBox(
                    height: 1,
                  )),
                  Text(
                    "${prod.price} грн",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: Colors.black),
                  ),
                ]),
              ])),
          // Text(rev.createdAt,
          //     style: TextStyle(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w400,
          //         color: Color.fromRGBO(104, 104, 104, 1)))
        ],
      ),
    );
  }
}
