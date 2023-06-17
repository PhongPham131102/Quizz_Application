import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/personal_information/personal_information_contract.dart';
import 'package:frontend_flutter/repository/personal_information/get_personal_information_contract.dart';

import '../../models/User.dart';

class PersonalInformationPresenter {
  PersonalInformationContract _view;
  late PersonalInformationRepository _repository;
  PersonalInformationPresenter(this._view) {
    _repository = Injector().PersonalInformationRepository;
  }
  GetUser() async {
    User _user = await _repository.getUser();
    _view.SetUser(_user);
  }
}
