import 'package:http/http.dart' as http;
import 'package:bus_guide/index.dart';

class PlanningController extends GetxController {
  final RxList<Planning> planningList = <Planning>[].obs;

  fetchPlanningfor(DateTime date) async {
    // CloudFunctions(app: Firebase.app(), region: 'europe-west1');
    // final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
    //   functionName: 'callableTest',
    // );
    // final HttpsCallableResult result = await callable.call(<String, dynamic>{
    //   'uid': 'zzYMZ3JRzgSmJFFiyTqfoXdNIbY2',
    //   'date': '2020-08-20',
    // });
    // print('received value: ${result.data}');
    // return;

    final String url =
        'https://europe-west1-gestion-trajets.cloudfunctions.net/getPlanning?uid=zzYMZ3JRzgSmJFFiyTqfoXdNIbY2&date=2020-08-20';
    Map<String, dynamic> data;
    try {
      http.Response response = await http.get(url);
      data = jsonDecode(response.body);
      print('data received: $data');
    } catch (e) {
      print('error receving data: $e');
      return;
    }

    List<dynamic> planningObjs = data['planning'];
    List<Planning> plannings = <Planning>[];
    for (Map<String, dynamic> planObj in planningObjs) {
      Planning planning = Planning(planObj);
      plannings.add(planning);
    }

    planningList.value = plannings;

    // String dateStr = date.toIso8601String().substring(0, 10);
    // User user = Get.find<UserController>().fbUser.value;
    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    // Stream<List<Planning>> planning = firestore
    //     .collection('plannings')
    //     .doc(user.uid)
    //     .collection('2020-08-20')
    //     .snapshots()
    //     .map((QuerySnapshot query) {
    //   List<Planning> dataList = List();
    //   query.docs.forEach((element) {
    //     dataList.add(_createPlanning(element.data()));
    //   });
    //   return dataList;
    // });
    // planningList.bindStream(planning);
  }
}
