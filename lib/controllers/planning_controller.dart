import 'package:bus_guide/index.dart';

class PlanningController extends GetxController {
  final RxList<Planning> planningList = RxList<Planning>();
  final Rx<Planning> currentPlanning = Rx<Planning>();
  final CloudFunctionTools cloudFunctionTools;

  PlanningController({this.cloudFunctionTools});

  Future<void> fetchPlanningfor(DateTime date) async {
    // Should work, but doesn't.
    // See: https://github.com/FirebaseExtended/flutterfire/issues/3290
    // final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
    //   functionName: 'getPlanning',
    // );
    // final HttpsCallableResult result = await callable.call(<String, dynamic>{
    //   'date': '2020-08-20',
    // });
    // print('received value: ${result.data}');
    final formattedDate = formatDate(date, ['yyyy', '-', 'mm', '-', 'dd']);
    final data = await cloudFunctionTools
        .callFunction('getPlanning', data: {'date': formattedDate});
    if (data != null) {
      final plannings = _getPlanningsFromJSON(data);
      planningList.value = plannings;
    } else {
      planningList.value = [];
    }
  }

  List<Map<String, dynamic>> getTimedStops() {
    final planning = currentPlanning.value;
    final schedule = planning?.schedule;
    var stops = schedule?.trip?.stops;
    if (schedule?.isReversed ?? false) {
      stops = stops?.reversed as List<Stop>;
    }
    final timedStops = <Map<String, dynamic>>[];
    for (var i = 0; i < schedule?.times?.length; i++) {
      final date = schedule?.times[i].toDate();
      final stop = schedule?.trip?.stops[i];
      timedStops.add({'time': date, 'stop': stop});
    }
    return timedStops;
  }

  List<Planning> _getPlanningsFromJSON(Map<String, dynamic> data) {
    final plannings = <Planning>[];
    final planningObjs = data['plannings'] as List;
    for (var planObj in planningObjs) {
      if (planObj is Map<String, dynamic>) {
        final planning = Planning(planObj);
        if (!planning.hasError) {
          plannings.add(planning);
        } else {
          print('planning has error: ${planning.errorMessage}');
        }
      }
    }
    return plannings;
  }

  void pickPlanning(Planning data) async {
    currentPlanning.value = data;

    try {
      unawaited(Get.to(
        MapScreen(),
        binding: MapScreenBindings(),
      ));
    } catch (e) {
      print('Navigation error: $e');
    }
  }
}
