import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/store/store_contract.dart';
import 'package:frontend_flutter/repository/store/get_store_contract.dart';

class StorePresenter {
  StoreContract _view;
  late StoreRepository _repository;
  StorePresenter(this._view)
  {
    _repository=Injector().StoreRepository;
  }
}