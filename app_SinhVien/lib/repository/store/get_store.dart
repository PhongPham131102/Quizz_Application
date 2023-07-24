import 'package:frontend_flutter/repository/store/get_store_contract.dart';
import 'dart:convert';
import '../../constants.dart';
import '../../models/Item.dart';
import 'package:http/http.dart' as http;

import '../../models/UserItem.dart';

class GetStoreRepository implements StoreRepository {
  Future<List<Item>> getAllItem(String gender) async {
    final response = await http.post(Uri.parse('$baseUrl/items/getall'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'gender': gender}));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final itemList = data['items'] as List<dynamic>;
      final items =
          List<Item>.from(itemList.map((topic) => Item.fromJson(topic)));
      return items;
    } else {
      throw Exception('Failed to load topics');
    }
  }

  Future<List<UsersItem>> getUsersItem() async {
    final response = await http.get(
      Uri.parse('$baseUrl/usersitems/getall'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final usersitemsList = data['usersitems'] as List<dynamic>;
      final usersitems = List<UsersItem>.from(
          usersitemsList.map((topic) => UsersItem.fromJson(topic)));
      return usersitems;
    } else {
      throw Exception('Failed to load topics');
    }
  }
}
