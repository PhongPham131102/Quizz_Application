import '../../models/Profile.dart';

abstract class RankRepository{
  Future<Map<String, dynamic>> GetAll();
  Future<List<Profile>> GetAllTop10Profile();
}