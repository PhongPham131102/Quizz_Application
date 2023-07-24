import 'package:frontend_flutter/repository/personal_information/get_personal_information_contract.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import '../../models/User.dart';
import 'dart:convert';

class GetPersonalInformationRepository
    implements PersonalInformationRepository {
  Future<User> getUser() async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/getuser'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final userJson = data['user'] as Map<String, dynamic>;
      final user = User.fromJson(userJson);
      return user;
    } else {
      throw Exception('Failed to get user');
    }
  }
}
