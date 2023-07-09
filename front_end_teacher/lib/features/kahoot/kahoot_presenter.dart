// ignore_for_file: unused_field
import 'package:front_end_teacher/di/injection.dart';
import 'package:front_end_teacher/features/kahoot/kahoot_contract.dart';
import 'package:front_end_teacher/repository/kahoot/get_kahoot_contract.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../constants.dart';
import '../../models/QuestionTheme.dart';

class KahootPresenter {
  KahootContract _view;
  late KahootRepository _repository;
  KahootPresenter(this._view) {
    _repository = Injector().KahootRepository;
  }
  IO.Socket socket =
      IO.io('${baseUrl.replaceAll("/api", "")}', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
  });

  String testRoom = "";
  GetQuestionAndCodeRoom(String idPost) {
    socket.on("testRoom${uid}", (data) {
      testRoom = data["testRoom"];
      List<QuestionTheMe> questionList = data["listQuestions"]
          .map<QuestionTheMe>((json) => QuestionTheMe.fromJson(json))
          .toList();
      _view.setListQuestion(questionList);
      _view.setIdRoom(testRoom);
      socket.on("testRoom${testRoom}", (data) {
        if (data["event"] == "answer") {
          int indexQuestion = _view.getIndexQuestion();
          _view.incrementTotalAnswer();
          _view.getTotalScore()["${data["uid"]}"]?["totalScore"] +=
              data["score"];
          _view.getTotalScore()["${data["uid"]}"]?["answer${indexQuestion + 1}"]
              ?["score"] = data["score"];
          if (data["index"] == 1) {
            _view.incrementAnwer1();
          } else if (data["index"] == 2) {
            _view.incrementAnwer1();
          } else if (data["index"] == 3) {
            _view.incrementAnwer1();
          } else if (data["index"] == 4) {
            _view.incrementAnwer1();
          }
        }
        if (data["event"] == "join") {
          bool lockroom = _view.getLockRoom();
          if (!lockroom) {
            //nếu có người chơi thì xóa thông báo đang chờ  người chơi
            bool havePlayer = _view.getHavePlayer();
            if (!havePlayer) {
              _view.sethavePlayer(true);
            }

            _view.incrementPlayer();
            _view.getTotalScore()["${data["uid"]}"] = {
              "totalScore": 0,
              "name": "${data["name"]}",
            };

            for (int i = 1; i < questionList.length + 1; i++) {
              _view.getTotalScore()["${data["uid"]}"]?["answer${i}"] = {
                "score": 0,
              };
            }
            socket.emit("join", {
              "isJoin": true,
              "uid": data["uid"],
              "idPost": idPost,
            });
          } else {
            socket.emit("join", {
              "isJoin": false,
              "uid": data["uid"],
            });
          }
        }
        if (data["event"] == "outroom") {
          _view.getTotalScore().removeWhere((key, value) => key == data["uid"]);
          if (_view.getCountPlayer() > 0) {
            _view.decrementCountPlayer();
          }
        }
      });
    });
    socket.emit("getroom", {
      "uid": uid,
      "idPost": idPost,
    });
  }

  ShowBoard() {
    socket.emit("testRoomStudent", {
      "event": "showboard",
      "testRoom": testRoom,
    });
    //sắp xếp bảng xếp hạng
    _view.setisShowBoad(true);
  }
}
