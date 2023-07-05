import '../../models/DetailUserMatch.dart';
import '../../models/UserTopic.dart';

abstract class PersonalProfileRepository{
    Future<List<UserTopic>> GetAll(String uid);
    Future<DetailUserMatch> GetAllUserMatch(String uid);
}