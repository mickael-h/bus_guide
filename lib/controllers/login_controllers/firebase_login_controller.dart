import 'package:bus_guide/index.dart';

class FirebaseLoginController extends GetxController {
  final FirebaseAuth auth;

  FirebaseLoginController({this.auth});

  Future<User> connect(String login, String password) async {
    try {
      UserCredential res;
      if (AppConfig.instance?.autoLogin != null) {
        res = await auth.signInWithEmailAndPassword(
          email: AppConfig.instance?.autoLogin['login'] as String,
          password: AppConfig.instance?.autoLogin['password'] as String,
        );
      } else {
        res = await auth.signInWithEmailAndPassword(
          email: login,
          password: password,
        );
      }
      return res?.user;
    } catch (e) {
      _displayLoginError(e as Exception);
      return null;
    }
  }

  void _displayLoginError(Exception e) {
    try {
      Get.defaultDialog(
        title: 'Connection error',
        middleText: 'Error code: ${e.toString()}',
        textConfirm: 'OK',
        onConfirm: navigator.pop,
      );
    } catch (e) {
      print('Dialog error: $e');
    }
  }
}
