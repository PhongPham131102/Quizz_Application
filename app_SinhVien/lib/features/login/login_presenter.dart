import 'dart:convert';

import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/login/login_contract.dart';
import 'package:frontend_flutter/repository/login/get_logins_contract.dart';
import 'package:http/http.dart' as http;

import '../../models/Profile.dart';

class LoginPresenter {
  LoginContract _view;
  late LoginsRepository _repository;
  LoginPresenter(this._view) {
    _repository = Injector().loginRepository;
  }
  void login(String userName, String password) async {
    _view.setIsLoading(true);
    http.Response responseuser = await _repository.login(userName, password);
    _view.setIsLoading(false);
    if (responseuser.statusCode == 401) {
      _view.pushInfor("Email hoặc mật khẩu không đúng!");
    } else if (responseuser.statusCode == 200) {
      String token = jsonDecode(responseuser.body)['token'];
      String uid = jsonDecode(responseuser.body)['id'];
      _view.set_token(token);
      _view.set_uid(uid);
      _view.setIsLoading(true);
      Profile profile = await _repository.getProfile(token);
      _view.setIsLoading(false);
      if (profile.gender == "") {
        _view.pushPickCharacterScreen();
      } else if (profile.name == "") {
        _view.pushSetNameScreen();
      } else {
        await _view.settoken(token);
        await _view.setuid(uid);
        _view.pushHomeScreen();
      }
    } else {
      _view.pushInfor("Lỗi bất định vui lòng thử lại sau!");
    }
  }
}
