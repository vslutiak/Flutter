import 'package:kilo/models/periods.dart';

class Settings {
  Settings({required this.id, required this.location, required this.periods, required this.type});
  final String id;
  final List<Period> periods;
  final List<String> type;
  final List<dynamic> location;

  static Settings fromMap(Map<String, dynamic> map, List<dynamic> location, List<Period> periods,List<String> type ){
    return Settings(id: map['id'], location: location, periods: periods, type: type);
  }
}