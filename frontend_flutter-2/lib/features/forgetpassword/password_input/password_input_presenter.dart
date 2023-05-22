import 'package:flutter/material.dart';
import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/forgetpassword/password_input/password_input_contract.dart';
import 'package:frontend_flutter/repository/forgetpassword/password_input/get_password_input_contract.dart';

class PasswordInputPresenter {
  PasswordInputContract _view;
  late PassWordInputRepository _repository;
  PasswordInputPresenter(this._view) {
    _repository = Injector().PassWordInputRepository;
  }
  void togglePasswordVisibility(bool passwordVisible) {
    _view.setpasswordVisible(!passwordVisible);
  }

  void toggleCfPasswordVisibility(bool CfpasswordVisible) {
    _view.setcFPasswordVisible(!CfpasswordVisible);
  }

  checkPasswordValidity(String value) {
    if (value == "") {
      _view.setvalidatePassWord("Bạn chưa nhập mật khẩu");
    } else if (value.length < 8) {
      _view.setvalidatePassWord("Mật khẩu phải dài hơn 8 ký tự");
    } else {
      _view.setvalidatePassWord("");
    }
  }

  checkCfPasswordValidity(String cfpassWord, String passWord) {
    if (cfpassWord != passWord) {
      _view.setvalidateCfPassWord("Mật khẩu không khớp");
    } else {
      _view.setvalidateCfPassWord("");
    }
  }

  void handleChangePassWord(String validatePassWord, String validateCfPassWord,
      String email, String password) async {
    if (validatePassWord == "" && validateCfPassWord == "") {
      // var password =
      //     passwordController.text.trim();
      _view.setisloading(true);
      bool response = await _repository.updatePassWord(email, password);
      true;
      _view.setisloading(false);
      if (response) {
        _view.showDialogMessage('Thay đổi mật khẩu thành công!', true);
      } else {
        _view.showDialogMessage(
            "Mất kết nối với máy chủ vui lòng thử lại sau.", false);
      }
    }
  }
}
