import 'package:bus_guide/index.dart';

class PlanningController extends GetxController {
  final RxList<Planning> planningList = RxList<Planning>();
  final Rx<Planning> currentTask = Rx<Planning>();

  fetchPlanningfor(DateTime date) async {
    Map<String, dynamic> data = await CloudFunctionTools.callFunction(
        'getPlanning',
        data: {'date': '2020-08-20'});
    List<Planning> plannings = _getPlanningsFromJSON(data);
    planningList.value = plannings;
  }

  List<Planning> _getPlanningsFromJSON(Map<String, dynamic> data) {
    List<Planning> plannings = <Planning>[];
    List<dynamic> planningObjs = data['planning'];
    for (Map<String, dynamic> planObj in planningObjs) {
      Planning planning = Planning(planObj);
      plannings.add(planning);
    }
    return plannings;
  }
}
