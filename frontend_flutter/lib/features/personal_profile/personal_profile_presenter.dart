// ignore_for_file: unused_field

import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/personal_profile/personal_profile_contract.dart';
import 'package:frontend_flutter/models/DetailUserMatch.dart';
import 'package:frontend_flutter/repository/personal_profile/get_personal_profile_contract.dart';

import '../../models/UserTopic.dart';

class PersonalProfilePresenter {
  PersonalProfileContract _view;
  late PersonalProfileRepository _repository;
  PersonalProfilePresenter(this._view) {
    _repository = Injector().PersonalProfileRepository;
  }
  Getall() async {
    List<UserTopic> usertopics = await _repository.GetAll();
    DetailUserMatch dt=await _repository.GetAllUserMatch();
    _view.setUserMatch(dt);
    _view.setListUserTopic(usertopics);
    _view.setIsLoading(false);
  }
}
