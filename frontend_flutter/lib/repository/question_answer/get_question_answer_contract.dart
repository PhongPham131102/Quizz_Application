import '../../models/Question.dart';

abstract class QuestionAnswerRepository{
    Future<int> getgold();
    Future<List<Question>> GetQuestions(String typeLanguage,int level);
    Future<Map<String, dynamic>> Summary(String topicType,int level,int usersScore,int maxScore,int gold);
}