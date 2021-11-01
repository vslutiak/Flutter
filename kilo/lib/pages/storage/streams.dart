import 'dart:async';

import 'package:kilo/models/prod.dart';

import 'package:kilo/models/seller_profile.dart';
import 'package:kilo/models/user.dart';
import 'package:kilo/pages/storage/storage.dart';
import 'package:rxdart/rxdart.dart';

class Streams {
  static Streams _singleton = new Streams._internal();

  factory Streams() {
    // ignore: unnecessary_null_comparison
    if (_singleton == null) {
      _singleton = new Streams._internal();
    }
    return _singleton;
  }

  Streams._internal() {
    //user.pipe(_userSubject.sink);
  }

  final BehaviorSubject<User> _userSubject = BehaviorSubject();
  Stream<User> get user => _userSubject.stream;

  final PublishSubject<Prod> _productSubject = PublishSubject();
  Stream<Prod> get product => _productSubject.stream;

  final PublishSubject<SellerInf> _sellerSubject = PublishSubject();
  Stream<SellerInf> get seller => _sellerSubject.stream;

  void getSell(String uid) async {
    var sell = await Storages().getSellerInfo(uid);
    if (product.runtimeType == String) {
      sell = await Storages().getSellerInfo(uid);
    }
    _sellerSubject.add(sell as SellerInf);
  }

  void addProduct(String uid) async {
    var product = await Storages().getProduct(uid);
    if (product.runtimeType == String) {
      product = await Storages().getProduct(uid);
    }
    _productSubject.add(product as Prod);
  }

  void addMap() async {
    var user = await Storages().getMyData();
    if (user.runtimeType == String) {
      print('object');
      user = await Storages().getMyData();
    }

    _userSubject.add(user as User);
  }

  void disposeSubjects() {
    _sellerSubject.close();
    _productSubject.close();
    _userSubject.close();
  }
}
