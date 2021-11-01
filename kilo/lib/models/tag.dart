class Tag {
  final String name;
  final String id;

  Tag({required this.name, required this.id});

  static Tag fromMap(Map<String, dynamic> map) {
    // print(map['id']);
    return Tag(name: map['name'], id: map['id']);
  }

  @override
  String toString() {
    return '{ ${this.name}, ${this.id} }';
  }
}
