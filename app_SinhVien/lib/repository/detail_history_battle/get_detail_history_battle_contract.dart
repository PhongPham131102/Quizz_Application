import '../../models/Profile.dart';

abstract class DetailHistoryBattleRepository{
  Future<Profile> getProfile(String uid);
}