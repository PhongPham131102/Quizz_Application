import '../../models/Profile.dart';
import '../../models/UserTopic.dart';

abstract class RankContract {
  setIsLoading(bool _isloading);
  setListUserTopic(List<UserTopic> _usertopics);
  setListProfiles(List<Profile> _profiles);
  setTop10UserProfile(List<Profile> _profiles);
}
