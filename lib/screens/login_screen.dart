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
        widthFactor: 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Login:'),
            TextField(
              onChanged: (txt) => Get.find<LoginController>().setLogin(txt),
            ),
            SizedBox(height: 20),
            Text('Password:'),
            _getPasswordInput(),
            SizedBox(height: 20),
            RaisedButton(
              child: Text('Login'),
              onPressed: Get.find<LoginController>().connect,
            )
          ],
        ),
      ),
    );
  }

  _getPasswordInput() {
    return Row(children: [
      Expanded(
        flex: 1,
        child: Obx(
          () => TextField(
            obscureText: Get.find<LoginController>().passwordVisible.value,
            onChanged: (txt) => Get.find<LoginController>().setPassword(txt),
          ),
        ),
      ),
      Obx(
        () => FlatButton(
          onPressed: () =>
              Get.find<LoginController>().togglePasswordVisibility(),
          child: Icon(Get.find<LoginController>().passwordVisible.value
              ? Icons.visibility
              : Icons.visibility_off),
        ),
      ),
    ]);
  }
}
