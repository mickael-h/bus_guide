import 'package:bus_guide/index.dart';

class Planning extends FetchedFBModel {
  Schedule schedule;
  Timestamp date;
  String lineName;
  String generalComment;
  List<dynamic> locatedComments;
  Planning(Map<String, dynamic> data) {
    print('new planning $data');
    try {
      date = Timestamp(data['date']['_seconds'], data['date']['_nanoseconds']);
      generalComment = data['general_comment'];
      lineName = data['line_name'];
      locatedComments = (data['located_comments'] as List)
          .map((e) => {
                'text': e['text'],
                'position': LatLng(
                    e['position']['_latitude'], e['position']['_longitude']),
              })
          .toList(growable: false);
      schedule = Schedule(data['schedule']);
      hasError = false;
    } catch (e) {
      errorMessage = e.toString();
      hasError = true;
    }
  }
}
