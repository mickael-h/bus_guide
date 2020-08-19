import 'package:bus_guide/index.dart';

class LoginScreenController extends GetxController {
  onConnectButtonPressed() async {
    bool isConnected = await Get.find<FirebaseLoginController>().connect();
    if (isConnected) {
      Get.to(PlanningScreen(), binding: PlanningBinding());
    }
  }
}
