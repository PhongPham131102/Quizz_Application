import 'dart:convert';

import 'package:frontend_flutter/repository/pick_character/get_pick_character_contract.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class GetPickCharacterRepository implements PickCharacterRepository {
  Future<bool> updateGender(String tokenn, String gender) async {
    var response = await http.post(Uri.parse('$baseUrl/profiles/updategender'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokenn',
        },
        body: jsonEncode({
          'gender': gender,
        }));
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }
}
