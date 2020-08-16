import 'package:bus_guide/index.dart';

class UserController extends GetxController {
  final user = User().obs;

  updateId(String id) {
    user.update((value) => value.id = id);
  }

  updateName(String name) {
    user.update((value) => value.name = name);
  }

  updatePosition(LatLng pos) {
    user.update((value) => value.position = pos);
  }
}
