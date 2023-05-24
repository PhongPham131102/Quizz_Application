import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/battle/battle_contract.dart';
import 'package:frontend_flutter/models/Question.dart';
import 'package:frontend_flutter/repository/battle/get_battle_contract.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class BattlePresenter {
  BattleContract _view;
  late BattleRepository _repository;
  BattlePresenter(this._view) {
    _repository = Injector().BattleRepository;
  }
  CountDown(String room) {
    IO.Socket socket = _view.getSocket();
    List<Question> questions = [];
    socket.on("Questions$room", (data) {
      _view.setListQuestion(
          getQuestionsFromData(data["questions"] as List<dynamic>));
    });
    socket.on("TimerRoom$room", (data) {
      if (_view.getIndex() != data["index"] as int) {
        _view.setIndex(data["index"] as int);
      }
      _view.setTime(data["time"] as int);
    });
  }

  getQuestionsFromData(List<dynamic> data) {
    List<dynamic> questionList = data;
    List<Question> questions = questionList.map((questionData) {
      return Question(
        id: questionData["_id"],
        title: questionData["title"],
        answers: List<Answer>.from(questionData["answers"].map((answerData) {
          return Answer(
            answerText: answerData["answerText"],
            score: answerData["score"],
            id: answerData["_id"],
          );
        })),
        difficulty: questionData["difficulty"],
        score: questionData["score"],
        image: questionData["image"],
        typeQuestion: questionData["typeQuestion"],
        typeLanguage: questionData["typeLanguage"],
        level: questionData["level"],
        idPost: questionData["idPost"],
        createdAt: DateTime.parse(questionData["createdAt"]),
        updatedAt: DateTime.parse(questionData["updatedAt"]),
      );
    }).toList();

    return questions;
  }
}
