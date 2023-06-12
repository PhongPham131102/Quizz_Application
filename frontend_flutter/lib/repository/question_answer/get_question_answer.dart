import 'dart:convert';

import '../../constants.dart';
import '../../models/Question.dart';
import 'get_question_answer_contract.dart';
import 'package:http/http.dart' as http;

import '../../models/Profile.dart';

class GetQuestionAnswerRepository implements QuestionAnswerRepository {
  Future<int> getgold() async {
    var response = await http.get(
      Uri.parse('$baseUrl/profiles/getprofile'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    var data = jsonDecode(response.body);
    var profile = Profile.fromJson(data['profile']);
    return profile.gold;
  }

  Future<List<Question>> GetQuestions(String typeLanguage, int level) async {
    var response =
        await http.post(Uri.parse('$baseUrl/questions/getquestiontopic'),
            headers: {
              'Accept':"application/json",
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: jsonEncode({
              'typeLanguage': typeLanguage,
              'level': level,
            }));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List<dynamic> questionList = jsonData['question'];

      List<Question> questions = [];
      for (var item in questionList) {
        questions.add(Question.fromJson(item));
      }

      return questions;
    } else {
      throw Exception('Failed to fetch questions');
    }
  }
}
