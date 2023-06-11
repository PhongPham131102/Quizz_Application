import 'package:frontend_flutter/detail_battle_traning/detail_battle_traning_contract.dart';
import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/repository/detail_battle_traning/get_detail_battle_traning_contract.dart';

class DetailBattleTrainingPresenter{
  DetailBattleTrainingContract _view;
  late DetailBattleTrainingRepository _presenter;
  DetailBattleTrainingPresenter(this._view)
  {
    _presenter=Injector().DetailBattleTrainingRepository;
  }
}