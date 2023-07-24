import 'package:front_end_teacher/models/Test.dart';

abstract class HomeRepository
{
   Future<List<Test>>  getTests();
}