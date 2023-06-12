import '../models/Level.dart';
import '../models/UserLevel.dart';

abstract class DetailBattleTrainingContract {
  setIsLoading(bool _isloading);
  setListLevel(List<Level> _listlevels);
  setListUserLevel(List<UserLevel> _listuserlevels);
}
