class User {
  User(
      {required this.id,
      required this.verified,
      required this.email,
      required this.image,
      required this.name,
      required this.phone});
  final String id;
  final String image;
  final String phone;
  final String name;
  final String email;
  final bool verified;

  static User fromMap(Map<String, dynamic> map, String img) {
    return User(
        phone: map['phone'] ?? ' ',
        image: img,
        name: map['name'] ?? ' ',
        email: map['email'],
        id: map['id'],
        verified: map['verified']);
  }
}
