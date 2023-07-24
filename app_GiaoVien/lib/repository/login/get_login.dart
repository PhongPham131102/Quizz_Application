import 'dart:convert';

import '../../constants.dart';
import 'get_login_contract.dart';
import 'package:http/http.dart' as http;

class GetLoginsRepository implements LoginsRepository {
  Future<http.Response> login(String userName, String password) async {
    var response = await http.post(Uri.parse('$baseUrl/users/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': userName, 'password': password}));
    return response;
  }

}
