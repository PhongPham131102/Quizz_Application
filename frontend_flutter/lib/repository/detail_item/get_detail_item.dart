import '../../constants.dart';
import 'get_detail_item_contract.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class GetDetailItemRepository implements DetailItemRepository {
  Future<bool> buyItem(
      String idItem, int quantity, String typeMoney, int price) async {
    final response = await http.post(Uri.parse('$baseUrl/usersitems/create'),
        headers: {
           'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'idItem': idItem,
          'quantity': quantity,
          "typeMoney": typeMoney,
          "price": price
        }));
    if (response.statusCode == 200||response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
