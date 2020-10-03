import 'package:bus_guide/index.dart';

class FirebaseLoginController extends GetxController {
  Future<bool> connect() async {
    LoginScreenController inputCtrlr = Get.find<LoginScreenController>();
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      UserCredential res;
      if (AppConfig.instance?.autoLogin != null) {
        res = await auth.signInWithEmailAndPassword(
          email: AppConfig.instance?.autoLogin['login'],
          password: AppConfig.instance?.autoLogin['password'],
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
      _displayLoginError(e);
      return false;
    }
  }

  _displayLoginError(Exception e) {
    Get.defaultDialog(
      title: 'Connection error',
      middleText: 'Error code: ${e.toString()}',
      textConfirm: 'OK',
      onConfirm: navigator.pop,
    );
  }
}
