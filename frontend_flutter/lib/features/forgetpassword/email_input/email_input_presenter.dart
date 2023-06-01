import 'dart:math';

import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/forgetpassword/email_input/email_input_contract.dart';
import 'package:frontend_flutter/repository/forgetpassword/email_input/get_email_input_contract.dart';

class EmailInputPresenter {
  EmailInputContract _view;
  late EmailInputRepository _repository;
  EmailInputPresenter(this._view) {
    _repository = Injector().EmailInputRepository;
  }
  checkvalidEmail(String email) {
    if (email == "") {
      _view.setEmailCheck("Bạn chưa nhập email");
    } else if (!RegExp(r'\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b').hasMatch(email)) {
      _view.setEmailCheck("Email không hợp lệ");
    } else {
      _view.setEmailCheck("");
    }
  }

  void checkEmail(String emailCheck, String email) async {
    if (emailCheck == "") {
      _view.setisLoading(true);
      bool checkMail = await _repository.checkMail(email);
      _view.setisLoading(false);
      if (checkMail) {
        _view.setisLoading(true);
        String otp = generateOTP();
        bool isSended = await _repository.SendMail(email, otp);
        _view.setisLoading(false);
        if (isSended) {
          _view.pushOTPInputScreen(otp);
          _view.showSnackbar('Mã OTP đã được gửi đến mail $email');
        } else {
          _view.showSnackbar('Lỗi hệ thống vui lòng thử lại sau');
        }
      } else {
        _view.setEmailCheck("Email không tồn tại");
        Future.delayed(Duration(seconds: 3), () {
          _view.setEmailCheck("");
        });
      }
    }
  }

  String generateOTP() {
    Random random = Random();
    String otp = "";
    for (int i = 0; i < 4; i++) {
      otp += random.nextInt(10).toString();
    }
    return otp;
  }
}
