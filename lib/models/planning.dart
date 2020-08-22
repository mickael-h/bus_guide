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
      date = data['date'];
      generalComment = data['general_comment'];
      lineName = data['line_name'];
      locatedComments = data['located_comments'];
      hasError = false;
    } catch (e) {
      errorMessage = e.toString();
      hasError = true;
    }
  }
}
