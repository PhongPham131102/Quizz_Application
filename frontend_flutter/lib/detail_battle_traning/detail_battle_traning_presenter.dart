// ignore_for_file: unused_field

import 'package:frontend_flutter/detail_battle_traning/detail_battle_traning_contract.dart';
import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/models/UserLevel.dart';
import 'package:frontend_flutter/repository/detail_battle_traning/get_detail_battle_traning_contract.dart';

import '../models/Level.dart';

class DetailBattleTrainingPresenter {
  DetailBattleTrainingContract _view;
  late DetailBattleTrainingRepository _repository;
  DetailBattleTrainingPresenter(this._view) {
    _repository = Injector().DetailBattleTrainingRepository;
  }
  Getall(String topicType) async {
    List<UserLevel> userlevels = await _repository.getAllUserLevel(topicType);
    List<Level> levels = await _repository.getAllLevel(topicType);
    print("object");
    _view.setListLevel(levels);
    print("object");
    _view.setListUserLevel(userlevels);
    print("object");
    _view.setIsLoading(false);
  }
  GetQuestions(String typeLanguage,int level )
  {
    
  }
}
