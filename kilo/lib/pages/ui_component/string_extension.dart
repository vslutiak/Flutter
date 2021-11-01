extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  bool get isValidEmail {
    // ignore: unnecessary_null_comparison
    return this == null
        ? false
        : RegExp(r'[A-Za-z0-9\.\+_-]+@[A-Za-z0-9\.-]+\.[a-zA-Z]{2,}$')
            .hasMatch(this);
  }
}
