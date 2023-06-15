// ignore_for_file: unused_field

import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/rank/rank_contract.dart';
import 'package:frontend_flutter/repository/rank/get_rank_contract.dart';

class RankPresenter {
  RankContract _view;
  late RankRepository _repository;
  RankPresenter(this._view) {
    _repository = Injector().RankRepository;
  }
}
