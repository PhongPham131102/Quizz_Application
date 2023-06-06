import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/detail_history_battle/detail_history_battle_contract.dart';
import 'package:frontend_flutter/models/Match.dart';
import 'package:frontend_flutter/models/Profile.dart';
import 'package:frontend_flutter/repository/detail_history_battle/get_detail_history_battle_contract.dart';

import '../../constants.dart';

class DetailHistoryBattlePresenter {
  // ignore: unused_field
  DetailHistoryBattleContract _view;
  // ignore: unused_field
  late DetailHistoryBattleRepository _repository;
  DetailHistoryBattlePresenter(this._view) {
    _repository = Injector().DetailHistoryBattleRepository;
  }
  GetRivalProfile(MatchBattle matchBattle) async {
    _view.setIsLoading(true);
    String rivalId =
        matchBattle.player1 == uid ? matchBattle.player2 : matchBattle.player1;
    Profile rivalProfile = await _repository.getProfile(rivalId);
    _view.SetRivalProfile(rivalProfile);
    _view.setIsLoading(false);
  }
}
