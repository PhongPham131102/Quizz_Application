import '../../models/Level.dart';
import '../../models/UserLevel.dart';

abstract class DetailBattleTrainingRepository
{
  Future<List<UserLevel>> getAllUserLevel(String topicType);
    Future<List<Level>> getAllLevel(String topicType);
}