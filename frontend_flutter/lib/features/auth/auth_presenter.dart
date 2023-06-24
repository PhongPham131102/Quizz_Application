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
    "assets/img/battle/boardc++.gif",
    "assets/img/battle/boardcss.gif",
    "assets/img/battle/boardhtml.gif",
    "assets/img/battle/boardques.png",
    "assets/img/battle/boardrule.png",
    "assets/img/battle/boardsql.gif",
    "assets/img/battle/button.png",
    "assets/img/battle/cplusplus.gif",
    "assets/img/battle/css.gif",
    "assets/img/battle/female.png",
    "assets/img/battle/frameavt.png",
    "assets/img/battle/frameavtclose.png",
    "assets/img/battle/frameavtwin.png",
    "assets/img/battle/frameuser1.png",
    "assets/img/battle/frameuser2.png",
    "assets/img/battle/giaodau.gif",
    "assets/img/battle/html.gif",
    "assets/img/battle/lose.png",
    "assets/img/battle/male.png",
    "assets/img/battle/questiontitle.gif",
    "assets/img/battle/return.png",
    "assets/img/battle/review.png",
    "assets/img/battle/robot.gif",
    "assets/img/battle/shadow.png",
    "assets/img/battle/shadowques.png",
    "assets/img/battle/sql.gif",
    "assets/img/battle/starlose.png",
    "assets/img/battle/starwin.png",
    "assets/img/battle/thunder.gif",
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
    "assets/img/battletraining/topic.gif",
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
    "assets/img/historybattle/detail.gif",
    "assets/img/historybattle/flagc++.png",
    "assets/img/historybattle/flagcss.png",
    "assets/img/historybattle/flaghtml.png",
    "assets/img/historybattle/flagsql.png",
    "assets/img/historybattle/lichsudau.gif",
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
    "assets/img/home/changepassword.gif",
    "assets/img/home/check.png",
    "assets/img/home/closebutton.png",
    "assets/img/home/exp.png",
    "assets/img/home/feedback.gif",
    "assets/img/home/forgetpassword.gif",
    "assets/img/home/frame.png",
    "assets/img/home/frame1.png",
    "assets/img/home/frame2.png",
    "assets/img/home/fresher.gif",
    "assets/img/home/intern.gif",
    "assets/img/home/junior.gif",
    "assets/img/home/login.gif",
    "assets/img/home/logo.gif",
    "assets/img/home/mid-level.gif",
    "assets/img/home/muster.gif",
    "assets/img/home/otpframe.png",
    "assets/img/home/personalinfo.gif",
    "assets/img/home/pickcharacter.gif",
    "assets/img/home/register.gif",
    "assets/img/home/senior.gif",
    "assets/img/home/st1.gif",
    "assets/img/home/st2.gif",
    "assets/img/home/st3.gif",
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
    "assets/img/maingame/diamond.gif",
    "assets/img/maingame/frame.png",
    "assets/img/maingame/mainbg.jpg",
    "assets/img/maingame/nhanvat.gif",
    "assets/img/maingame/gold.gif",
    "assets/img/maingame/male.png",
    "assets/img/maingame/mustericon.png",
    "assets/img/maingame/ruleicon.png",
    "assets/img/maingame/settingicon.png",
    "assets/img/maingame/shopicon.png",
    "assets/img/maingame/cup.png",
  ];
  List<String> urlImageSetting = [
    "assets/img/setting/closebutton.png",
    "assets/img/setting/feedbackicon.png",
    "assets/img/setting/frame.png",
    "assets/img/setting/inforicon.png",
    "assets/img/setting/setting.gif",
    "assets/img/setting/speakericon.png",
  ];
  List<String> urlImageStore = [
    "assets/img/store/baguser.gif",
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
    "assets/img/store/shoptitle.gif",
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
