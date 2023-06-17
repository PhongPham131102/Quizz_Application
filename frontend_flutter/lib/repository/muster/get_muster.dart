import 'package:frontend_flutter/repository/muster/get_muster_contract.dart';
import 'dart:convert';
import '../../constants.dart';
import 'package:http/http.dart' as http;
import '../../models/Muster.dart';

class GetMusterRepository implements MusterRepository {
  Future<List<Muster>> GetAll() async {
    final response = await http.get(
      Uri.parse('$baseUrl/muster/get'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final matchesList = data['musters'] as List<dynamic>;
      final matches =
          List<Muster>.from(matchesList.map((topic) => Muster.fromJson(topic)));
      return matches;
    } else {
      return [];
    }
  }

  CreateMuster(int gold, int exp, int diamond) async {
    final response = await http.post(Uri.parse('$baseUrl/muster/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'gold': gold,
          'exp': exp,
          'diamond': diamond,
        }));
    print(response.statusCode);
  }
}
