import '../../models/User.dart';

abstract class PersonalInformationRepository{
  Future<User> getUser();
}