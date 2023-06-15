import 'dart:convert';

import 'package:frontend_flutter/repository/personal_profile/get_personal_profile_contract.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../../models/DetailUserMatch.dart';
import '../../models/UserTopic.dart';

class GetPersonalProfileRepository implements PersonalProfileRepository {
  Future<List<UserTopic>> GetAll() async {
    final response = await http.get(
      Uri.parse('$baseUrl/usertopic/getall'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final usertopic = data['userstopics'] as List<dynamic>;
      final usertopics = List<UserTopic>.from(
          usertopic.map((topic) => UserTopic.fromJson(topic)));
      return usertopics;
    } else {
      throw Exception('Failed to load topics');
    }
  }

  Future<DetailUserMatch> GetAllUserMatch() async {
    final response = await http.get(
      Uri.parse('$baseUrl/detailusermatch/get'),
      headers: {'Authorization': 'Bearer $token', 'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
     DetailUserMatch dt=DetailUserMatch.fromJson(data["detailUserMatch"]);
     return dt;
    } else {
      throw Exception('Failed to load topics');
    }
  }
}
