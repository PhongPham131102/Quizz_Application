import '../../models/Profile.dart';

abstract class HomeRepository
{
  Future<Profile> getProfile();
}