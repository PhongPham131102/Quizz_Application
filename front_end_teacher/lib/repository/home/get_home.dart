import 'package:front_end_teacher/repository/home/get_home_contract.dart';
import 'dart:convert';
import '../../models/Test.dart';
import 'package:http/http.dart' as http;
import '../../constants.dart';

class GetHomeREpository implements HomeRepository {
Future<List<Test>> getTests() async {
  print(token);
  var response = await http.get(
    Uri.parse('$baseUrl/test/get'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  
  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    var listTest = data['tests'] as List<dynamic>;
    final tests = listTest.map((test) => Test.fromJson(test)).toList();
    return tests;
  } else {
    throw Exception('Failed to fetch tests');
  }
}
}
