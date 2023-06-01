import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/set_name/set_name_contract.dart';

import '../../repository/set_name/get_set_name_contract.dart';

class SetNamePresenter {
  SetNameContract _view;
  late SetNameRepository _repository;
  SetNamePresenter(this._view) {
    _repository = Injector().SetNameRepository;
  }
  void SetName(String token, String uid, String name) async {
    if (name.length == 0) {
      _view.setvalidateName("Bạn chưa nhập tên nhân vật.");
    } else if (name.length > 15) {
      _view.setvalidateName("Tên nhân vật quá dài.");
    } else {
      _view.setvalidateName("");
      _view.setisloading(true);

      bool isUpdated = await _repository.updateName(token, name);
      _view.setisloading(false);

      if (isUpdated) {
        _view.settoken(token);
        _view.setuid(uid);
       _view.pushHomeScreen();
      } else {
        _view.showDialog("Lỗi Sever vui lòng thử lại sau.");
      }
    }
  }
}
