import '../../models/Muster.dart';

abstract class MusterRepository{
  Future<List<Muster>> GetAll();
  CreateMuster(int gold,int exp,int diamond);
}