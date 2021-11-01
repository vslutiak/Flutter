import 'package:kilo/models/seller.dart';
import 'package:kilo/models/tag.dart';

class Prod {
  Prod(
      {required this.id,
      required this.image,
      required this.description,
      required this.name,
      required this.price,
      required this.tag,
      required this.type,
      required this.date,
      required this.shortDescr,
      required this.packing,
      required this.adress,
      required this.seller});

  final String id;
  final String date;
  final String adress;
  final List<dynamic> type;
  final List<Tag> tag;
  final List<String> image;
  final String description;
  final String name;
  final String shortDescr;
  final num price;
  final double packing;
  final Seller seller;

  static Prod fromMap(Map<String, dynamic> map, List<dynamic> type,
      List<Tag> tag, Seller seller, List<String> img, String adres) {
    String creat = map[ProductKeys.date].toString().split('T').first;

    return Prod(
        adress: adres,
        id: map[ProductKeys.id],
        date: creat,
        image: img,
        description: map[ProductKeys.description],
        name: map[ProductKeys.name],
        price: map[ProductKeys.price],
        packing: map[ProductKeys.packing].runtimeType == int
            ? (map[ProductKeys.packing] as int).toDouble()
            : map[ProductKeys.packing],
        shortDescr: map[ProductKeys.shortDescription],
        tag: tag,
        type: type,
        seller: seller);
  }
}

class ProductKeys {
  static const String id = 'id';
  static const String date = 'created_at';
  static const String links = 'links';
  static const String description = 'description';
  static const String name = 'name';
  static const String price = 'price';
  static const String packing = 'packing';
  static const String shortDescription = 'short_description';
}
