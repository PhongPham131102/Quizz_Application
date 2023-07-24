import 'package:frontend_flutter/di/injection.dart';
import 'package:intl/intl.dart';
import '../../models/Muster.dart';
import '../../repository/muster/get_muster_contract.dart';
import 'muster_contract.dart';

class MusterPresenter {
  MusterContract _view;
  late MusterRepository _repository;
  MusterPresenter(this._view) {
    _repository = Injector().MusterRepository;
  }
  GetAll() async {
    List<Muster> musters = await _repository.GetAll();
    List<String> musterList = [];
    for (var element in musters) {
      String dateString = DateFormat('yyyy-MM-dd').format(element.createdAt);
      musterList.add(dateString);
    }
    _view.setListMuster(musterList);
    _view.setIsLoading(false);
  }

  CreateMuster(String date, int gold, int exp, int diamond) {
    _view.setIsLoading(true);
    _repository.CreateMuster(gold, exp, diamond);
    _view.setIsLoading(false);
  }
}
