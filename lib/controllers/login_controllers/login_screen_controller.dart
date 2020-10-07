import 'package:bus_guide/index.dart';

class LoginScreenController extends GetxController {
  void onConnectButtonPressed() async {
    final user = await Get.find<FirebaseLoginController>().connect(
      login.value,
      password.value,
    );
    if (user != null) {
      unawaited(
          Get.to(PlanningScreen(), binding: PlanningBindings(user: user)));
    } else {
      unawaited(Get.defaultDialog(
        title: 'Connection error',
        textConfirm: 'OK',
        onConfirm: navigator.pop,
      ));
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
