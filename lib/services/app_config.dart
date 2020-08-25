import 'package:bus_guide/index.dart';

class AppConfig {
  static AppConfig instance;
  final Map<String, dynamic> autoLogin;
  final String googleAPIKey;

  AppConfig({this.autoLogin, this.googleAPIKey});

  static init(String env, String googleAPIKey) async {
    env = env ?? 'prod';
    final contents = await rootBundle.loadString('assets/config/$env.json');
    final json = jsonDecode(contents);
    instance = AppConfig(
      autoLogin: json['autoLogin'],
      googleAPIKey: googleAPIKey,
    );
  }
}
