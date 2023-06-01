import 'dart:convert';

import '../../constants.dart';
import '../../models/Profile.dart';
import 'get_logins_contract.dart';
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

  Future<Profile> getProfile(String tokenn) async {
    var response = await http.get(
      Uri.parse('$baseUrl/profiles/getprofile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $tokenn',
      },
    );
    var data = jsonDecode(response.body);
    var profile = Profile.fromJson(data['profile']);
    return profile;
  }
}
