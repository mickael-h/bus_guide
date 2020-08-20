import 'package:bus_guide/index.dart';

class FirebaseLoginController extends GetxController {
  Future<bool> connect() async {
    LoginInputController inputCtrlr = Get.find<LoginInputController>();
    try {
      UserCredential res = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: 'mickael.hassine@gmail.com', password: '123456');
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
