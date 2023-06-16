import 'dart:convert';

import 'package:frontend_flutter/repository/rank/get_rank_contract.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';
import '../../models/Profile.dart';

class GetRankRepository implements RankRepository {
  Future<Map<String, dynamic>> GetAll() async {
    final response = await http.get(
      Uri.parse('$baseUrl/usertopic/getalluser'),
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      return data;
      //return usertopics;
    } else {
      throw Exception('Failed to load topics');
    }
  }

  Future<List<Profile>> GetAllTop10Profile() async {
    final response = await http.get(
      Uri.parse('$baseUrl/profiles/top10user'),
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final userProfile = data['profiles'] as List<dynamic>;
      final userProfiles =
          List<Profile>.from(userProfile.map((u) => Profile.fromJson(u)));
      return userProfiles;
      //return usertopics;
    } else {
      throw Exception('Failed to load topics');
    }
  }
}
