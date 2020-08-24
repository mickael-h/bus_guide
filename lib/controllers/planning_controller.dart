import 'package:bus_guide/index.dart';

class PlanningController extends GetxController {
  final RxList<Planning> planningList = RxList<Planning>();
  final Rx<Planning> currentPlanning = Rx<Planning>();

  fetchPlanningfor(DateTime date) async {
    // Should work, but doesn't.
    // See: https://github.com/FirebaseExtended/flutterfire/issues/3290
    // final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
    //   functionName: 'getPlanning',
    // );
    // final HttpsCallableResult result = await callable.call(<String, dynamic>{
    //   'date': '2020-08-20',
    // });
    // print('received value: ${result.data}');

    Map<String, dynamic> data = await CloudFunctionTools.callFunction(
        'getPlanning',
        data: {'date': '2020-08-20'});
    List<Planning> plannings = _getPlanningsFromJSON(data);
    planningList.value = plannings;
  }

  List<Planning> _getPlanningsFromJSON(Map<String, dynamic> data) {
    List<Planning> plannings = <Planning>[];
    List<dynamic> planningObjs = data['plannings'];
    for (Map<String, dynamic> planObj in planningObjs) {
      Planning planning = Planning(planObj);
      plannings.add(planning);
    }
    return plannings;
  }

  pickPlanning(Planning data) async {
    currentPlanning.value = data;
    Get.to(
      MapScreen(),
      binding: MapScreenBindings(),
    );
  }
}
