class Reviews {
  Reviews({
    required this.anonymous,
    required this.avatar,
    required this.name,
    required this.createdAt,
    required this.comment,
    required this.links,
    required this.rating,
  });

  final bool anonymous;
  final String avatar;
  final String name;
  final String createdAt;
  final String comment;
  final List<String> links;
  final num rating;

  static Reviews fromMap(Map<String, dynamic> map, List<String> links,
      String name, String avatar) {
    List<String> createdAt =
        map[Keys.createdAt].toString().split('T').first.split('-');
    String date = '${createdAt[2]}.${createdAt[1]}';
    return Reviews(
        anonymous: map[Keys.anonymous],
        avatar: avatar,
        name: name,
        createdAt: date,
        comment: map[Keys.comment],
        links: links,
        rating: map[Keys.rating]);
  }
}

class Keys {
  static const String anonymous = 'anonymous';
  static const String createdAt = 'created_at';
  static const String rating = 'rating';
  static const String comment = 'comment';
}
