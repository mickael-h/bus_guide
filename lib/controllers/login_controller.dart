import 'package:bus_guide/index.dart';

class LoginController extends GetxController {
  final RxString login = ''.obs;
  final RxString password = ''.obs;
  final RxBool passwordVisible = false.obs;
  final Rx<FirebaseUser> user = new Rx<FirebaseUser>();
  final RxString firebaseAuthError = ''.obs;

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
      user.value = res?.user;
      Get.defaultDialog(
        title: 'Connection success',
        middleText: 'User data: ${user.value.email}',
        textConfirm: 'OK',
        onConfirm: navigator.pop,
      );
    } catch (e) {
      firebaseAuthError.value = e?.code;
      Get.defaultDialog(
        title: 'Connection error',
        middleText: 'Error code: ${e?.code}',
        textConfirm: 'OK',
        onConfirm: navigator.pop,
      );
    }
  }
}
