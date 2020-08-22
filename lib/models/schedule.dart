import 'package:bus_guide/index.dart';

class Schedule extends FetchedFBModel {
  bool isReversed;
  List<dynamic> times;
  Trip trip;
  String name;
  Schedule(Map<String, dynamic> data) {
    print('new schedule $data');
    try {
      isReversed = data['is_reversed'];
      name = data['name'];
      times = data['times'];
      hasError = false;
    } catch (e) {
      errorMessage = e.toString();
      hasError = true;
      rethrow;
    }
  }
}
