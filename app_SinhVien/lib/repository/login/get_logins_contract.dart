import 'package:http/http.dart' as http;

import '../../models/Profile.dart';

abstract class LoginsRepository {
  Future<http.Response> login(String userName, String password);
  Future<Profile> getProfile(String tokenn);
}
