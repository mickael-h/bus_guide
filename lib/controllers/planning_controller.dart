import 'package:bus_guide/index.dart';

class PlanningController extends GetxController {
  final RxList<Map<String, dynamic>> planningList =
      <Map<String, dynamic>>[].obs;

  fetchPlanning() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    User user = Get.find<UserController>().fbUser.value;
    CollectionReference planning =
        firestore.collection('plannings/${user.uid}/2020-08-19');
    QuerySnapshot querySnap = await planning.get();
    List<DocumentSnapshot> docSnaps = querySnap?.docs;
    planningList.value =
        docSnaps?.map((DocumentSnapshot docSnap) => docSnap.data());
  }
}
