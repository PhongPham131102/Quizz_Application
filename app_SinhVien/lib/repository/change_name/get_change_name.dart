import 'dart:convert';

import 'package:frontend_flutter/repository/change_name/get_change_name_contract.dart';
import 'package:http/http.dart' as http;

import '../../constants.dart';

class GetChangeNameRepository implements ChangeNameRepository {
  Future<bool> changeName(String name, String idItem) async {
    final response = await http.post(Uri.parse('$baseUrl/profiles/changename'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'name': name, "idItem": idItem}));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
