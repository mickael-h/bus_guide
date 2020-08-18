import 'package:bus_guide/index.dart';

class LoginController extends GetxController {
  final RxString login = ''.obs;
  final RxString password = ''.obs;
  final RxBool passwordVisible = false.obs;

  togglePasswordVisibility() {
    passwordVisible.value = !passwordVisible.value;
  }

  setLogin(String newLogin) {
    login.value = newLogin;
  }

  setPassword(String newPassword) {
    password.value = newPassword;
  }

  //TODO: save token
  connect() async {
    try {
      AuthResult res = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: login.value, password: password.value);
      FirebaseUser user = res?.user;
      Get.find<UserController>().setFBUser(user);
      Get.defaultDialog(
        title: 'Connection success',
        middleText: 'User data: ${user?.email}',
        textConfirm: 'OK',
        onConfirm: navigator.pop,
      );
    } catch (e) {
      Get.defaultDialog(
        title: 'Connection error',
        middleText: 'Error code: ${e?.code}',
        textConfirm: 'OK',
        onConfirm: navigator.pop,
      );
    }
  }
}
