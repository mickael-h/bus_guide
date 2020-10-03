import 'package:bus_guide/index.dart';

class FirebaseLoginController extends GetxController {
  Future<bool> connect() async {
    final inputCtrlr = Get.find<LoginScreenController>();
    try {
      final auth = FirebaseAuth.instance;
      UserCredential res;
      if (AppConfig.instance?.autoLogin != null) {
        res = await auth.signInWithEmailAndPassword(
          email: AppConfig.instance?.autoLogin['login'] as String,
          password: AppConfig.instance?.autoLogin['password'] as String,
        );
      } else {
        res = await auth.signInWithEmailAndPassword(
          email: inputCtrlr.login.value,
          password: inputCtrlr.password.value,
        );
      }
      Get.find<UserController>().fbUser.value = res?.user;
      return true;
    } catch (e) {
      _displayLoginError(e as Exception);
      return false;
    }
  }

  void _displayLoginError(Exception e) {
    Get.defaultDialog(
      title: 'Connection error',
      middleText: 'Error code: ${e.toString()}',
      textConfirm: 'OK',
      onConfirm: navigator.pop,
    );
  }
}
