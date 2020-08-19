import 'package:bus_guide/index.dart';

class FirebaseLoginController extends GetxController {
  Future<bool> connect() async {
    LoginInputController inputCtrlr = Get.find<LoginInputController>();
    try {
      AuthResult res = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: inputCtrlr.login.value, password: inputCtrlr.password.value);
      Get.find<UserController>().setFBUser(res?.user);
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
