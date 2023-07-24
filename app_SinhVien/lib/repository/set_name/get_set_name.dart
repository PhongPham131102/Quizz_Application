import 'package:frontend_flutter/repository/set_name/get_set_name_contract.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../constants.dart';

class GetSetNameRepository implements SetNameRepository {
  Future<bool> updateName(String tokenn, String name) async {
    var response = await http.post(Uri.parse('$baseUrl/profiles/updatename'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $tokenn',
        },
        body: jsonEncode({
          'name': name,
        }));
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }
}
