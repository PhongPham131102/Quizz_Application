import 'package:frontend_flutter/repository/feedback/get_feedback.dart';
import 'package:frontend_flutter/repository/feedback/get_feedback_contract.dart';
import 'package:frontend_flutter/repository/forgetpassword/email_input/get_email_input.dart';
import 'package:frontend_flutter/repository/forgetpassword/email_input/get_email_input_contract.dart';
import 'package:frontend_flutter/repository/forgetpassword/otp_input/get_otp_input.dart';
import 'package:frontend_flutter/repository/forgetpassword/otp_input/get_otp_input_contract.dart';
import 'package:frontend_flutter/repository/forgetpassword/password_input/get_password_input.dart';
import 'package:frontend_flutter/repository/forgetpassword/password_input/get_password_input_contract.dart';
import 'package:frontend_flutter/repository/home/get_home.dart';
import 'package:frontend_flutter/repository/home/get_home_contract.dart';
import 'package:frontend_flutter/repository/login/get_logins.dart';
import 'package:frontend_flutter/repository/pick_character/get_pick_character.dart';
import 'package:frontend_flutter/repository/pick_character/get_pick_character_contract.dart';
import 'package:frontend_flutter/repository/register/get_registers.dart';
import 'package:frontend_flutter/repository/register_login/get_register_login.dart';
import 'package:frontend_flutter/repository/register_login/get_register_login_contract.dart';
import 'package:frontend_flutter/repository/set_name/get_set_name.dart';
import 'package:frontend_flutter/repository/set_name/get_set_name_contract.dart';
import 'package:frontend_flutter/repository/setting_game/get_setting_game.dart';

import '../repository/auth/get_auth.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }

  Injector._internal();
  GetAuthRepository get contactRepository {
    return new GetAuthRepository();
  }

  GetRegistersRepository get registerRepository {
    return new GetRegistersRepository();
  }

  GetLoginsRepository get loginRepository {
    return new GetLoginsRepository();
  }

  GetEmailInputRepository get EmailInputRepository {
    return new GetEmailInputRepository();
  }

  GetOTPInputRepository get OTPInputRepository {
    return new GetOTPInputRepository();
  }

  GetRegisterLoginRepository get RegisterLoginRepository {
    return new GetRegisterLoginRepository();
  }
  GetPasswordInputRepository get PassWordInputRepository
  {
    return new GetPasswordInputRepository();
  }
  GetPickCharacterRepository get PickCharacterRepository{
    return new GetPickCharacterRepository();
  }
  GetSetNameRepository get SetNameRepository
  {
    return new GetSetNameRepository();
  }
  GetHomeRepository get HomeRepository{
    return new GetHomeRepository();
  }
  GetSettingGameRepository get SettingGameRepository{
    return new GetSettingGameRepository();
  }
  GetFeedBackRepository get FeedBackRepository{
    return GetFeedBackRepository();
  }
}
