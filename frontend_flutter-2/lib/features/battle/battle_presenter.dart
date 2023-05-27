import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/battle/battle_contract.dart';
import 'package:frontend_flutter/models/Question.dart';
import 'package:frontend_flutter/repository/battle/get_battle_contract.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../constants.dart';
import '../../models/Match.dart';

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
      print("have data");
      _view.setListQuestion(
          getQuestionsFromData(data["questions"] as List<dynamic>));
    });
    socket.on("Match$room", (data) {
      if (data["uid"] != uid) {
        _view.setRivalSelectedAnswerIndex(data["selectedIndex"] as int);
        _view.setRivalScore(data["score"] as int);
      }
    });
    socket.on("TimerRoom$room", (data) {
      if (_view.getIndex() != data["index"] as int) {
        _view.setIndex(data["index"] as int);
        _view.setYouAnswered(false);
        _view.setyourSelectedAnswerIndex(null);
        _view.setRivalSelectedAnswerIndex(null);
      }
      _view.setTime(data["time"] as int);
    });
    socket.on("Result$room", (data) {
      MatchBattle match= MatchBattle.fromJson(data["match"] as Map<String, dynamic>);
     socket.off("Result$room");
     _view.pushResult(match);
    });
  }

  handlerAnswer(int index, int selectedIndex, bool scoreAnswer,
      bool youAnswered, int time, String roomid, String idAnswer) {
    IO.Socket socket = _view.getSocket();
    if (!youAnswered) {
      _view.setYouAnswered(true);
      _view.setyourSelectedAnswerIndex(selectedIndex);
      if (scoreAnswer) {
        int yourScore = (index == 4 ? 2 : 1) * time * 20;
        print(yourScore);
        _view.setYourScore(yourScore);
        socket.emit("Match", {
          "uid": uid,
          "roomid": roomid,
          "index": index,
          "selectedIndex": selectedIndex,
          "score": yourScore,
          "idAnswer": idAnswer
        });
      } else {
        _view.setYourScore(0);
        socket.emit("Match", {
          "uid": uid,
          "roomid": roomid,
          "index": index,
          "selectedIndex": selectedIndex,
          "score": 0,
          "idAnswer": idAnswer
        });
      }
    }
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
