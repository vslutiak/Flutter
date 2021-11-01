import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:kilo/models/get_data.dart';
import 'package:kilo/models/poket_data.dart';
import 'package:kilo/models/prod.dart';
import 'package:kilo/models/seller.dart';
import 'package:kilo/pages/product/seller_page.dart';
import 'package:kilo/pages/storage/streams.dart';
import 'package:kilo/pages/ui_component/image_error.dart';
import 'package:kilo/pages/ui_component/image_list.dart';
import 'package:share_plus/share_plus.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as lat;

import '../../routes.dart';

class ProductPage extends StatefulWidget {
  ProductPage({required this.login});
  final bool login;
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  Map<String, dynamic> map = {};
  List<Map<String, dynamic>> wid = [];
  int index = -1;
  int _expandedIndex = 0;
  double kg = 1;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Prod>(
        stream: Streams().product,
        builder: (context, productSnapshot) {
          if (productSnapshot.hasData) {
            Prod? product = productSnapshot.data;
            double z = product!.packing;

            return Scaffold(
                backgroundColor: Colors.white,
                // extendBodyBehindAppBar: true,
                appBar: AppBar(
                  iconTheme: IconThemeData(
                    color: Colors.black, //change your color here
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Share.share('https://2kilo.co/product/${product.id}');
                      },
                      child: SvgPicture.asset(
                        'images/download.svg',
                        color: Colors.black,
                        width: 24,
                        height: 24,
                      ),
                    )
                  ],
                  toolbarHeight: 48,
                  backgroundColor: Colors.white,
                  elevation: 0.0,
                ),
                body: Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10),
                  child: Column(children: [
                    Expanded(
                        child: ListView(
                      children: [
                        Container(
                          height: 213,
                          width: 375,
                          child: ListImg(prod: product),
                        ),
                        // Column(children: [
                        //   (Expanded(child: ListImg(prod: product)))
                        // ]),

                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                      height: 1,
                                    )),
                                    Text(
                                      product.date,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color:
                                              Color.fromRGBO(124, 124, 124, 1)),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Text(
                                      product.shortDescr,
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                          color:
                                              Color.fromRGBO(124, 124, 124, 1)),
                                    )),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Container(
                                      //margin: EdgeInsets.all(1),
                                      //  padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.green,
                                                  width: 1))),
                                      child: Row(
                                        children: [
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                maximumSize: Size(55, 55),
                                                minimumSize: Size(55, 55),
                                                alignment: Alignment.bottomLeft,
                                                primary: Colors.green,
                                                onSurface: Colors.green),
                                            onPressed: () {
                                              setState(() {
                                                if (kg > z) {
                                                  kg = kg - z;
                                                }
                                              });
                                            },
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 0.5,
                                                    color: Color.fromRGBO(
                                                        124, 124, 124, 1)),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(14),
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.remove,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 25,
                                          ),
                                          Text(kg.toString(),
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 18,
                                                  color: Colors.black)),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Text(product.type.first),
                                          TextButton(
                                            style: TextButton.styleFrom(
                                                maximumSize: Size(55, 55),
                                                minimumSize: Size(55, 55),
                                                alignment: Alignment.center,
                                                primary: Colors.green,
                                                onSurface: Colors.green),
                                            onPressed: () {
                                              setState(() {
                                                kg = kg + z;
                                              });
                                            },
                                            child: Container(
                                              width: 40,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 0.5,
                                                    color: Color.fromRGBO(
                                                        124, 124, 124, 1)),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(14),
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.add,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: SizedBox(
                                      height: 1,
                                    )),
                                    Text(
                                      "${product.price} грн/${product.type.first}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 18,
                                          color: Colors.black),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Divider(),
                                const SizedBox(
                                  height: 5,
                                ),
                                body(product)
                              ],
                            )),
                        // Padding(
                        //     padding: EdgeInsets.only(left: 10, right: 10),
                        //     child: ),
                      ],
                    )),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: 52,
                        decoration: BoxDecoration(
                            color: Color.fromRGBO(106, 175, 63, 1),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                                color: Color.fromRGBO(106, 175, 63, 1),
                                width: 3)),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: TextButton(
                            onPressed: () {
                              if (widget.login) {
                                myPoket.count.add(kg);
                                myPoket.prod.add(product);
                                Navigator.of(context).pushNamed(Routes.pocet,
                                    arguments: {'prod': product, 'number': kg});
                              } else {
                                Navigator.of(context)
                                    .pushReplacementNamed(Routes.signIn);
                              }
                            },
                            child: Row(children: [
                              Text("${product.price * kg}грн",
                                  style: TextStyle(color: Colors.transparent)),
                              Expanded(
                                  child: Center(
                                      child: Text('Заказать ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18,
                                              fontFamily: 'SFBold',
                                              color: Colors.white)))),
                              Container(
                                  padding: EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(4)),
                                      color: Color.fromRGBO(75, 146, 31, 1)),
                                  child: Text(
                                    "${product.price * kg}грн",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ))
                            ]),
                          ),
                        )),
                    const SizedBox(
                      height: 20,
                    )
                  ]),
                ));
          } else {
            return Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget body(Prod prod) {
    List<Text> tag = prod.tag
        .map((e) => Text("#${e.name} ",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.green)))
        .toList();
    List<Widget> deliv = prod.seller.delivery.map((e) {
      if (e == 'Самовывоз') {
        return Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("- $e",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black)),
                const SizedBox(
                  height: 5,
                ),
                Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: Text(prod.adress,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(126, 131, 137, 1)))),
                const SizedBox(
                  height: 15,
                )
              ],
            ),
            Expanded(
                child: SizedBox(
              width: 1,
            )),
            GestureDetector(
              onTap: () {
                 String apiKey =
                                  'AIzaSyAatyXDawvBeERV45qNuwqiNZE7tQpNVfw';
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return PlacePicker(
                                  apiKey: apiKey,
                                  initialPosition:
                                      lat.LatLng((prod.seller.location['coordinates'] as List).first, (prod.seller.location['coordinates'] as List).last),
                                  useCurrentLocation: true,
                                  selectInitialPosition: true,
                                  usePlaceDetailSearch: true,
                                  onPlacePicked: (result) async {
                                  
                                    Navigator.of(context).pop();
                                  },
                                );
                              }));
              },
              child: SvgPicture.asset('images/location.svg'),
            ),
            const SizedBox(
              width: 15,
            )
          ],
        );
      } else
        return Row(
          //mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Column(
           mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('- $e',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            const SizedBox(
              height: 20,
            )
          ],
        )]);
    }).toList();
    return Container(
        //  height: MediaQuery.of(context).size.height / 3.2,
        child: Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              'О продукте',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            )),
            IconButton(
                onPressed: () {
                  setState(() {
                    if (index != 0) {
                      index = 0;
                    } else
                      index = -1;
                  });
                },
                icon: index != 0
                    ? Icon(Icons.navigate_next)
                    : Icon(Icons.expand_more))
          ],
        ),
        Visibility(
            visible: index == 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(prod.description,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(124, 124, 124, 1))),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [...tag],
                )
              ],
            )),
        Divider(),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(
                child: Text(
              'Продавец',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            )),
            Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: CachedNetworkImage(
                    imageUrl: prod.seller.avatar,
                    fit: BoxFit.fill,
                    errorWidget: (context, error, _) => ImageDownloadError(),
                  ),
                )),
            const SizedBox(
              width: 5,
            ),
            prod.seller.rating != 0.0
                ? Container(
                    width: 38,
                    height: 17,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Color.fromRGBO(246, 248, 250, 1),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          prod.seller.rating.toString(),
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        Icon(
                          Icons.star,
                          size: 10,
                          color: Color.fromRGBO(255, 122, 0, 1),
                        )
                      ],
                    ),
                  )
                : const SizedBox(
                    width: 1,
                  ),
            IconButton(
                onPressed: () async {
                  if (widget.login) {
                    Streams().getSell(prod.seller.id);
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SellerPage()));
                  } else {
                    Navigator.of(context).pushReplacementNamed(Routes.signIn);
                  }
                },
                icon: Icon(Icons.navigate_next))
          ],
        ),
        Divider(),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(
                child: Text(
              'Тип доставки',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            )),
            IconButton(
                onPressed: () {
                  setState(() {
                    if (index != 2) {
                      index = 2;
                    } else
                      index = -1;
                  });
                },
                icon: index != 2
                    ? Icon(Icons.navigate_next)
                    : Icon(Icons.expand_more))
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Visibility(
            visible: index == 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [...deliv],
            )),
        Divider(),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Expanded(
                child: Text(
              'Дата и время',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            )),
            index == 3
                ? Text(
                    wid[_expandedIndex]['month'],
                    style: TextStyle(
                        color: Color.fromRGBO(154, 154, 157, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  )
                : const SizedBox(
                    width: 1,
                  ),
            IconButton(
                onPressed: () {
                  setState(() {
                    if (index != 3) {
                      index = 3;
                    } else
                      index = -1;
                  });
                },
                icon: index != 3
                    ? Icon(Icons.navigate_next)
                    : Icon(Icons.expand_more))
          ],
        ),
        // Divider(),
        const SizedBox(
          height: 15,
        ),
        Visibility(
            visible: index == 3,
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: list(prod.seller))),
      ],
    ));
  }

  Widget list(Seller seller) {
    wid = seller.period.map((e) {
      DateTime day = DateTime.parse(e.date);

      map = {
        'date': day,
        'day': GetData.day(day.weekday),
        'month': GetData.month(day.month),
        'number': e.date.split('-').last,
        'text': 'c ${e.timeFrom.substring(0, 5)} до ${e.timeTo.substring(0, 5)}'
      };
      return map;
    }).toList();
    return Column(
      children: [
        Container(
            // width: 56,
            height: 72,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: wid.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (DateTime.now()
                              .subtract(const Duration(days: 1))
                              .isBefore(wid[index]['date'])) {
                            _expandedIndex = index;
                          }
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(right: 5, left: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          color: _expandedIndex == index
                              ? Color.fromRGBO(106, 175, 63, 1)
                              : Color.fromRGBO(246, 248, 250, 1),
                        ),
                        //height: 72,
                        width: 56,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              wid[index]['number'],
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: _expandedIndex == index
                                      ? Colors.white
                                      : Color.fromRGBO(136, 135, 156, 1)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              wid[index]['day'],
                              style: TextStyle(
                                  fontSize: 13,
                                  // fontWeight: FontWeight.w700,
                                  color: _expandedIndex == index
                                      ? Colors.white
                                      : Color.fromRGBO(136, 135, 156, 1)),
                            )
                          ],
                        ),
                      ));
                })),
        const SizedBox(
          height: 25,
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: Visibility(
                // visible: _expandedIndex ,
                child: Text(
              wid[_expandedIndex]['text'],
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            )))
      ],
    );
  }
}
