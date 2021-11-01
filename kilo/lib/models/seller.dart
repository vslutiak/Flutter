import 'package:kilo/models/periods.dart';

class Seller {
  final String name;
  final String id;
  final String avatar;

  final double rating;
  final Map<String, dynamic> location;
  final List<String> delivery;
  final List<Period> period;

  Seller(
      {required this.avatar,
      required this.rating,
      required this.location,
      required this.delivery,
      required this.period,
      required this.name,
      required this.id});

  static Seller fromMap(
      Map<String, dynamic> map,
      List<Period> period,
      List<String> delivery,
      Map<String, dynamic> location,
      double rating,
      String avatar) {
    return Seller(
        name: map['seller']['name'],
        id: map['seller_id'],
        delivery: delivery,
        location: location,
        rating: rating,
        // tag: tag,
        // type: type,
        period: period,
        avatar: avatar);
  }

  // @override
  // String toString() {
  //   return '{ ${this.name}, ${this.id} }';
  // }
}
