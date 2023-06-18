// ignore_for_file: unused_field

import 'package:flutter/widgets.dart';

import '../../constants.dart';
import '../../di/injection.dart';
import '../../repository/auth/get_auth_contract.dart';
import 'auth_contract.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthPresenter {
  AuthContract _view;

  late AuthRepository _repository;

  AuthPresenter(this._view) {
    _repository = new Injector().contactRepository;
  }
  List<String> urlImageBattle = [
    "assets/img/battle/bg2.png",
    "assets/img/battle/bg2.jpg",
    "assets/img/battle/boardc++.png",
    "assets/img/battle/boardcss.png",
    "assets/img/battle/boardhtml.png",
    "assets/img/battle/boardques.png",
    "assets/img/battle/boardrule.png",
    "assets/img/battle/boardsql.png",
    "assets/img/battle/button.png",
    "assets/img/battle/cplusplus.png",
    "assets/img/battle/css.png",
    "assets/img/battle/female.png",
    "assets/img/battle/frameavt.png",
    "assets/img/battle/frameavtclose.png",
    "assets/img/battle/frameavtwin.png",
    "assets/img/battle/frametitle.png",
    "assets/img/battle/frameuser1.png",
    "assets/img/battle/frameuser2.png",
    "assets/img/battle/giaodau.png",
    "assets/img/battle/html.png",
    "assets/img/battle/lose.png",
    "assets/img/battle/male.png",
    "assets/img/battle/questiontitle.png",
    "assets/img/battle/return.png",
    "assets/img/battle/review.png",
    "assets/img/battle/robot.png",
    "assets/img/battle/shadow.png",
    "assets/img/battle/shadowques.png",
    "assets/img/battle/sql.png",
    "assets/img/battle/starlose.png",
    "assets/img/battle/starwin.png",
    "assets/img/battle/thunder.png",
    "assets/img/battle/thundermsg.png",
    "assets/img/battle/titleuser1.png",
    "assets/img/battle/titleuser2.png",
    "assets/img/battle/vs.png",
    "assets/img/battle/vs2.png",
    "assets/img/battle/win.png",
  ];
  List<String> urlImageBattleTraining = [
    "assets/img/battletraining/chome.gif",
    "assets/img/battletraining/csshome.gif",
    "assets/img/battletraining/htmlhome.gif",
    "assets/img/battletraining/sqlhome.gif",
    "assets/img/battletraining/topicbg.gif",
    "assets/img/battletraining/0star.png",
    "assets/img/battletraining/1star.png",
    "assets/img/battletraining/2star.png",
    "assets/img/battletraining/3star.png",
    "assets/img/battletraining/50.png",
    "assets/img/battletraining/alarm.png",
    "assets/img/battletraining/back.png",
    "assets/img/battletraining/bgquestion.png",
    "assets/img/battletraining/board.png",
    "assets/img/battletraining/board2.png",
    "assets/img/battletraining/cloud.png",
    "assets/img/battletraining/cloudtitle.png",
    "assets/img/battletraining/key.png",
    "assets/img/battletraining/levelbutton.png",
    "assets/img/battletraining/plustime.png",
    "assets/img/battletraining/scorex2.png",
    "assets/img/battletraining/special.png",
    "assets/img/battletraining/titlec++.png",
    "assets/img/battletraining/titlecss.png",
    "assets/img/battletraining/titlehtml.png",
    "assets/img/battletraining/titlesql.png",
    "assets/img/battletraining/titletopic.png",
    "assets/img/battletraining/topic.png",
    "assets/img/battletraining/topicc++.png",
    "assets/img/battletraining/topiccss.png",
    "assets/img/battletraining/topichtml.png",
    "assets/img/battletraining/topicsql.png",
    "assets/img/battletraining/x2score.png",
  ];
  List<String> urlImageCharacter = [
    "assets/img/character/female.png",
    "assets/img/character/male.png",
    "assets/img/character/selectedframe.png",
    "assets/img/character/unselectedframe.png",
    "assets/img/character/female/female.png",
    "assets/img/character/female/female2.png",
    "assets/img/character/female/female3.png",
    "assets/img/character/male/male.png",
    "assets/img/character/male/male2.png",
  ];
  List<String> urlImagehistorybattle = [
    "assets/img/historybattle/circle.png",
    "assets/img/historybattle/detailtitle.png",
    "assets/img/historybattle/flagc++.png",
    "assets/img/historybattle/flagcss.png",
    "assets/img/historybattle/flaghtml.png",
    "assets/img/historybattle/flagsql.png",
    "assets/img/historybattle/lichsudau.png",
    "assets/img/historybattle/lose.gif",
    "assets/img/historybattle/same.gif",
    "assets/img/historybattle/win.gif",
  ];
  List<String> urlImageHome = [
    "assets/img/home/1stlogo.png",
    "assets/img/home/2stlogo.png",
    "assets/img/home/3stlogo.png",
    "assets/img/home/bg.png",
    "assets/img/home/bgpersonalpage.png",
    "assets/img/home/button.png",
    "assets/img/home/changepassword.png",
    "assets/img/home/check.png",
    "assets/img/home/closebutton.png",
    "assets/img/home/cup.png",
    "assets/img/home/exp.png",
    "assets/img/home/feedback.png",
    "assets/img/home/forgetpassword.png",
    "assets/img/home/frame.png",
    "assets/img/home/frame1.png",
    "assets/img/home/frame2.png",
    "assets/img/home/fresher.png",
    "assets/img/home/intern.png",
    "assets/img/home/junior.png",
    "assets/img/home/loading.png",
    "assets/img/home/login.png",
    "assets/img/home/logo.gif",
    "assets/img/home/mid-level.png",
    "assets/img/home/muster.png",
    "assets/img/home/otpframe.png",
    "assets/img/home/personalinfo.png",
    "assets/img/home/pickcharacter.png",
    "assets/img/home/register.png",
    "assets/img/home/senior.png",
    "assets/img/home/st1.png",
    "assets/img/home/st2.png",
    "assets/img/home/st3.png",
    "assets/img/home/star.png",
    "assets/img/home/textbutton2.png",
  ];
  List<String> urlImageIconQuestion = [
    "assets/img/iconquestion/50.png",
    "assets/img/iconquestion/alarm.png",
    "assets/img/iconquestion/back.png",
    "assets/img/iconquestion/bgquestion.png",
    "assets/img/iconquestion/board.png",
    "assets/img/iconquestion/cloud.png",
    "assets/img/iconquestion/cloudtitle.png",
    "assets/img/iconquestion/plustime.png",
    "assets/img/iconquestion/scorex2.png",
    "assets/img/iconquestion/special.png",
    "assets/img/iconquestion/x2score.png",
  ];
  List<String> urlImageMainGame = [
    "assets/img/maingame/bagicon.png",
    "assets/img/maingame/button.png",
    "assets/img/maingame/buttoncoin.png",
    "assets/img/maingame/diamond.png",
    "assets/img/maingame/frame.png",
    "assets/img/maingame/mainbg.jpg",
    "assets/img/maingame/gold.png",
    "assets/img/maingame/male.png",
    "assets/img/maingame/mustericon.png",
    "assets/img/maingame/ruleicon.png",
    "assets/img/maingame/settingicon.png",
    "assets/img/maingame/shopicon.png",
  ];
  List<String> urlImageSetting = [
    "assets/img/setting/closebutton.png",
    "assets/img/setting/feedbackicon.png",
    "assets/img/setting/frame.png",
    "assets/img/setting/inforicon.png",
    "assets/img/setting/setting.png",
    "assets/img/setting/speakericon.png",
  ];
  List<String> urlImageStore = [
    "assets/img/store/baguser.png",
    "assets/img/store/blackskirt.png",
    "assets/img/store/blacktrouser.png",
    "assets/img/store/bluebag.png",
    "assets/img/store/blueshoes.png",
    "assets/img/store/bluetrouser.png",
    "assets/img/store/c.png",
    "assets/img/store/caothang.png",
    "assets/img/store/changename.png",
    "assets/img/store/closebutton.png",
    "assets/img/store/css.png",
    "assets/img/store/detail.png",
    "assets/img/store/down.png",
    "assets/img/store/greyshoes.png",
    "assets/img/store/html.png",
    "assets/img/store/it.png",
    "assets/img/store/lightblueskirt.png",
    "assets/img/store/lightbluetrouser.png",
    "assets/img/store/pinkshoes.png",
    "assets/img/store/pinkskirt.png",
    "assets/img/store/purplebag.png",
    "assets/img/store/return.png",
    "assets/img/store/shoptitle.png",
    "assets/img/store/sql.png",
    "assets/img/store/up.png",
    "assets/img/store/mainbgstore.jpg",
  ];
  void loadingImage(
      BuildContext context,
      AnimationController _animationController,
      Animation<double> _animation) async {
    _view.setLoadingBar(0.1, 0.2, "Đang tải dữ liệu trận đấu...");
    for (var image in urlImageBattle) {
      await precacheImage(Image.asset(image).image, context);
    }
    _view.setLoadingBar(0.2, 0.3, "Đang tải dữ liệu đấu luyện...");
    for (var image in urlImageBattleTraining) {
      await precacheImage(Image.asset(image).image, context);
    }
    _view.setLoadingBar(0.3, 0.4, "Đang tải dữ liệu nhân vật...");
    for (var image in urlImageCharacter) {
      await precacheImage(Image.asset(image).image, context);
    }

    for (var image in urlImagehistorybattle) {
      await precacheImage(Image.asset(image).image, context);
    }
    for (var image in urlImageHome) {
      await precacheImage(Image.asset(image).image, context);
    }
    for (var image in urlImageIconQuestion) {
      await precacheImage(Image.asset(image).image, context);
    }
    for (var image in urlImageMainGame) {
      await precacheImage(Image.asset(image).image, context);
    }
    for (var image in urlImageSetting) {
      await precacheImage(Image.asset(image).image, context);
    }
    _view.setLoadingBar(0.4,1, "Đang tải dữ liệu hình ảnh...");
    for (var image in urlImageStore) {
      await precacheImage(Image.asset(image).image, context);
    }
  }

  void checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    uid = prefs.getString('uid') ?? '';
    if (token!.isNotEmpty) {
      print(token);
      bool checkToken = await _repository.checkToken(token!);
      ;
      if (checkToken) {
        _view.setIsLoading(1);
      } else {
        resetTokenAndUid();
      }
    } else {
      resetTokenAndUid();
    }
  }

  resetTokenAndUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', '');
    prefs.setString('uid', '');
    _view.setIsLoading(2);
  }
}
