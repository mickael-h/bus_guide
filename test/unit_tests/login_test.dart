import 'package:bus_guide/index.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class FakeCredential extends Fake implements UserCredential {
  final _user = MockUser();
  @override
  User get user {
    return _user;
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('test connect', () async {
    final firebaseAuth = MockFirebaseAuth();

    final firebaseController = FirebaseLoginController(auth: firebaseAuth);
    Get.put<FirebaseLoginController>(firebaseController);

    final userController = UserController();
    Get.put<UserController>(userController);

    final loginController = LoginScreenController();
    Get.put<LoginScreenController>(loginController);

    AppConfig.init('test', 'mockGoogleKey');

    final cred = FakeCredential();
    when(firebaseAuth.signInWithEmailAndPassword(
      email: 'testLogin',
      password: 'testRightPassword',
    )).thenAnswer((_) => Future.sync(() => cred));

    when(firebaseAuth.signInWithEmailAndPassword(
      email: 'testLogin',
      password: 'testWrongPassword',
    )).thenThrow(Exception());

    when(cred.user.uid).thenReturn('testUid');

    loginController.setLogin('testLogin');
    loginController.setPassword('testWrongPassword');
    expect(
      await firebaseController.connect(
        loginController.login.value,
        loginController.password.value,
      ),
      null,
    );
    expect(userController.fbUser.value, null);

    loginController.setLogin('testLogin');
    loginController.setPassword('testRightPassword');
    expect(
      await firebaseController.connect(
        loginController.login.value,
        loginController.password.value,
      ),
      cred.user,
    );
    print('passed!');
  });
}
