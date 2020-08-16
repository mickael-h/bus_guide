import 'package:bus_guide/index.dart';

class UserController extends GetxController {
  final user = User().obs;

  updateId(String id) {
    user.update((value) => value.id = id);
  }

  updateName(String name) {
    user.update((value) => value.name = name);
  }

  updateEmail(String email) {
    user.update((value) => value.email = email);
  }

  updateFavoriteLine(int line) {
    user.update((value) => value.favoriteLine = line);
  }
}
