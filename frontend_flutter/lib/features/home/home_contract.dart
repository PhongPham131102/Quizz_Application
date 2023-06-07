import '../../models/Profile.dart';
import '../../models/Question.dart';

abstract class HomeContract {
  setIsLoading(bool _isLoading);
  updateProfile(Profile _profile);
  pushBattle(Profile rival, String idRoom, String topic, List<Question> questions,int rivalScore,int yourScore);
}
