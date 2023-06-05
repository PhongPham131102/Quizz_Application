import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/history_battle/history_battle_contract.dart';

import '../../repository/history_battle/get_history_battle.dart';

class HistoryBattlePresenter {
  // ignore: unused_field
  HistoryBattleContract _view;
  // ignore: unused_field
  late GetHistoryBattleRepository _presenter;
  HistoryBattlePresenter(this._view) {
    _presenter = Injector().HistoryBattleRepository;
  }
}
