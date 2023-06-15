import '../../models/DetailUserMatch.dart';
import '../../models/UserTopic.dart';

abstract class PersonalProfileContract {
  setIsLoading(bool _isloading);
  setListUserTopic(List<UserTopic> _usertopics);
  setUserMatch(DetailUserMatch dt);
}
