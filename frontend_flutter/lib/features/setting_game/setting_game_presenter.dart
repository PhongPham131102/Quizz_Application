import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/setting_game/setting_game_contract.dart';
import 'package:frontend_flutter/repository/setting_game/get_setting_game_contract.dart';

class SettingGamePresenter {
  // ignore: unused_field
  SettingGameContract _view;
  // ignore: unused_field
  late SettingGameRepository _repository;
  SettingGamePresenter(this._view) {
    _repository = Injector().SettingGameRepository;
  }
}
