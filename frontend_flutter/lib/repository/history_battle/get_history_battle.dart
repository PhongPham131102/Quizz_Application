import 'package:frontend_flutter/repository/history_battle/get_history_battle_contract.dart';
import 'dart:convert';
import '../../constants.dart';
import '../../models/Match.dart';
import 'package:http/http.dart' as http;

class GetHistoryBattleRepository implements HistoryBattleRepository {
  Future<List<MatchBattle>> getAllMatchs() async {
    final response = await http.get(
      Uri.parse('$baseUrl/match/getusermatch'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final matchesList = data['matches'] as List<dynamic>;
      final matches = List<MatchBattle>.from(
          matchesList.map((topic) => MatchBattle.fromJson(topic)));
      return matches;
    } else {
      return [];
    }
  }
}
