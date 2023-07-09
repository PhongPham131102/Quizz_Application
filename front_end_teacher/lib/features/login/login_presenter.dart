import 'dart:convert';
import 'package:front_end_teacher/models/User.dart';
import 'package:http/http.dart' as http;

import '../../di/injection.dart';
import '../../repository/login/get_login_contract.dart';
import 'login_contract.dart';

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
      if(User.fromJson(jsonDecode(responseuser.body)["user"]).isTeacher )
      {
             String token = jsonDecode(responseuser.body)['token'];
      String uid = jsonDecode(responseuser.body)['id'];
      await _view.settoken(token);
      await _view.setuid(uid);
      _view.pushHomeScreen();
      }
     else {
      _view.pushInfor("Bạn chưa được cấp quyền đăng nhập giáo viên.");
    }
    } else {
      _view.pushInfor("Lỗi bất định vui lòng thử lại sau!");
    }
  }
}
