import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';

class UserService {
  Future<int> register(String fullName, String email, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/users/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'fullName': fullName,
          'email': email,
          'password': password,
        }));
    return response.statusCode;
  }

  Future<http.Response> login(String userName, String password) async {
    var response = await http.post(Uri.parse('$baseUrl/users/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'email': userName, 'password': password}));
    return response;
  }
}
