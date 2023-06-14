// ignore_for_file: unused_field

import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/personal_profile/personal_profile_contract.dart';
import 'package:frontend_flutter/repository/personal_profile/get_personal_profile_contract.dart';

class PersonalProfilePresenter {
  PersonalProfileContract _view;
  late PersonalProfileRepository _repository;
  PersonalProfilePresenter(this._view) {
    _repository = Injector().PersonalProfileRepository;
  }
}
