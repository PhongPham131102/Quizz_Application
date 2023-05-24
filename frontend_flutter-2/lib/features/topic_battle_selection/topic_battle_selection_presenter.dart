import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/topic_battle_selection/topic_battle_selection_contract.dart';
import 'package:frontend_flutter/repository/topic_battle_selection/get_topic_battle_selection_contract.dart';

class TopicBattleSelectionPresenter {
  TopicBattleSelectionContract _view;
  late TopicBattleSelectionRepository _repository;
  TopicBattleSelectionPresenter(this._view) {
    _repository = Injector().TopicBattleSelectionRepository;
  }
}
