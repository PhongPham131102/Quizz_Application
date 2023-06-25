import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/forgetpassword/otp_input/otp_input_contract.dart';

import '../../../repository/forgetpassword/otp_input/get_otp_input_contract.dart';

class OTPInputPresenter {
  OTPInputContract _view;
  // ignore: unused_field
  late OTPInputRepository _repository;
  OTPInputPresenter(this._view) {
    _repository = Injector().OTPInputRepository;
  }
  void handleInput(String initOTP, String value, int index,
      List<TextEditingController> controllers) {
    print(initOTP);
    // Chuyển đến ô tiếp theo khi đã nhập
    if (value.isNotEmpty && index < 3) {
      _view.setFocusNodes(index + 1);
    } // Chuyển về ô phía trước khi xóa
    else if (value.isEmpty && index > 0) {
      _view.setFocusNodes(index - 1);
    }
    // Kiểm tra mã OTP khi đã nhập đủ 4 ô
    if (index == 3 && value.isNotEmpty) {
      String otp =
          '${controllers[0].text}${controllers[1].text}${controllers[2].text}$value';
      if (otp == initOTP) {
        _view.setOTPCheck("");
        _view.pushFillPassWordScreen();
      } else {
        _view.setOTPCheck("Mã OTP không đúng");
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

  ReSendOtp(String email) async {
    _view.showSnackbar('Mã OTP mới đã được gửi đến mail $email');
    String otp = generateOTP();
    _view.setOtp(otp);
    await _repository.SendMail(email, otp);
  }

  Redirect(String initOTP, List<TextEditingController> controllers) {
    String otp =
        '${controllers[0].text}${controllers[1].text}${controllers[2].text}${controllers[2].text}';
    if (otp == initOTP) {
      _view.setOTPCheck("");
      _view.pushFillPassWordScreen();
    } else {
      _view.setOTPCheck("Mã OTP không đúng");
    }
  }
}
