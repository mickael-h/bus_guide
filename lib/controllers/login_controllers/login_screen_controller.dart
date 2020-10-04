import 'package:bus_guide/index.dart';

class LoginScreenController extends GetxController {
  void onConnectButtonPressed() async {
    final isConnected = await Get.find<FirebaseLoginController>().connect();
    if (isConnected) {
      unawaited(Get.to(PlanningScreen(), binding: PlanningBindings()));
    }
  }

  final RxString login = ''.obs;
  final RxString password = ''.obs;
  final RxBool hidePassword = true.obs;

  void togglePasswordVisibility() {
    hidePassword.value = !hidePassword.value;
  }

  void setLogin(String newLogin) {
    login.value = newLogin;
  }

  void setPassword(String newPassword) {
    password.value = newPassword;
  }
}
