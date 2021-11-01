import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:kilo/models/get_data.dart';
import 'package:kilo/models/poket_data.dart';
import 'package:kilo/models/prod.dart';
import 'package:kilo/models/seller.dart';

import 'package:kilo/pages/storage/storage.dart';
import 'package:kilo/pages/storage/streams.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart' as lat;
import 'package:kilo/pages/ui_component/custom_picker.dart';
import 'package:kilo/pages/ui_component/done_screen.dart';

import 'package:kilo/pages/ui_component/image_error.dart';
import 'package:kilo/pages/ui_component/pocket_card.dart';
import 'package:kilo/routes.dart';

class Pocet extends StatefulWidget {
  Pocet({required this.prod, required this.number});
  final num number;
  final Prod prod;
  @override
  _PocetState createState() => _PocetState();
}

class _PocetState extends State<Pocet> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String apiKey = 'AIzaSyAatyXDawvBeERV45qNuwqiNZE7tQpNVfw';
  int val = -1;
  num index = -1;

  String reverse = '';
  late Duration initialtimer;
  List<double> local = [];
  Map<String, dynamic> map = {};
  late Seller seller;
  int _expandedIndex = 0;
  List<Map<String, dynamic>> wid = [];
  late num price = 0;
  late TimeOfDay endTime;
  String time = "";
  bool _check = false;
  String time1 = "";

  @override
  void initState() {
 
    super.initState();
    seller = widget.prod.seller;
    initialtimer = Duration(
        hours:
            int.parse(seller.period[_expandedIndex].timeFrom.split(':').first));
    endTime = TimeOfDay(
        hour: int.parse(seller.period[_expandedIndex].timeTo.split(':').first),
        minute: int.parse(seller.period[_expandedIndex].timeTo.split(':')[1]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              myPoket.pocClear();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/main', (route) => false,
                  arguments: true);
            },
          ),
          title: Text(
            'Оформление заказа',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
          ),
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: SvgPicture.asset(
                'images/location.svg',
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
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Expanded(
                      child: ListView(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        //mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 82.2,
                            height: 82.2,
                            child: Stack(
                              children: [
                                Positioned(
                                    top: 0,
                                    //bottom: 10,
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
                            width: 5,
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                seller.name,
                                //textAlign: TextAlign.center,
                                style: TextStyle(
                                  // color: Color.fromRGBO(154, 154, 157, 1),
                                  fontFamily: 'SFMedium',
                                  fontSize: 16,
                                ),
                              )
                            ],
                          )),
                          InkWell(
                            onTap: () {

                            },
                            child: SizedBox(
                              height: 50,
                              width: 100,
                              child: Container(
                                // decoration: BoxDecoration(
                                //     border: Border.all(color: Colors.black)),
                                child: Text(
                                  'связаться',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      decoration: TextDecoration.underline),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text(
                            'Ваш заказ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: myPoket.count.length,
                          itemBuilder: (context, index) {
                            return PocketCard(
                              prod: myPoket.prod[index],
                              index: index,
                              reload: () {
                                price = 0;
                                myPoket.count.forEach((element) {
                                  num cache = element *
                                      myPoket
                                          .prod[myPoket.count.indexOf(element)]
                                          .price;
                                  price += cache;
                                });

                                setState(() {});
                              },
                              remove: () {
                                myPoket.removeIndex(index);
                                setState(() {});
                              },
                            );
                          }),
                      Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: info(seller)),
                    ],
                  )),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 52,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(246, 248, 250, 1),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: Color.fromRGBO(246, 248, 250, 1), width: 3)),
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: TextButton(
                          onPressed: () async {
                            // Navigator.of(context).pushNamed(Routes)
                            Streams().getSell(seller.id);
                            Navigator.of(context).pushNamed(Routes.seller);
                            // builder: (context) => SellerPage()));
                          },
                          child: Text('Добавить ещё товары',
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                fontFamily: 'SFBold',
                                color: Color.fromRGBO(106, 175, 63, 1),
                              ))),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
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
                          onPressed: () async {
                            if (val == -1 || local.isEmpty && seller.delivery[val] == 'Доставим') {
                              _scaffoldKey.currentState!
                                  // ignore: deprecated_member_use
                                  .showSnackBar(new SnackBar(
                                duration: new Duration(seconds: 2),
                                content: new Row(
                                  children: <Widget>[
                                    new Text('Выберите тип доставки и локацию')
                                  ],
                                ),
                              ));
                            } else if (time == '' &&
                                val != -1 &&
                                time1 == '' &&
                                seller.delivery[val] != 'Отправка почтой') {
                              _scaffoldKey.currentState!
                                  // ignore: deprecated_member_use
                                  .showSnackBar(new SnackBar(
                                duration: new Duration(seconds: 2),
                                content: new Row(
                                  children: <Widget>[
                                    new Text('Выберите время')
                                  ],
                                ),
                              ));
                            } else {
                              Map<String, dynamic> done = {};
                              var date = wid[_expandedIndex]['date']
                                  .toString()
                                  .split(' ')
                                  .first;
                              Map<String, dynamic> cache = {};
                              List<Map<String, dynamic>> data =
                                  myPoket.count.map((e) {
                                cache = {
                                  "product_id":
                                      myPoket.prod[myPoket.count.indexOf(e)].id,
                                  "quantity": e
                                };
                                return cache;
                              }).toList();

                              if (time == '' || time1 == '') {
                                if (local.isEmpty){
                                  local.add(0);
                                }
                                done = {
                                  "seller_id": seller.id,
                                  "delivery_type": "post",
                                  "date": date,
                                  "location": {
                                    "type": "Point",
                                    "coordinates": [local.first, local.last]
                                  },
                                  "order_products": {"data": data}
                                };
                              } else {
                                String delivType = 'deliver';
                                if (seller.delivery[val] == 'Самовывоз') {
                                  delivType = 'pickup';
                                }
                                if (local.isEmpty){
                                  local.add(0);
                                }
                                done = {
                                  "seller_id": seller.id,
                                  "delivery_type": delivType,
                                  "date": date,
                                  "time_from": time1,
                                  "time_to": time,
                                  "location": {
                                    "type": "Point",
                                    "coordinates": [local.first, local.last]
                                  },
                                  "order_products": {"data": data}
                                };
                              }
                              print(done.toString());
                              setState(() {
                                _check = true;
                              });
                              await Storages().buy(done);
                               setState(() {
                                _check = false;
                              });
                              
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Done()));
                            }
                          },
                          child: _check ? CircularProgressIndicator() : Row(children: [
                            Text("$price грн",
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
                                  "$price грн",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ))
                          ]),
                        ),
                      )),
                  const SizedBox(
                    height: 5,
                  )
                  //body(widget.prod)
                ])));
  }

  Widget info(Seller seller) {
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
    List<Widget> deliv = seller.delivery.map((e) {
      return Row(children: [
        Radio(
            value: seller.delivery.indexOf(e),
            groupValue: val,
            activeColor: Color.fromRGBO(106, 175, 63, 1),
            onChanged: (value) {
              setState(() {
                val = value as int;
              });
            }),
        e == 'Доставим'
            ? Container(
                width: MediaQuery.of(context).size.width - 80,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        child: Text(
                      e,
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    )),
                    Container(
                        alignment: Alignment.centerRight,
                        width: 150,
                        height: 50,
                        child: Text(
                          reverse == '' ? 'Укажите адрес' : reverse,
                          maxLines: 2,
                          textAlign: TextAlign.end,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color.fromRGBO(154, 154, 157, 1)),
                        )),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return PlacePicker(
                              autocompleteLanguage: 'RU',
                              apiKey: apiKey,
                              initialPosition: lat.LatLng(50.450001, 30.523333),
                              useCurrentLocation: true,
                              selectInitialPosition: true,
                              usePlaceDetailSearch: true,
                              onPlacePicked: (result) async {
                                // List<String> local = [];
                                local.add(result.geometry!.location.lat);
                                local.add(result.geometry!.location.lng);
                                var cache = result.formattedAddress!.split(',');
                                cache.removeLast();
                                reverse = cache.join(',');
                                setState(() {});

                                Navigator.of(context).pop();
                              },
                            );
                          }));
                        },
                        icon: SvgPicture.asset('images/location.svg'))
                  ],
                ))
            : Text(
                e,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
      ]);
    }).toList();
    return Column(
      children: [
        Divider(),
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
        Align(
            alignment: Alignment.bottomLeft,
            child: Visibility(
                visible: index == 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [...deliv],
                ))),
        Divider(),
        Row(
          children: [
            Expanded(
                child: Text(
              'Дата и время',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            )),
            index == 3
                ? Text(
                    wid[_expandedIndex]['month'] ?? '',
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
        const SizedBox(
          height: 10,
        ),
        Visibility(
            visible: index == 3,
            child: Column(
              children: [
                list(),
                const SizedBox(
                  height: 10,
                ),
                val != -1 && seller.delivery[val] != 'Отправка почтой'
                    ? Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'C',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            _dateInput(),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'до',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            _dateInput1()
                          ],
                        ))
                    : const SizedBox(
                        height: 1,
                      )
              ],
            )),
      ],
    );
  }

  Widget list() {
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
                              height: 5,
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
          height: 10,
        ),
      ],
    );
  }

  Widget _dateInput() {
    return GestureDetector(
      onTap: () {
        bottomSheet(context, timePicker1());
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 100,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Text(
          time1,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        // color: Colors.black,
      ),
    );
  }

  Widget _dateInput1() {
    return GestureDetector(
      onTap: () {
        bottomSheet(context, timePicker());
      },
      child: Container(
        alignment: Alignment.center,
        height: 40,
        width: 100,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Text(
          time,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        // color: Colors.black,
      ),
    );
  }

  Widget timePicker1() {
    return CustomCupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.hm,
      minuteInterval: 1,
      secondInterval: 1,
      initialTimerDuration: initialtimer,
      // startRestriction: startTime,
      endRestriction: endTime,
      onTimerDurationChanged: (Duration changedtimer) {
        setState(() {
          initialtimer = changedtimer;
          time1 = changedtimer.inHours.toString() +
              ':' +
              (changedtimer.inMinutes % 60).toString();
        });
      },
    );
  }

  Widget timePicker() {
    return CustomCupertinoTimerPicker(
      mode: CupertinoTimerPickerMode.hm,
      minuteInterval: 1,
      secondInterval: 1,
      initialTimerDuration: initialtimer,
      endRestriction: endTime,
      onTimerDurationChanged: (Duration changedtimer) {
        setState(() {
          initialtimer = changedtimer;
          time = changedtimer.inHours.toString() +
              ':' +
              (changedtimer.inMinutes % 60).toString();
        });
      },
    );
  }

  Future<void> bottomSheet(
    BuildContext context,
    Widget child,
  ) {
    return showModalBottomSheet(
        isScrollControlled: false,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(13), topRight: Radius.circular(13))),
        backgroundColor: Colors.white,
        context: context,
        builder: (context) => Container(
            height: MediaQuery.of(context).size.height / 3, child: child));
  }
}
