import '../../models/Question.dart';

abstract class QuestionAnswerContract {
  setQuestion(List<Question> _questions);
  setGold(int _gold);
  setIsLoading(bool _isloading);
  CountDown();
  setMaxScore(int _maxscore);
  setTime(int _time);
  SetEnd(bool _isend);
  SetSummaring(bool _summaring);
  SetParameterResult(int _oldLevel, int _expEarned, int _oldExp, int _nowExp,
      int _newLevel, int _gold, int _star);
}
