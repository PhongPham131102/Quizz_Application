import '../../models/UserTopic.dart';

abstract class BattleTrainingRepository{
  Future<List<UserTopic>> GetAll();
}