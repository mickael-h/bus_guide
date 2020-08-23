import 'package:bus_guide/index.dart';

class Schedule extends FetchedFBModel {
  bool isReversed;
  List<Timestamp> times;
  Trip trip;
  String name;
  Schedule(Map<String, dynamic> data) {
    print('new schedule $data');
    try {
      isReversed = data['is_reversed'];
      name = data['name'];
      times = (data['times'] as List)
          .map((e) => Timestamp(e['_seconds'], e['_nanoseconds']))
          .toList(growable: false);
      trip = Trip(data['trip']);
      hasError = false;
    } catch (e) {
      errorMessage = e.toString();
      hasError = true;
      rethrow;
    }
  }
}
