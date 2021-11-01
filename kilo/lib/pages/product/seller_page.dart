import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kilo/models/poket_data.dart';

import 'package:kilo/models/reviews.dart';
import 'package:kilo/models/seller_profile.dart';

import 'package:kilo/pages/product/product_page.dart';
import 'package:kilo/pages/storage/storage.dart';
import 'package:kilo/pages/storage/streams.dart';
import 'package:kilo/pages/ui_component/image_error.dart';
import 'package:kilo/pages/ui_component/product_card.dart';
import 'package:share_plus/share_plus.dart';

class SellerPage extends StatefulWidget {
  @override
  _SellerPageState createState() => _SellerPageState();
}

class _SellerPageState extends State<SellerPage> {
  int index = 1;
  int sub = 0;
  bool check = false;
  bool _isLoading = true;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SellerInf>(
        stream: Streams().seller,
        builder: (context, sellerSnapshot) {
          if (sellerSnapshot.hasData) {
            SellerInf? seller = sellerSnapshot.data;
            String name = seller!.name.split(' ').last;
            return Scaffold(
                backgroundColor: Colors.white,
                // extendBodyBehindAppBar: true,
                appBar: AppBar(
                  title: Text(
                    name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500),
                  ),
                  iconTheme: IconThemeData(
                    color: Colors.black, //change your color here
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Share.share("https://2kilo.co/seller/${seller.id}");
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
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10, left: 10, right: 10),
                    child: ListView(children: [
                      Row(
                        children: [
                          Container(
                            width: 82.2,
                            height: 82.2,
                            child: Stack(
                              children: [
                                Positioned(
                                    bottom: 10,
                                    left: 10,
                                    child: Container(
                                        width: 64,
                                        height: 64,
                                        decoration: BoxDecoration(
                                            //color: Colors.black,
                                            borderRadius:
                                                BorderRadius.circular(17)),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(17),
                                            ),
                                            child: CachedNetworkImage(
                                                fit: BoxFit.fill,
                                                imageUrl: seller.avatar,
                                                errorWidget: (context, error,
                                                        _) =>
                                                    ImageDownloadError())))),
                                Positioned(
                                    top: 0,
                                    right: 0,
                                    child: GestureDetector(
                                        child: Container(
                                            height: 35,
                                            width: 35,
                                            child: SvgPicture.asset(
                                              'images/sms.svg',
                                              fit: BoxFit.none,
                                              color: Colors.white,
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.white,
                                                  width: 3),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.green,
                                            )))),
                                seller.rating != 0.0
                                    ? Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          width: 45,
                                          height: 25,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Color.fromRGBO(
                                                246, 248, 250, 1),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(seller.rating.toString()),
                                              SizedBox(
                                                width: 1,
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: 15,
                                                color: Color.fromRGBO(
                                                    255, 122, 0, 1),
                                              )
                                            ],
                                          ),
                                        ))
                                    : const SizedBox(
                                        width: 1,
                                      ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: seller.count.toString(),
                                        style: TextStyle(
                                          color: Color.fromRGBO(24, 23, 37, 1),
                                          fontFamily: 'SFMedium',
                                          fontSize: 16,
                                        )),
                                    TextSpan(
                                      text: ' позиции',
                                      style: TextStyle(
                                        color: Color.fromRGBO(154, 154, 157, 1),
                                        fontFamily: 'SFMedium',
                                        fontSize: 16,
                                      ),
                                    ),
                                  ]),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                    color: Color.fromRGBO(106, 175, 63, 1),
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                        color: Color.fromRGBO(106, 175, 63, 1),
                                        width: 3)),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: TextButton(
                                      onPressed: () async {
                                        if (seller.subsc.isNotEmpty) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          await Storages().removeSubscriptions(
                                              seller.subsc.first);
                                          Streams().getSell(seller.id);
                                          setState(() {
                                            sub = 1;
                                            _isLoading = true;
                                          });
                                        } else if (seller.subsc.isEmpty) {
                                          setState(() {
                                            _isLoading = false;
                                          });
                                          await Storages()
                                              .addSubscriptions(seller.id);
                                          Streams().getSell(seller.id);
                                          setState(() {
                                            sub = 2;
                                            _isLoading = true;
                                          });
                                        }
                                      },
                                      child: _isLoading
                                          ? Text(
                                              seller.subsc.isEmpty && sub == 0
                                                  ? 'Подписаться'
                                                  : sub == 1
                                                      ? 'Подписаться'
                                                      : 'Отписаться',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 18,
                                                fontFamily: 'SFBold',
                                              ))
                                          : CircularProgressIndicator()),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Узнавайте первыми о поступлении нового товара у продавца',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color.fromRGBO(154, 154, 157, 1),
                                  fontFamily: 'SFMedium',
                                  fontSize: 14,
                                ),
                              )
                            ],
                          ))
                        ],
                      ),
                      Divider(),
                      const SizedBox(
                        height: 5,
                      ),
                      body(seller),
                    ])));
          } else {
            return Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget body(SellerInf sell) {
    List<Widget> card = sell.product
        .map((e) => 
        GestureDetector(
          onTap: (){
            Streams().addProduct(e.id);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ProductPage(
                          login: true,
                        )));
          },
          child: 
        ProductCard(
              product: e,
              callback: () {
                Streams().addProduct(e.id);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => ProductPage(
                          login: true,
                        )));
              },
            )))
        .toList();
    List<Widget> revCard = sell.revs.map((e) => revs(e)).toList();
    return Container(
        height: MediaQuery.of(context).size.height,
        child: Stack(children: [
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Отзывы',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  )),
                  RatingBarIndicator(
                    rating: sell.rating.toDouble(),
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: Color.fromRGBO(255, 122, 0, 1),
                    ),
                    itemCount: 5,
                    itemSize: 20.0,
                    direction: Axis.horizontal,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (!check) {
                            check = true;
                          } else
                            check = false;
                        });
                      },
                      icon: !check
                          ? Icon(Icons.navigate_next)
                          : Icon(Icons.expand_more))
                ],
              ),
              Visibility(
                  visible: check,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ...revCard,
                      Align(
                        alignment: Alignment.bottomRight,
                        child: InkWell(
                          onTap: () {},
                          child: SizedBox(
                            height: 25,
                            width: 100,
                            child: Container(
                              // decoration: BoxDecoration(
                              //     border: Border.all(color: Colors.black)),
                              child: Text(
                                'смотреть ещё',
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ),
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
                    'Товары продавца',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  )),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          if (index != 1) {
                            index = 1;
                          } else
                            index = -1;
                        });
                      },
                      icon: index != 1
                          ? Icon(Icons.navigate_next)
                          : Icon(Icons.expand_more))
                ],
              ),
              Divider(),
              Visibility(
                  visible: index == 1,
                  child: Container(
                      // width: 100,
                      height: 500,
                      child: GridView(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 1.5 / 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        children: [...card],
                      )))
            ],
          ),
          myPoket.count.length != 0
              ? Positioned(
                  right: 0,
                  top: MediaQuery.of(context).size.height / 2,
                  child: Container(
                      width: 82.2,
                      height: 82.2,
                      child: Stack(children: [
                        Positioned(
                            top: 5,
                            child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Container(
                                    height: 65,
                                    width: 65,
                                    child: SvgPicture.asset(
                                      'images/pocket.svg',
                                      fit: BoxFit.none,
                                      width: 20,
                                      height: 20,
                                      color: Colors.white,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 4),
                                      borderRadius: BorderRadius.circular(22),
                                      color: Color.fromRGBO(106, 175, 63, 1),
                                    )))),
                        Positioned(
                            top: 0,
                            right: 10,
                            child: ClipOval(
                                child: Container(
                              width: 25,
                              height: 25,
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 4),
                                borderRadius: BorderRadius.circular(100),
                                color: Color.fromRGBO(106, 175, 63, 1),
                              ),
                              child: Text(
                                myPoket.count.length.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            )))
                      ])))
              : const SizedBox(
                  width: 1,
                )
        ]));
  }

  Widget revs(Reviews rev) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  width: 40.2,
                  height: 40.2,
                  child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          //color: Colors.black,
                          borderRadius: BorderRadius.circular(14)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(14),
                          ),
                          child: rev.anonymous
                              ? SvgPicture.asset(
                                  'images/icon.svg',
                                  fit: BoxFit.fill,
                                )
                              : CachedNetworkImage(
                                  fit: BoxFit.fill,
                                  imageUrl: rev.avatar,
                                  errorWidget: (context, error, _) =>
                                      ImageDownloadError())))),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Text(
                      rev.anonymous ? 'Продавец' : rev.name.split(' ').first,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Row(children: [
                      RatingBarIndicator(
                        rating: rev.rating.toDouble(),
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Color.fromRGBO(255, 122, 0, 1),
                        ),
                        itemCount: 5,
                        itemSize: 15.0,
                        direction: Axis.horizontal,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text('${rev.rating.toString()}/5')
                    ]),
                  ])),
              Text(rev.createdAt,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(104, 104, 104, 1)))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 50, right: 50),
            child: Text(
              rev.comment,
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(124, 124, 124, 1)),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
