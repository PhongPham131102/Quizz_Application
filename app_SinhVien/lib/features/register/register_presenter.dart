import 'package:frontend_flutter/di/injection.dart';
import 'package:frontend_flutter/features/register/register_contract.dart';
import 'package:frontend_flutter/repository/register/get_registers_contract.dart';

class RegisterPresenter {
  RegisterContract _view;
  late RegistersRepository _repository;
  RegisterPresenter(this._view) {
    _repository = new Injector().registerRepository;
  }
  void register(String fullName, String email, String password) async {
    _view.setIsLoading(true);
    int statusCode = await _repository.register(fullName, email, password);
    _view.setIsLoading(false);
    if (statusCode == 400) {
      _view.setValidateEmail("Email đã tồn tại");
      Future.delayed(Duration(seconds: 3), () {
        _view.setValidateEmail("");
      });
    } else if (statusCode == 201) {
      _view.pushLogin();
      _view.pushInfor("Đăng ký thành công.");
    } else {
      _view.pushInfor("Mất kết nối với máy chủ vui lòng thử lại sau.");
    }
  }
}
