import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/models/UserTopic.dart';
import 'package:frontend_flutter/repository/battle_training/get_battle_training_contract.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../constants.dart';
import 'battle_training_contract.dart';

class BattleTrainingPresenter {
  // ignore: unused_field
  BattleTrainingContract _view;
  // ignore: unused_field
  late BattleTrainingRepository _repository;
  BattleTrainingPresenter(this._view) {
    _repository = Injector().BattletrainingRepository;
  }
  Getall() async {
    List<UserTopic> usertopics = await _repository.GetAll();
    _view.setListUserTopic(usertopics);
    _view.setIsLoading(false);
    IO.Socket socket =
        IO.io('${baseUrl.replaceAll("/api", "")}', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket.on("topic$uid", (data) {
      _view.updateTopic(UserTopic.fromJson(data['userTopic']));
    });
  }
}
