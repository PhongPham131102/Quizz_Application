import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/change_name/change_name_contract.dart';
import 'package:frontend_flutter/repository/change_name/get_change_name_contract.dart';

class ChangeNamePresenter {
  ChangeNameContract _view;
  late ChangeNameRepository _repository;
  ChangeNamePresenter(this._view) {
    _repository = Injector().ChangeNameRepository;
  }
  void SetName(String name,String idItem) async {
    if (name.length == 0) {
      _view.setvalidateName("Bạn chưa nhập tên nhân vật.");
    } else if (name.length > 15) {
      _view.setvalidateName("Tên nhân vật quá dài.");
    } else {
      _view.setvalidateName("");
      _view.setisloading(true);

      bool isUpdated = await _repository.changeName(name,idItem);
      _view.setisloading(false);
      if (isUpdated) {
        _view.updateNameSucces();
      } else {
        _view.showDialog("Lỗi Sever vui lòng thử lại sau.");
      }
    }
  }
}
