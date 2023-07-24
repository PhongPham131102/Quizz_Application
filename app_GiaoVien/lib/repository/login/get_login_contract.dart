import 'package:http/http.dart' as http;

abstract class LoginsRepository {
  Future<http.Response> login(String userName, String password);
}
