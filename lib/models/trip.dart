import 'package:bus_guide/index.dart';

class Trip extends FetchedFBModel {
  String name;
  List<Stop> stops;
  Trip(Map<String, dynamic> data) {
    try {
      name = data['name'] as String;
      stops = (data['stops'] as List)
          .map((e) => Stop(e as Map<String, dynamic>))
          .toList(growable: false);
      hasError = false;
    } catch (e) {
      errorMessage = e.toString();
      hasError = true;
      rethrow;
    }
  }
}
