import 'dart:io' show Platform;

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:test_ramedia/src/splash/providers.dart';

part 'init_app_services.g.dart';

const List<String> filteredCountryCode = ['ua'];
const List<String> filteredLocale = ['uk_UA'];

const List<String> filteredIpList = [];

bool _connectivityStatus(ConnectivityResult connectivityResult) {
  switch (connectivityResult) {
    case ConnectivityResult.bluetooth:
      return false;
    case ConnectivityResult.wifi:
      return false;
    case ConnectivityResult.ethernet:
      return false;
    case ConnectivityResult.mobile:
      return false;
    case ConnectivityResult.none:
      return false;
    case ConnectivityResult.vpn:
      return false;
    case ConnectivityResult.other:
      return false;
  }
}

@riverpod
Future<StartupStateStatus> initAppServices(InitAppServicesRef ref) async {
  var value = StartupStateStatus.goodConnection;
  final connectivityResult = await (Connectivity().checkConnectivity());
  if (_connectivityStatus(connectivityResult)) {
    value = StartupStateStatus.brokenConnection;
  }

  String localeName = Platform.localeName;
  if (filteredLocale.contains(localeName)) value = StartupStateStatus.brokenConnection;

  final info = NetworkInfo();
  final position = await _determinePosition();
  if (position != null) {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    String? country = placemarks.first.isoCountryCode?.toLowerCase();
    if (filteredCountryCode.contains(country)) value = StartupStateStatus.brokenConnection;
  }
  final wifiIP = await info.getWifiIP();
  if (filteredIpList.contains(wifiIP)) value = StartupStateStatus.brokenConnection;

  return value;
}

Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      await Geolocator.openAppSettings();
    }
  }

  if (permission == LocationPermission.deniedForever) {
    await Geolocator.openAppSettings();
  }

  return await Geolocator.getCurrentPosition();
}
