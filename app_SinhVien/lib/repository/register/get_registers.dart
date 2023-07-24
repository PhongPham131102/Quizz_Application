import 'dart:convert';

import '../../constants.dart';
import 'get_registers_contract.dart';
import 'package:http/http.dart' as http;

class GetRegistersRepository implements RegistersRepository
{
  @override
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
}