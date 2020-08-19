import 'package:bus_guide/index.dart';

class UserController extends GetxController {
  final Rx<User> fbUser = new Rx<User>();

  setFBUser(User user) {
    fbUser.value = user;
  }
}
