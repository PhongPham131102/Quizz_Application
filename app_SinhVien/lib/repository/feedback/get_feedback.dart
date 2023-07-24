import 'dart:convert';

import 'package:frontend_flutter/repository/feedback/get_feedback_contract.dart';
import '../../constants.dart';
import 'package:http/http.dart' as http;

class GetFeedBackRepository implements FeedBackRepository {
  Future<bool> SendFeedBack(String content) async {
    final respone = await http.post(Uri.parse('$baseUrl/feedback/create'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'content': content}));
    print(respone.statusCode);
    return true;
  }
}
