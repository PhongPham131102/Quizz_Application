import 'dart:convert';
import 'package:http/http.dart' as http;

import '../constants.dart';

Future<bool> checkToken(String token) async{
      var response = await http.get(Uri.parse('$baseUrl/users/checkToken'), headers: {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json'
    });
    if (response.statusCode == 200)
      return true;
    else
      return false;
}