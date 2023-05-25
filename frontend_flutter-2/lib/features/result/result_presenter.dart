import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/result/result_contract.dart';

import '../../repository/result/get_result_contract.dart';

class ResultPresenter{
  ResultContract _view;
 late ResultRepository _repository;
 ResultPresenter(this._view){
  _repository=Injector().ResultRepository;
 }
}