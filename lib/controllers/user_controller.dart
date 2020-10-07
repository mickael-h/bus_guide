import 'package:bus_guide/index.dart';

class UserController extends GetxController {
  final User user;
  UserController({this.user}) : super() {
    fbUser.value = user;
  }

  final Rx<User> fbUser = Rx<User>();
}
