import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/result/result_contract.dart';

import '../../repository/result/get_result_contract.dart';

class ResultPresenter {
  // ignore: unused_field
  ResultContract _view;
  // ignore: unused_field
  late ResultRepository _repository;
  ResultPresenter(this._view) {
    _repository = Injector().ResultRepository;
  }
}
