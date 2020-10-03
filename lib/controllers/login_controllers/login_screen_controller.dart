import 'package:bus_guide/index.dart';

class LoginScreenController extends GetxController {
  onConnectButtonPressed() async {
    bool isConnected = await Get.find<FirebaseLoginController>().connect();
    if (isConnected) {
      Get.to(PlanningScreen(), binding: PlanningBindings());
    }
  }

  final RxString login = ''.obs;
  final RxString password = ''.obs;
  final RxBool hidePassword = true.obs;

  togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  setLogin(String newLogin) {
    login.value = newLogin;
  }

  setPassword(String newPassword) {
    password.value = newPassword;
  }
}
