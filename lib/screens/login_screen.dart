import 'package:bus_guide/index.dart';

class LoginScreen extends GetView<LoginScreenController> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error');
        }
        if (snapshot.connectionState == ConnectionState.done) {
          CloudFunctions(app: Firebase.app(), region: 'europe-west1');
          return _getScreen(context);
        }
        return Text('Loading');
      },
    );
  }

  Scaffold _getScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Login'),
      ),
      body: _getLoginLayout(),
    );
  }

  Widget _getLoginLayout() {
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

  Widget _getLoginInput() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Login',
        border: const OutlineInputBorder(),
      ),
      onChanged: (txt) => controller.setLogin(txt),
    );
  }

  Widget _getPasswordInput() {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        Obx(
          () => TextField(
            decoration: InputDecoration(
              hintText: 'Password',
              border: const OutlineInputBorder(),
            ),
            obscureText: controller.hidePassword.value,
            onChanged: (txt) => controller.setPassword(txt),
          ),
        ),
        Obx(
          () => FlatButton(
            onPressed: () => controller.togglePasswordVisibility(),
            child: Icon(controller.hidePassword.value
                ? Icons.visibility
                : Icons.visibility_off),
          ),
        ),
      ],
    );
  }

  Widget _getConnectButton() {
    return RaisedButton(
      child: Text('Connect'),
      onPressed: () {
        controller.onConnectButtonPressed();
      },
    );
  }
}
