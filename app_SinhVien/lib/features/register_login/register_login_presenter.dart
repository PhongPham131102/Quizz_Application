import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/register_login/register_login_contract.dart';

import '../../repository/register_login/get_register_login_contract.dart';

class RegisterLoginPresenter {
  // ignore: unused_field
  RegisterLoginContract _view;
  // ignore: unused_field
  late RegisterLoginRepository _repository;
  RegisterLoginPresenter(this._view) {
    _repository = Injector().RegisterLoginRepository;
  }
}
