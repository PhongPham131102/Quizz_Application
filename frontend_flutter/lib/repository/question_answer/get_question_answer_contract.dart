import '../../models/Question.dart';

abstract class QuestionAnswerRepository{
    Future<int> getgold();
    Future<List<Question>> GetQuestions(String typeLanguage,int level);
}