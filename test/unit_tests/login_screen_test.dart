import 'package:bus_guide/index.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('changing values', () {
    final screenController = LoginScreenController();
    expect(screenController.login.value, '');
    expect(screenController.password.value, '');
    expect(screenController.hidePassword.value, true);

    screenController.setLogin('testLogin');
    screenController.setPassword('testPassword');
    screenController.togglePasswordVisibility();

    expect(screenController.login.value, 'testLogin');
    expect(screenController.password.value, 'testPassword');
    expect(screenController.hidePassword.value, false);

    screenController.togglePasswordVisibility();
    expect(screenController.hidePassword.value, true);
    print('passed!');
  });
}
