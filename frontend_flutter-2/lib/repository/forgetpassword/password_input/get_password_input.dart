import 'dart:convert';

import 'package:frontend_flutter/repository/forgetpassword/password_input/get_password_input_contract.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class GetPasswordInputRepository implements PassWordInputRepository {
  Future<bool> updatePassWord(String email, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/users/updatePassWord'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
        }));
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
