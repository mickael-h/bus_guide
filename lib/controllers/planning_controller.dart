import 'package:bus_guide/index.dart';

class PlanningController extends GetxController {
  final RxList<Planning> planningList = <Planning>[].obs;

  fetchPlanningfor(DateTime date) {
    String dateStr = date.toIso8601String().substring(0, 10);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User user = Get.find<UserController>().fbUser.value;
    Stream<List<Planning>> planning = firestore
        .collection('plannings')
        .doc(user.uid)
        .collection('2020-08-20')
        .snapshots()
        .map((QuerySnapshot query) {
      List<Planning> dataList = List();
      query.docs.forEach((element) async {
        dataList.add(await _createPlanning(element.data()));
      });
      return dataList;
    });
    planningList.bindStream(planning);
  }

  Future<Planning> _createPlanning(Map<String, dynamic> data) async {
    Planning planning = Planning(data);
    if (_checkIntegrity(planning)) {
      try {
        DocumentReference scheduleRef = data['schedule_ref'];
        Map<String, dynamic> scheduleData = (await scheduleRef.get()).data();
        planning.schedule = Schedule(scheduleData);

        DocumentReference tripRef = scheduleData['trip_ref'];
        Map<String, dynamic> tripData = (await tripRef.get()).data();
        planning.schedule.trip = Trip(tripData);

        List<dynamic> stopRefs = tripData['stops'];
        List<Stop> stops = List();
        for (DocumentReference stopRef in stopRefs) {
          Map<String, dynamic> stopData = (await stopRef.get()).data();
          stops.add(Stop(stopData));
        }
        planning.schedule.trip.stops = stops;
      } catch (e) {
        planning.errorMessage = e.toString();
        planning.hasError = true;
      }
    }

    if (planning.hasError) {
      print('Error ${planning.errorMessage}');
    }

    return planning;
  }

  bool _checkIntegrity(Planning planning) {
    try {
      for (Map<String, dynamic> comment in planning.locatedComments) {
        if (comment['position'] is! GeoPoint || comment['text'] is! String) {
          throw Exception('Comment type error: $comment');
        }
      }
      return true;
    } catch (e) {
      planning.hasError = true;
      planning.errorMessage = e.toString();
      return false;
    }
  }
}
