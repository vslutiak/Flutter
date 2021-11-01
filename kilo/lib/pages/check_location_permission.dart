import 'package:flutter/material.dart';

import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kilo/pages/main_page.dart';
import 'package:kilo/pages/services/geolocation_service.dart';
import 'package:kilo/pages/services/shared_preferences_service.dart';
// import "package:latlong/latlong.dart" as latLng;

class CheckLocation extends StatefulWidget {
  @override
  _CheckLocationState createState() => _CheckLocationState();
}

class _CheckLocationState extends State<CheckLocation> {
  //PickResult? selectedPlace;
  String apiKey = 'AIzaSyAatyXDawvBeERV45qNuwqiNZE7tQpNVfw';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('images/background.png'))),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Image.asset('images/illustration.png'),
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Ваша локация',
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        fontFamily: 'SFMedium',
                        fontWeight: FontWeight.w500,
                        fontSize: 26,
                        color: Color.fromRGBO(24, 23, 37, 1)),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.3,
                      child: Text(
                          'Для поиска продуктов пожалуйста включите геопозицию или укажите своё нахождение вручную',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w400,
                              fontFamily: 'SFMedium',
                              fontSize: 16,
                              color: Color.fromRGBO(124, 124, 124, 1)))),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 52,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                              onPressed: () async {
                                if (await geolocationService
                                    .determinePosition()) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => MainPage(
                                            token: false,
                                          )));
                                }
                              },
                              color: Color.fromRGBO(106, 175, 63, 1),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: Text('Включить геопозицию',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    fontFamily: 'SFBold',
                                    color: Colors.white,
                                  ))))),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 52,
                      child: Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return PlacePicker(
                                    apiKey: apiKey,
                                    initialPosition:
                                        LatLng(50.450001, 30.523333),
                                    useCurrentLocation: true,
                                    selectInitialPosition: true,
                                    usePlaceDetailSearch: true,
                                    onPlacePicked: (result) async {
                                      List<String> local = [];
                                      local.add(result.geometry!.location.lat
                                          .toString());
                                      local.add(result.geometry!.location.lng
                                          .toString());
                                      // print(local);
                                      await sharedPreferenceService
                                          .setPosition(local);
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => MainPage(
                                                    token: false,
                                                  )));
                                    },
                                  );
                                }));
                              },
                              color: Color.fromRGBO(246, 248, 250, 1),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14.0),
                              ),
                              child: Text('Указать вручную',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    fontFamily: 'SFBold',
                                    color: Color.fromRGBO(106, 175, 63, 1),
                                  ))))),
                  const SizedBox(
                    height: 10,
                  )
                ],
              ),
            )));
  }
}
