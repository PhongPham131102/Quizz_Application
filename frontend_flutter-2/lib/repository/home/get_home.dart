import 'dart:convert';

import 'package:frontend_flutter/repository/home/get_home_contract.dart';

import '../../constants.dart';
import '../../models/Profile.dart';
import 'package:http/http.dart' as http;

class GetHomeRepository implements HomeRepository {
  Future<Profile> getProfile() async {
    var response = await http.get(
      Uri.parse('$baseUrl/profiles/getprofile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    var data = jsonDecode(response.body);
    var profile = Profile.fromJson(data['profile']);
    return profile;
  }
}
