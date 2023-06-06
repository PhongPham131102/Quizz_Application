import 'dart:convert';

import '../../constants.dart';
import '../../models/Profile.dart';
import 'get_detail_history_battle_contract.dart';
import 'package:http/http.dart' as http;

class GetDetailHisoryBattleRepository implements DetailHistoryBattleRepository {
  Future<Profile> getProfile(String uid) async {
    var response =
        await http.post(Uri.parse('$baseUrl/profiles/queryidprofile'),
            headers: {
              'Content-Type': 'application/json',
            },
            body: jsonEncode({
              'uid': uid,
            }));
    var data = jsonDecode(response.body);
    var profile = Profile.fromJson(data['profile']);
    return profile;
  }
}
