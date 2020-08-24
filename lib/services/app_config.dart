import 'package:bus_guide/index.dart';

class AppConfig {
  static AppConfig instance;
  final Map<String, dynamic> autoLogin;

  AppConfig({this.autoLogin});

  static init(String env) async {
    env = env ?? 'prod';
    final contents = await rootBundle.loadString('assets/config/$env.json');
    final json = jsonDecode(contents);
    instance = AppConfig(autoLogin: json['autoLogin']);
  }
}
