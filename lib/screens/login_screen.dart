import 'package:bus_guide/index.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Login'),
      ),
      body: _getLoginLayout(),
    );
  }

  _getLoginLayout() {
    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.75,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _getLoginInput(),
            SizedBox(height: 20),
            _getPasswordInput(),
            SizedBox(height: 20),
            _getConnectButton(),
          ],
        ),
      ),
    );
  }

  _getLoginInput() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Login',
        border: const OutlineInputBorder(),
      ),
      onChanged: (txt) => Get.find<LoginInputController>().setLogin(txt),
    );
  }

  _getPasswordInput() {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Obx(
          () => TextField(
            decoration: InputDecoration(
              hintText: 'Password',
              border: const OutlineInputBorder(),
            ),
            obscureText: Get.find<LoginInputController>().hidePassword.value,
            onChanged: (txt) =>
                Get.find<LoginInputController>().setPassword(txt),
          ),
        ),
        Obx(
          () => FlatButton(
            onPressed: () =>
                Get.find<LoginInputController>().togglePasswordVisibility(),
            child: Icon(Get.find<LoginInputController>().hidePassword.value
                ? Icons.visibility
                : Icons.visibility_off),
          ),
        ),
      ],
    );
  }

  _getConnectButton() {
    return RaisedButton(
      child: Text('Connect'),
      onPressed: Get.find<LoginScreenController>().onConnectButtonPressed,
    );
  }
}
