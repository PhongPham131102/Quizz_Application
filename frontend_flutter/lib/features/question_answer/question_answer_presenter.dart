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
    print(questions.length);
    _view.setGold(_gold);
    _view.setQuestion(shuffleQuestions(questions));
    _view.setTime(questions.length * 10);
    _view.setIsLoading(false);
    _view.CountDown();
  }

  List<Question> shuffleQuestions(List<Question> questions) {
    var newList = List<Question>.from(questions);
    newList.shuffle();
    return newList;
  }
}
