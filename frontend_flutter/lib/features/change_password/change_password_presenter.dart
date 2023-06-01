import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/change_password/change_password_contract.dart';
import 'package:frontend_flutter/repository/change_password/get_change_password_contract.dart';

class ChangePassWordPresenter {
  ChangePassWordContract _view;
  late ChangePasswordRepository _repository;
  ChangePassWordPresenter(this._view) {
    _repository = Injector().ChangePasswordRepository;
  }
  ValidateAndChangePassWord(
      String currentPassword, String password, String cfPassword) async {
    if (password.length < 8) {
      _view.SetvalidatePassword("Mật khẩu phải hơn 8 ký tự");
    } else {
      _view.SetvalidatePassword("");
      if (cfPassword != password) {
        _view.SetvalidateConfirmPassword("Mật khẩu không khớp");
      } else {
        _view.SetvalidateConfirmPassword("");
        _view.Setisloading(true);
        bool check =
            await _repository.changePassword(currentPassword, password);
        _view.Setisloading(false);
        if (check) {
          _view.ShowDialogMessageSuccess();
        } else {
          _view.SetvalidateCurrentPassword("Mật khẩu không đúng");
          Future.delayed(Duration(seconds: 5), () {
            _view.SetvalidateCurrentPassword("M");
          });
        }
      }
    }
  }
}
