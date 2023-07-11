import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/question_answer/question_answer_contract.dart';

import '../../models/Question.dart';
import '../../repository/question_answer/get_question_answer_contract.dart';

class QuestionAnswerPresenter {
  QuestionAnswerContract _view;
  late QuestionAnswerRepository _repository;
  QuestionAnswerPresenter(this._view) {
    _repository = Injector().QuestionAnswerRepository;
  }
  getGoldAndQuestion(String topicsType, int level) async {
    _view.setIsLoading(true);
    List<Question> questions =
        await _repository.GetQuestions(topicsType, level);
    int _gold = await _repository.getgold();
    int maxscore = 0;
    for (int i = 0; i < questions.length; i++) {
      maxscore += questions[i].score;
    }
    _view.setMaxScore(maxscore);
    _view.setGold(_gold);
    _view.setQuestion(shuffleQuestions(questions));
    int time=0;
    for (var question in questions) {
      time+=question.time;
    }
    _view.setTime(time);
    _view.setIsLoading(false);
    _view.CountDown();
  }

  Sumarry(String topicType, int level, int usersScore, int maxScore,
      int gold) async {
    _view.SetSummaring(true);
    final responseData =
        await _repository.Summary(topicType, level, usersScore, maxScore, gold);
    int oldLevel = responseData['oldLevel'] as int;
    int expEarned = responseData['expEarned'] as int;
    int oldExp = responseData['oldexp'] as int;
    int nowExp = responseData['nowexp'] as int;
    int newLevel = responseData['newLevel'] as int;
    int gold1 = responseData['gold'] as int;
    int star = responseData['star'] as int;
    _view.SetParameterResult(
        oldLevel, expEarned, oldExp, nowExp, newLevel, gold1, star);
    _view.SetEnd(true);
    _view.SetSummaring(false);
  }

  List<Question> shuffleQuestions(List<Question> questions) {
    var newList = List<Question>.from(questions);
    newList.shuffle();
    return newList;
  }
}
