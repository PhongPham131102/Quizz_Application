import '../../models/Question.dart';

abstract class QuestionAnswerContract{
  setQuestion(List<Question> _questions);
  setGold(int _gold);
  setIsLoading(bool _isloading);
  CountDown();
  setTime(int _time);
}