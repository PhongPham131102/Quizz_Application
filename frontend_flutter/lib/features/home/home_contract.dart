

import '../../models/Profile.dart';

abstract class HomeContract {
  setIsLoading(bool _isLoading);
  updateProfile(Profile _profile);
}
