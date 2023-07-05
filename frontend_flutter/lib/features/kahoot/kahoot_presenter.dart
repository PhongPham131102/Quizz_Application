// ignore_for_file: unused_field
import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/kahoot/kahoot_contract.dart';
import 'package:frontend_flutter/models/QuestionTheme.dart';
import 'package:frontend_flutter/repository/kahoot/get_fill_code_room_contract.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../constants.dart';

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
  String room = "";
  initSocket() {
    socket.on("join", (data) {
      print(data);
    });
  }

  dispose() {
    socket.off("RoomPlayer$uid");
    socket.off("checkRoom$uid");
    socket.off("join$uid");
    socket.emit("testRoom", {"uid": uid, "event": "outroom", "roomCode": room});
  }

  sendCodeRoom(String _room) {
    room = _room;
    _view.setRoom(room);
    _view.setisloading(true);
    socket.on("RoomPlayer$uid", (data) {
      _view.showDialog("Bạn đã bị kick khỏi phòng", true);
      socket.off("RoomPlayer$uid");
    });
    socket.on("checkRoom$uid", (data) {
      _view.setisloading(false);
      if (data["exit"] as bool == true) {
        _view.setHaveRoom();
      } else {
        _view.setvalidateName("không tồn tại mã phòng này.");
      }
      socket.off("checkRoom$uid");
    });
    socket.emit("checkRoom", {"uid": uid, "codeRoom": _room});
  }

  sendAnswer(int score, bool isCorrect) {
    _view.RoomisShowCorrect(isCorrect);
  }

  sendName(String name) {
    socket.on("testRoomStudent${room}", (data) {
      if (data["event"] == "showboard") {
        _view.RoomisShowCorrect(false);
      }
        if (data["event"] == "summary") {
        _view.RoomisSummanry(true);
      }
      if (data["event"] == "coutdown") {
        _view.RoomisCoutDown(true);
      }
      if (data["event"] == "valueCoutdown") {
        _view.setValueCoutDown(data["countdown"].toString());
      }
      if (data["event"] == "showQuestion") {
        _view.RoomisShowQuestion(true, data["indexQuestion"] as int);
      }
      if (data["event"] == "time") {
        _view.setTime(data["time"] as int);
      }
    });
    socket.on("join$uid", (data) {
      _view.setisloading(false);
      if (data["isJoin"] as bool == true) {
        _view.setName(name);
        List<QuestionTheMe> listQuestionsTheme =
            getQuestionsFromData(data["listQuestions"] as List<dynamic>);
        _view.setListQuestion(listQuestionsTheme);
        _view.RoomtisInRoom(true);
      } else {
        _view.showDialog("Giáo viên đã khóa phòng này", true);
      }
      socket.off("join$uid");
    });
    socket.emit("testRoom",
        {"uid": uid, "name": name, "event": "join", "roomCode": room});
  }

  getQuestionsFromData(List<dynamic> data) {
    List<dynamic> questionList = data;
    List<QuestionTheMe> questions = questionList.map((questionData) {
      return QuestionTheMe(
        id: questionData["_id"],
        uid: questionData["uid"],
        title: questionData["title"],
        answers: List<Answer>.from(questionData["answers"].map((answerData) {
          return Answer(
            answerText: answerData["answerText"],
            score: answerData["score"],
            id: answerData["_id"],
          );
        })),
        score: questionData["score"],
        image: questionData["image"],
        time: questionData["time"],
        theme: questionData["theme"],
        createdAt: DateTime.parse(questionData["createdAt"]),
        updatedAt: DateTime.parse(questionData["updatedAt"]),
      );
    }).toList();

    return questions;
  }
}
