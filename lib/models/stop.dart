import 'package:bus_guide/index.dart';

class Stop extends FetchedFBModel {
  String name;
  LatLng position;
  bool done;
  Stop(Map<String, dynamic> data) {
    print('new stop $data');
    try {
      done = false;
      position = LatLng(data['position']['_latitude'] as double,
          data['position']['_longitude'] as double);
      name = data['name'] as String;
      hasError = false;
    } catch (e) {
      errorMessage = e.toString();
      hasError = true;
      rethrow;
    }
  }
}
