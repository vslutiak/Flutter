import 'package:kilo/models/product.dart';
import 'package:kilo/models/reviews.dart';

class SellerInf {
  final String name;

  final String avatar;
  final String id;

  final dynamic rating;
  final num count;

  final List<Reviews> revs;
  final List<Product> product;
  final List<String> subsc;

  SellerInf({
    required this.count,
    required this.subsc,
    required this.avatar,
    required this.id,
    required this.rating,
    required this.revs,
    required this.product,
    required this.name,
  });

  static SellerInf fromMap(
      Map<String, dynamic> map,
      List<Product> product,
      List<Reviews> revs,
      dynamic rating,
      String avatar,
      List<String> subsc,
      num count) {
    return SellerInf(
        id: map['id'] ?? ' ',
        name: map['name'] ?? ' ',
        rating: rating ?? 0,
        product: product,
        avatar: avatar,
        revs: revs,
        subsc: subsc,
        count: count);
  }

  // @override
  // String toString() {
  //   return '{ ${this.name}, ${this.id} }';
  // }
}
