class Product {
  Product({
    required this.id,
    required this.image,
    required this.description,
    required this.name,
    required this.price,
    required this.shortDescr,
    required this.packing,
  });

  final String id;

  final String image;
  final String description;
  final String name;
  final String shortDescr;
  final num price;
  final double packing;

  static Product fromMap(Map<String, dynamic> map, String img) {
    return Product(
      id: map[ProductKeys.id],
      image: img,
      description: map[ProductKeys.description] ?? ' ',
      name: map[ProductKeys.name],
      price: map[ProductKeys.price] as num,
      packing: map[ProductKeys.packing].runtimeType == int
          ? (map[ProductKeys.packing] as int).toDouble()
          : map[ProductKeys.packing] ?? 0,
      shortDescr: map[ProductKeys.shortDescription] ?? ' ',
    );
  }
}

class ProductKeys {
  static const String id = 'id';
  static const String links = 'links';
  static const String description = 'description';
  static const String name = 'name';
  static const String price = 'price';
  static const String packing = 'packing';
  static const String shortDescription = 'short_description';
}
