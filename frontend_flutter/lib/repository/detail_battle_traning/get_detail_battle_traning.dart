import 'dart:convert';

import 'package:frontend_flutter/repository/detail_battle_traning/get_detail_battle_traning_contract.dart';

import '../../models/Level.dart';
import '../../models/UserLevel.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;

class GetDetailBattleTrainingRepository
    implements DetailBattleTrainingRepository {
  Future<List<UserLevel>> getAllUserLevel(String topicType) async {
    final response = await http.post(Uri.parse('$baseUrl/userlevel/getall'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'topicType': topicType}));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final userslevels = data['userslevels'] as List<dynamic>;
      final userlevels = List<UserLevel>.from(
          userslevels.map((topic) => UserLevel.fromJson(topic)));
      return userlevels;
    } else {
      throw Exception('Failed to load topics');
    }
  }

  Future<List<Level>> getAllLevel(String topicType) async {
    final response = await http.post(Uri.parse('$baseUrl/level/getall'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'topicType': topicType}));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final listlevels = data['levels'] as List<dynamic>;
      final levels =
          List<Level>.from(listlevels.map((topic) => Level.fromJson(topic)));
      return levels;
    } else {
      throw Exception('Failed to load topics');
    }
  }
}
