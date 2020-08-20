import 'package:bus_guide/index.dart';

class PlanningController extends GetxController {
  final RxList<Map<String, dynamic>> planningList =
      <Map<String, dynamic>>[].obs;

  fetchPlanningfor(DateTime date) {
    String dateStr = date.toIso8601String().substring(0, 10);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User user = Get.find<UserController>().fbUser.value;
    Stream<List<Map<String, dynamic>>> planning = firestore
        .collection('plannings')
        .doc(user.uid)
        .collection(dateStr)
        .snapshots()
        .map((QuerySnapshot query) {
      List<Map<String, dynamic>> dataList = List();
      query.docs.forEach((element) {
        dataList.add(element.data());
      });
      return dataList;
    });
    planningList.bindStream(planning);
  }
}
