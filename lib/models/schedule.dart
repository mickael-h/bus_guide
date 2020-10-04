import 'package:bus_guide/index.dart';

class Schedule extends FetchedFBModel {
  bool isReversed;
  List<Timestamp> times;
  Trip trip;
  String name;
  Schedule(Map<String, dynamic> data) {
    try {
      isReversed = data['is_reversed'] as bool;
      name = data['name'] as String;
      times = (data['times'] as List)
          .map((e) => Timestamp(e['_seconds'] as int, e['_nanoseconds'] as int))
          .toList(growable: false);
      trip = Trip(data['trip'] as Map<String, dynamic>);
      hasError = false;
    } catch (e) {
      errorMessage = e.toString();
      hasError = true;
      rethrow;
    }
  }
}
