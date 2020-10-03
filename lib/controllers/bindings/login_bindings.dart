import 'package:bus_guide/index.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginScreenController>(() => LoginScreenController());
    Get.lazyPut<FirebaseLoginController>(() => FirebaseLoginController());
    Get.lazyPut<UserController>(() => UserController());
  }
}
