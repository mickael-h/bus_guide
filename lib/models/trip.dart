import 'package:bus_guide/index.dart';

class Trip extends FetchedFBModel {
  String name;
  List<Stop> stops;
  Trip(Map<String, dynamic> data) {
    print('new trip $data');
    try {
      name = data['name'];
      stops =
          (data['stops'] as List).map((e) => Stop(e)).toList(growable: false);
      hasError = false;
    } catch (e) {
      errorMessage = e.toString();
      hasError = true;
      rethrow;
    }
  }
}
