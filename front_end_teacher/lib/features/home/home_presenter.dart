// ignore_for_file: unused_field

import 'package:front_end_teacher/di/injection.dart';
import 'package:front_end_teacher/repository/home/get_home_contract.dart';

import '../../models/Test.dart';
import 'home_contract.dart';

class HomePresenter{
  HomeContract _view;
  late HomeRepository _repository;
  HomePresenter(this._view)
  {
    _repository=Injector().HomeRepository;
  }
  GetListTest() async
  {
    _view.SetIsLoading(true);
    List<Test> tests=await _repository.getTests();
    _view.SetListTest(tests);
    _view.SetIsLoading(false);
  }
}