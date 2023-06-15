import '../../models/DetailUserMatch.dart';
import '../../models/UserTopic.dart';

abstract class PersonalProfileRepository{
    Future<List<UserTopic>> GetAll();
    Future<DetailUserMatch> GetAllUserMatch();
}