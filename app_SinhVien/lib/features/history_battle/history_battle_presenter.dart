import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/history_battle/history_battle_contract.dart';
import 'package:frontend_flutter/models/Match.dart';
import '../../repository/history_battle/get_history_battle_contract.dart';

class HistoryBattlePresenter {
  // ignore: unused_field
  HistoryBattleContract _view;
  // ignore: unused_field
  late HistoryBattleRepository _repository;
  HistoryBattlePresenter(this._view) {
    _repository = Injector().HistoryBattleRepository;
  }
  GetAllMatches() async {
    _view.setIsLoading(true);
    List<MatchBattle> matches = await _repository.getAllMatchs();
    matches.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    _view.setListMatches(matches);
    _view.setIsLoading(false);
  }
}
