import 'package:front_end_teacher/repository/home/get_home.dart';
import 'package:front_end_teacher/repository/kahoot/get_kahoot.dart';
import '../repository/auth/get_auth.dart';
import '../repository/login/get_login.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();
   GetAuthRepository get contactRepository {
    return new GetAuthRepository();
  }GetLoginsRepository get loginRepository {
    return new GetLoginsRepository();
  }
  GetHomeREpository get HomeRepository{
    return new GetHomeREpository();
  }
  GetKahootRepository get KahootRepository
  {
    return new GetKahootRepository();
  }
}
