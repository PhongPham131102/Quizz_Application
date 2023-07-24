// ignore_for_file: unused_field

import 'package:frontend_flutter/features/detail_battle_traning/detail_battle_traning_contract.dart';
import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/models/UserLevel.dart';
import 'package:frontend_flutter/repository/detail_battle_traning/get_detail_battle_traning_contract.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../constants.dart';
import '../../models/Level.dart';

class DetailBattleTrainingPresenter {
  DetailBattleTrainingContract _view;
  late DetailBattleTrainingRepository _repository;
  DetailBattleTrainingPresenter(this._view) {
    _repository = Injector().DetailBattleTrainingRepository;
  }
  Getall(String topicType) async {
    List<UserLevel> userlevels = await _repository.getAllUserLevel(topicType);
    List<Level> levels = await _repository.getAllLevel(topicType);
    _view.setListLevel(levels);
    _view.setListUserLevel(userlevels);
    _view.setIsLoading(false);
    IO.Socket socket =
        IO.io('${baseUrl.replaceAll("/api", "")}', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket.on("levels$uid", (data) {
      print(data['userlevels']);
      List<UserLevel> userLevelsList = [];

      List<dynamic> userLevelsData = data['userlevels'];

      for (var levelData in userLevelsData) {
        UserLevel userLevel = UserLevel.fromJson(levelData);
        userLevel.printAllProperties();
        userLevelsList.add(userLevel);
      }

      _view.updateLevel(userLevelsList);
    });
  }
}
