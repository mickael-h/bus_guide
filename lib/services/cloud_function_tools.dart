import 'package:http/http.dart' as http;
import 'package:bus_guide/index.dart';

class CloudFunctionTools {
  static Future<Map<String, dynamic>> callFunction(String functionName,
      {Map<String, dynamic> data}) async {
    final url =
        'https://europe-west1-gestion-trajets.cloudfunctions.net/$functionName';
    try {
      String dataStr;
      if (data != null) {
        dataStr = jsonEncode(data);
      } else {
        dataStr = '{}';
      }
      final headers = <String, String>{
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer ${await FirebaseAuth.instance?.currentUser?.getIdToken()}',
      };
      final response = await http.post(
        url,
        headers: headers,
        body: '{"data":$dataStr}',
      );
      return jsonDecode(response?.body)['result'] as Map<String, dynamic>;
    } catch (e) {
      print('error retrieving data: $e');
      return <String, dynamic>{};
    }
  }
}
