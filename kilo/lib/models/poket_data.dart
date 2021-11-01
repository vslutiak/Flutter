import 'package:kilo/models/prod.dart';

class MyData {
  MyData({required this.count, required this.prod});
  final List<num> count;
  final List<Prod> prod;

  void pocClear() {
    count.clear();
    prod.clear();
    myPoket = MyData(count: [], prod: []);
  }

  void removeIndex(int index) {
    myPoket.count.removeAt(index);
    myPoket.prod.removeAt(index);
  }
}

MyData myPoket = MyData(count: [], prod: []);
