import 'package:bus_guide/index.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginScreenController>(() => LoginScreenController());
    Get.lazyPut<FirebaseLoginController>(
      () => FirebaseLoginController(auth: FirebaseAuth.instance),
    );
    Get.lazyPut<UserController>(() => UserController());
  }
}
