import 'package:bus_guide/index.dart';

class Planning extends FetchedFBModel {
  Schedule schedule;
  Timestamp date;
  String lineName;
  String generalComment;
  List<dynamic> locatedComments;
  Planning(Map<String, dynamic> data) {
    try {
      date = Timestamp(
          data['date']['_seconds'] as int, data['date']['_nanoseconds'] as int);
      generalComment = data['general_comment'] as String;
      lineName = data['line_name'] as String;
      locatedComments = (data['located_comments'] as List)
          .map((e) => {
                'text': e['text'],
                'position': LatLng(e['position']['_latitude'] as double,
                    e['position']['_longitude'] as double),
              })
          .toList(growable: false);
      schedule = Schedule(data['schedule'] as Map<String, dynamic>);
      hasError = false;
    } catch (e) {
      errorMessage = e.toString();
      hasError = true;
    }
  }
}
