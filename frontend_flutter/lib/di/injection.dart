import 'package:frontend_flutter/repository/battle_training/get_battle_training.dart';
import 'package:frontend_flutter/repository/detail_battle_traning/get_detail_battle_traning.dart';
import 'package:frontend_flutter/repository/history_battle/get_history_battle.dart';
import 'package:frontend_flutter/repository/personal_profile/get_personal_profile.dart';
import 'package:frontend_flutter/repository/question_answer/get_question_answer.dart';
import 'package:frontend_flutter/repository/rank/get_rank.dart';
import 'package:frontend_flutter/repository/watch_questions/get_watch_questions.dart';
import '../repository/auth/get_auth.dart';
import '../repository/battle/get_battle.dart';
import '../repository/change_name/get_change_name.dart';
import '../repository/change_password/get_change_password.dart';
import '../repository/detail_history_battle/get_detail_history_battle.dart';
import '../repository/detail_item/get_detail_item.dart';
import '../repository/feedback/get_feedback.dart';
import '../repository/find_rival_and_ready/get_find_rival_and_ready.dart';
import '../repository/forgetpassword/email_input/get_email_input.dart';
import '../repository/forgetpassword/otp_input/get_otp_input.dart';
import '../repository/forgetpassword/password_input/get_password_input.dart';
import '../repository/home/get_home.dart';
import '../repository/login/get_logins.dart';
import '../repository/pick_character/get_pick_character.dart';
import '../repository/register/get_registers.dart';
import '../repository/register_login/get_register_login.dart';
import '../repository/result/get_result.dart';
import '../repository/set_name/get_set_name.dart';
import '../repository/setting_game/get_setting_game.dart';
import '../repository/store/get_store.dart';
import '../repository/topic_battle_selection/get_topic_battle_selection.dart';
import '../repository/users_bag/get_users_bag.dart';

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

  GetPasswordInputRepository get PassWordInputRepository {
    return new GetPasswordInputRepository();
  }

  GetPickCharacterRepository get PickCharacterRepository {
    return new GetPickCharacterRepository();
  }

  GetSetNameRepository get SetNameRepository {
    return new GetSetNameRepository();
  }

  GetHomeRepository get HomeRepository {
    return new GetHomeRepository();
  }

  GetSettingGameRepository get SettingGameRepository {
    return new GetSettingGameRepository();
  }

  GetFeedBackRepository get FeedBackRepository {
    return GetFeedBackRepository();
  }

  GetChangePasswordRepository get ChangePasswordRepository {
    return GetChangePasswordRepository();
  }

  // ignore: non_constant_identifier_names
  GetTopicBattleSelectionRepository get TopicBattleSelectionRepository {
    return GetTopicBattleSelectionRepository();
  }

  GetFindRivalAndReadyRepository get FindRivalAndReadyRepository {
    return GetFindRivalAndReadyRepository();
  }

  GetBattleRepository get BattleRepository {
    return GetBattleRepository();
  }

  GetResultRepository get ResultRepository {
    return GetResultRepository();
  }

  GetStoreRepository get StoreRepository {
    return GetStoreRepository();
  }

  GetDetailItemRepository get DetailItemRepository {
    return GetDetailItemRepository();
  }

  GetUsersBagRepository get UsersBagRepository {
    return GetUsersBagRepository();
  }

  GetChangeNameRepository get ChangeNameRepository {
    return GetChangeNameRepository();
  }

  GetWatchQuestionsRepository get WatchQuestionsRepository {
    return GetWatchQuestionsRepository();
  }

  GetHistoryBattleRepository get HistoryBattleRepository {
    return GetHistoryBattleRepository();
  }

  GetDetailHisoryBattleRepository get DetailHistoryBattleRepository {
    return GetDetailHisoryBattleRepository();
  }

  GetBattleTrainingRepository get BattletrainingRepository {
    return GetBattleTrainingRepository();
  }

  GetDetailBattleTrainingRepository get DetailBattleTrainingRepository {
    return GetDetailBattleTrainingRepository();
  }

  GetQuestionAnswerRepository get QuestionAnswerRepository {
    return GetQuestionAnswerRepository();
  }

  GetPersonalProfileRepository get PersonalProfileRepository {
    return GetPersonalProfileRepository();
  }
  GetRankRepository get RankRepository{
    return GetRankRepository();
  }
}
