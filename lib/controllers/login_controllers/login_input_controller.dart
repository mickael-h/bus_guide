import 'package:bus_guide/index.dart';

class LoginInputController extends GetxController {
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
