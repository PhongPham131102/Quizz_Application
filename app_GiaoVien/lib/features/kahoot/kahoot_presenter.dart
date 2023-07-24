// ignore_for_file: unused_field, unnecessary_string_interpolations, prefer_final_fields, library_prefixes, unnecessary_brace_in_string_interps, non_constant_identifier_names, prefer_const_constructors
import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:front_end_teacher/di/injection.dart';
import 'package:front_end_teacher/features/kahoot/kahoot_contract.dart';
import 'package:front_end_teacher/repository/kahoot/get_kahoot_contract.dart';

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
  bool getOneTimeListQuestion = true;
  String testRoom = "";
  GetQuestionAndCodeRoom(String idPost) {
    socket.on("testRoom${uid}", (data) {
      testRoom = data["testRoom"];
      if (getOneTimeListQuestion) {
        List<QuestionTheMe> questionList = data["listQuestions"]
            .map<QuestionTheMe>((json) => QuestionTheMe.fromJson(json))
            .toList();
        _view.setListQuestion(questionList);
        _view.setIdRoom(testRoom);
      }

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
            _view.incrementAnwer2();
          } else if (data["index"] == 3) {
            _view.incrementAnwer3();
          } else if (data["index"] == 4) {
            _view.incrementAnwer4();
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
            for (int i = 1; i < _view.getListQuestion().length + 1; i++) {
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
    Map<String, dynamic> totalScore = _view.getTotalScore();
    int indexQuestion = _view.getIndexQuestion();
    List<MapEntry<String, dynamic>> sortedEntries = totalScore.entries.toList()
      ..sort((a, b) {
        int scoreA = a.value['answer${indexQuestion + 1}']['score'];
        int scoreB = b.value['answer${indexQuestion + 1}']['score'];
        return scoreB.compareTo(scoreA);
      });
    _view.SetsortedEntries(sortedEntries);
    _view.setisShowBoad(true);
  }

  kickOut(String uid) {
    socket.emit("RoomPlayer", {
      "message": "bạn đã bị kick khỏi phòng",
      "uid": uid,
    });
  }

  Summary() {
    socket.emit("testRoomStudent", {
      "event": "summary",
      "testRoom": testRoom,
    });
    Map<String, dynamic> totalScore = _view.getTotalScore();
    List<MapEntry<String, dynamic>> sortedEntries = totalScore.entries.toList()
      ..sort((a, b) {
        int scoreA = a.value['totalScore'];
        int scoreB = b.value['totalScore'];
        return scoreB.compareTo(scoreA);
      });
    _view.SetsortedEntries(sortedEntries);
    _view.setIsSummary();
  }

  int temporaryIndexQuestion = 99;
  bool skipQuestion = false;
  late Timer countdownTimer;
  functionSkipQuestion() {
    skipQuestion = true;
    temporaryIndexQuestion=_view.getIndexQuestion();
    if (_view.getTypePost() == 'all-sentences') {
      if (_view.getIndexQuestion() < _view.getListQuestion().length - 1) {
        int indexQuestion = _view.getIndexQuestion();
        _view.setIndexQuestion(indexQuestion++);
        ShowQuestion();
      } else {
        Summary();
      }
    } else {
      skipQuestion = true;
      if (_view.getIndexQuestion() < _view.getListQuestion().length - 1) {
        ShowBoard();
      } else {
        Summary();
      }
    }
  }

  ShowQuestion() {
    skipQuestion = false;
    temporaryIndexQuestion=_view.getIndexQuestion();
    _view.setisShowQuestion();
    _view.resetAnswer();
    socket.emit("testRoomStudent", {
      "event": "showQuestion",
      "indexQuestion": _view.getIndexQuestion(),
      "testRoom": testRoom,
    });
    int i = _view.getListQuestion()[_view.getIndexQuestion()].time;
    temporaryIndexQuestion = _view.getIndexQuestion();
    _view.setTime(i);
    socket.emit("testRoomStudent", {
      "event": "time",
      "time": i,
      "testRoom": testRoom,
    });
    countdownTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (skipQuestion || temporaryIndexQuestion != _view.getIndexQuestion()) {
        timer.cancel();
        return;
      }

      i--;
      socket.emit('testRoomStudent', {
        'event': 'time',
        'time': i,
        'testRoom': testRoom,
      });
      _view.setTime(i);

      if (i == 0) {
        if (_view.getTypePost() == 'all-sentences') {
          if (_view.getIndexQuestion() < _view.getListQuestion().length - 1) {
            int indexQuestion = _view.getIndexQuestion();
            _view.setIndexQuestion(indexQuestion++);
            timer.cancel();
            ShowQuestion();
          } else {
            timer.cancel();
            Summary();
          }
        } else {
          if (_view.getIndexQuestion() < _view.getListQuestion().length - 1) {
            timer.cancel();
            ShowBoard();
          } else {
            timer.cancel();
            Summary();
          }
        }
      }
    });
  }

  coutdown() {
    _view.setIsCoutdown();
    _view.setSkipQuestion(false);
    socket.emit("testRoomStudent", {
      "event": "coutdown",
      "testRoom": testRoom,
    });
    int coutdown = 3;
    _view.setValueCoutdown(coutdown);
    socket.emit("testRoomStudent", {
      "event": "valueCoutdown",
      "countdown": coutdown,
      "testRoom": testRoom,
    });
    countdownTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      coutdown--;

      if (coutdown == 0) {
        _view.setValueCoutdown(coutdown);
        socket.emit('testRoomStudent', {
          'event': 'valueCoutdown',
          'countdown': 'start',
          'testRoom': testRoom,
        });
        ShowQuestion();
        timer.cancel();
        return;
      } else {
        _view.setValueCoutdown(coutdown);
        socket.emit('testRoomStudent', {
          'event': 'valueCoutdown',
          'countdown': coutdown,
          'testRoom': testRoom,
        });
      }
    });
  }

  void dispose() {
    socket.off("testRoom${uid}");
    socket.off("testRoom${testRoom}");
  }
}
