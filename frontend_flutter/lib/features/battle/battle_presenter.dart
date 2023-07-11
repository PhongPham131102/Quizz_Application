import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/battle/battle_contract.dart';
import 'package:frontend_flutter/models/Question.dart';
import 'package:frontend_flutter/repository/battle/get_battle_contract.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../constants.dart';
import '../../models/Match.dart';
import '../../sound_manager.dart';

class BattlePresenter {
  BattleContract _view;
  // ignore: unused_field
  late BattleRepository _repository;
  BattlePresenter(this._view) {
    _repository = Injector().BattleRepository;
  }
  int indexX2Score = 999;
  CountDown(String room) {
    IO.Socket socket = _view.getSocket();
    // ignore: unused_local_variable
    List<Question> questions = [];
    socket.on("Questions$room", (data) {
      print("have data");
      _view.setListQuestion(
          getQuestionsFromData(data["questions"] as List<dynamic>));
      indexX2Score = data["x2Score"] as int;
      _view.setIndexX2Score(indexX2Score);
      socket.off("Questions$room");
    });
    socket.on("SubtractTime$room", (data) {
      if (data["uid"] != uid) {
        //gọi view xuất thông báo đối thủ vừa trừ thời gian
        print("SubtractTime");
      }
    });
        socket.on("DetroyChip$room", (data) {
      if (data["uid"] != uid) {
        //trừ điểm qua data.score
        //gọi view xuất thông báo đối thủ vừa trừ thời gian
           print("DetroyChip");
      }
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
      MatchBattle match =
          MatchBattle.fromJson(data["match"] as Map<String, dynamic>);
      socket.off("Result$room");
      _view.pushResult(match);
    });
  }

  SubtractTime(String roomid, int time) {
    IO.Socket socket = _view.getSocket();
    int timeSubtract = 0;
    if (time > 1) {
      timeSubtract = (time / 2).floor();
      socket.emit("SubtractTime",
          {"uid": uid, "roomid": roomid, "timeSubtract": timeSubtract});
    }
  }
  handlerAnswer(int index, int selectedIndex, bool scoreAnswer,
      bool youAnswered, int time, String roomid, String idAnswer,bool usingDetroyChip) {
    IO.Socket socket = _view.getSocket();
    if (!youAnswered) {
      _view.setYouAnswered(true);

      _view.setyourSelectedAnswerIndex(selectedIndex);
      if (scoreAnswer) {
        GlobalSoundManager().playButton("correct");
        int yourScore = (index == indexX2Score ? 2 : 1) * time * 20;

        print(yourScore);
        _view.setYourScore(yourScore);
        socket.emit("Match", {
          "uid": uid,
          "roomid": roomid,
          "index": index,
          "selectedIndex": selectedIndex,
          "score": yourScore,
          "idAnswer": idAnswer,
          "usingDetroyChip":usingDetroyChip
        });
      } else {
        GlobalSoundManager().playButton("wrong");
        _view.setYourScore(0);
        socket.emit("Match", {
          "uid": uid,
          "roomid": roomid,
          "index": index,
          "selectedIndex": selectedIndex,
          "score": 0,
          "idAnswer": idAnswer,
           "usingDetroyChip":usingDetroyChip
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
        time: questionData["time"],
        image: questionData["image"],
        typeQuestion: questionData["typeQuestion"],
        typeLanguage: questionData["typeLanguage"],
        level: questionData["level"],
        // idPost: questionData["idPost"],
        createdAt: DateTime.parse(questionData["createdAt"]),
        updatedAt: DateTime.parse(questionData["updatedAt"]),
      );
    }).toList();

    return questions;
  }
}
