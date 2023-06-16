import 'package:frontend_flutter/di/injection.dart';

import '../../repository/muster/get_muster_contract.dart';
import 'muster_contract.dart';

class MusterPresenter{
  MusterContract _view;
  late MusterRepository _repository;
  MusterPresenter(this._view)
  {
    _repository=Injector().MusterRepository;
  }
}