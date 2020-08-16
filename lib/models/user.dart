import '../index.dart';

class User {
  User(
      {@required this.id,
      this.name = '',
      this.email = '',
      this.favoriteLine = 0});
  String id;
  String name;
  String email;
  int favoriteLine;
}
