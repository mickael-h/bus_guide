import 'package:bus_guide/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class FakeCredential extends Fake implements UserCredential {
  @override
  User get user {
    return MockUser();
  }
}

void main() {
  test('test connect', () {
    final firebaseAuth = MockFirebaseAuth();
    final firebaseController = FirebaseLoginController(auth: firebaseAuth);
    final userController = UserController();
    final loginController = LoginScreenController();

    Get.put<LoginScreenController>(loginController);
    Get.put<UserController>(userController);
    Get.put<FirebaseLoginController>(firebaseController);
    AppConfig.init('test', 'mockGoogleKey');

    loginController.login.value = 'testLogin';
    loginController.password.value = 'testWrongPassword';

    final cred = FakeCredential();
    when(firebaseAuth.signInWithEmailAndPassword(
      email: anyNamed('email'),
      password: anyNamed('password'),
    )).thenAnswer((_) => Future.sync(() => cred));
    print('passed!');
  });
}
