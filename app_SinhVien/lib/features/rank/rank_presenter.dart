// ignore_for_file: unused_field

import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/rank/rank_contract.dart';
import 'package:frontend_flutter/models/Profile.dart';
import 'package:frontend_flutter/repository/rank/get_rank_contract.dart';

import '../../models/UserTopic.dart';

class RankPresenter {
  RankContract _view;
  late RankRepository _repository;
  RankPresenter(this._view) {
    _repository = Injector().RankRepository;
  }
  Getall() async {
    final data = await _repository.GetAll();
    final usertopic = data['userstopics'] as List<dynamic>;
    final usertopics = List<UserTopic>.from(
        usertopic.map((topic) => UserTopic.fromJson(topic)));
    final userProfile = data['profiles'] as List<dynamic>;
    final userProfiles =
        List<Profile>.from(userProfile.map((u) => Profile.fromJson(u)));
    final Top10userProfiles = await _repository.GetAllTop10Profile();
    _view.setTop10UserProfile(Top10userProfiles);
    _view.setListProfiles(userProfiles);
    _view.setListUserTopic(usertopics);
    _view.setIsLoading(false);
  }
}
