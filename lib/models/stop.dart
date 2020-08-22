import 'package:bus_guide/index.dart';

class Stop extends FetchedFBModel {
  String name;
  GeoPoint position;
  Stop(Map<String, dynamic> data) {
    print('new stop $data');
    try {
      position = data['position'];
      name = data['name'];
      hasError = false;
    } catch (e) {
      errorMessage = e.toString();
      hasError = true;
      rethrow;
    }
  }
}
