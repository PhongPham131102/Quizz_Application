import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/home/home_contract.dart';
import 'package:frontend_flutter/models/Profile.dart';
import 'package:frontend_flutter/repository/home/get_home_contract.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../constants.dart';
import '../../models/Question.dart';

class HomePresenter {
  HomeContract _view;
  late HomeRepository _repository;
  HomePresenter(this._view) {
    _repository = Injector().HomeRepository;
  }
  getinfo() async {
    _view.setIsLoading(true);
    _view.updateProfile(await _repository.getProfile());
    _view.setIsLoading(false);
  }

  getsocket() {
    IO.Socket socket =
        IO.io('${baseUrl.replaceAll("/api", "")}', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket.on("login$uid", (data) {
     _view.logout();
    });
    socket.on("profile$uid", (data) {
      print("có dữ liệu");
      print(data);
      _view.updateProfile(Profile.fromJson(data['profile']));
    });
    socket.emit("resume", {"uid": uid});
    socket.on("resume$uid", (data) {
      _view.pushBattle(
          Profile.fromJson(data["rival"]),
          data['idRoom'],
          data['topic'],
          getQuestionsFromData(data["questions"] as List<dynamic>),
          data["rivalscore"] as int,
          data["yourscore"] as int);
      socket.off("resume$uid");
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
