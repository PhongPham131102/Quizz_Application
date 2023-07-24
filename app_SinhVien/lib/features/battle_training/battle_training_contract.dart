import '../../models/UserTopic.dart';

abstract class BattleTrainingContract{
  setIsLoading(bool _isloading);
  setListUserTopic(List<UserTopic> _usertopics);
  updateTopic(UserTopic _usertopic);
}