// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_flutter/features/battle/battle_view.dart';
import 'package:frontend_flutter/features/battle_training/battle_training_view.dart';
import 'package:frontend_flutter/features/change_name/change_name_view.dart';
import 'package:frontend_flutter/features/change_password/change_password_view.dart';
import 'package:frontend_flutter/features/detail_history_battle/detail_history_battle_view.dart';
import 'package:frontend_flutter/features/detail_item/detail_item_view.dart';
import 'package:frontend_flutter/features/feedback/feedback_view.dart';
import 'package:frontend_flutter/features/find_rival_and_ready/find_rival_and_ready_view.dart';
import 'package:frontend_flutter/features/home/home_view.dart';
import 'package:frontend_flutter/features/login/login_view.dart';
import 'package:frontend_flutter/features/personal_information/personal_information_view.dart';
import 'package:frontend_flutter/features/personal_profile/personal_profile_view.dart';
import 'package:frontend_flutter/features/pick_character/pick_character_view.dart';
import 'package:frontend_flutter/features/question_answer/question_answer_view.dart';
import 'package:frontend_flutter/features/rank/rank_view.dart';
import 'package:frontend_flutter/features/result/result_view.dart';
import 'package:frontend_flutter/features/rule/rule_view.dart';
import 'package:frontend_flutter/features/setting_game/setting_game_view.dart';
import 'package:frontend_flutter/features/store/store_view.dart';
import 'package:frontend_flutter/features/topic_battle_selection/topic_battle_selection_view.dart';
import 'package:frontend_flutter/features/users_bag/users_bag_view.dart';
import 'package:frontend_flutter/features/watch_questions/watch_questions_view.dart';
import 'package:frontend_flutter/models/Profile.dart';
import 'package:frontend_flutter/models/Question.dart';

import '../../models/Item.dart';
import '../../models/Match.dart';
import '../../models/UserTopic.dart';
import '../../sound_manager.dart';
import '../detail_battle_traning/detail_battle_traning_view.dart';
import '../forgetpassword/email_input/email_input_view.dart';
import '../forgetpassword/otp_input/otp_input_view.dart';
import '../forgetpassword/password_input/password_input_view.dart';
import '../history_battle/history_battle_view.dart';
import '../muster/muster_view.dart';
import '../register/register_view.dart';
import '../register_login/register_login_view.dart';
import '../set_name/set_name_view.dart';
import 'auth_contract.dart';
import 'auth_presenter.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView>
    with TickerProviderStateMixin
    implements AuthContract {
  late AnimationController _animationController;
  late AnimationController _animationRotateController;
  late Animation<double> _animation;
  late AuthPresenter _presenter;
  @override
  void dispose() {
    _animationController.dispose();
    _animationRotateController.dispose();
    super.dispose();
  }

  int isLoading = 0;
  _AuthViewState() {
    _presenter = AuthPresenter(this);
  }
  String textLoading = "Đang tải";
  @override
  void setLoadingBar(double begin, double end, String _textLoading) async {
    textLoading = _textLoading;
    setState(() {});
    await Future.delayed(Duration(seconds: 1), () {
      _animation = Tween<double>(
        begin: begin,
        end: end,
      ).animate(_animationController);
      _animationController.reset();
      _animationController.forward();

      setState(() {});
    }).then((value) {
      if (end == 1) {
        _presenter.checkToken();
      }
    });
  }

  @override
  void initState() {
    GlobalSoundManager().playBackgroundMusic("home");
    _animationRotateController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 0.1,
    ).animate(_animationController);

    _animationController.repeat();
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _presenter.loadingImage(context, _animationController, _animation);
    super.didChangeDependencies();
  }

  @override
  void setIsLoading(int _isLoading) {
    setState(() {
      isLoading = _isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          //màn hình đăng ký đăng nhập
          case '/LoginRegister':
            return MaterialPageRoute(builder: (context) => RegisterLogin());
          //màn hình đăng nhập
          case '/Login':
            return MaterialPageRoute(builder: (context) => Login());
          //màn hình đăng ký
          case '/Register':
            return MaterialPageRoute(builder: (context) => Register());
          //màn hình quên mật khẩu điền email
          case '/EmailInput':
            return MaterialPageRoute(builder: (context) => EmailImputView());
          //màn hình quên mật khẩu điền mã otp
          case '/OtpInput':
            final List<dynamic> arguments = settings.arguments as List<dynamic>;
            String otp = arguments[0] as String;
            String email = arguments[1] as String;
            return MaterialPageRoute(
                builder: (context) => OTPInput(otp: otp, email: email));
          //màn hình quên mật khẩu điền mật khẩu mới
          case '/PassWordInput':
            final List<dynamic> arguments = settings.arguments as List<dynamic>;
            String email = arguments[0] as String;
            return MaterialPageRoute(
                builder: (context) => PasswordInput(email: email));
          //màn hình chọn nhân vật
          case '/PickCharacter':
            final List<dynamic> arguments = settings.arguments as List<dynamic>;
            String token = arguments[0] as String;
            String uid = arguments[1] as String;
            return MaterialPageRoute(
                builder: (context) =>
                    PickCharacterView(token: token, uid: uid));
          //màn hình đặt tên nhân vật
          case '/SetName':
            final List<dynamic> arguments = settings.arguments as List<dynamic>;
            String token = arguments[0] as String;
            String uid = arguments[1] as String;
            return MaterialPageRoute(
                builder: (context) => SetNameView(token: token, uid: uid));
          //màn hình chính trò chơi
          case '/Home':
            return MaterialPageRoute(builder: (context) => HomeView());
          //màn hình luật chơi
          case '/Rule':
            return MaterialPageRoute(builder: (context) => RuleView());
          //màn hình bảng xếp hạng
          case '/Rank':
            return MaterialPageRoute(builder: (context) => RankView());
          //màn hình điểm danh
          case '/Muster':
            return MaterialPageRoute(builder: (context) => MusterView());
          //màn hình cửa hàng
          case '/Store':
            final List<dynamic> arguments = settings.arguments as List<dynamic>;
            Profile userProfile = arguments[0] as Profile;
            return MaterialPageRoute(
                builder: (context) => StoreView(userProfile: userProfile));
          //màn hình chi tiết vật phẩm
          case '/DetailItem':
            final List<dynamic> arguments = settings.arguments as List<dynamic>;
            Profile userProfile = arguments[0] as Profile;
            Item item = arguments[1] as Item;
            return MaterialPageRoute(
                builder: (context) =>
                    DetailItemView(userProfile: userProfile, item: item));
          //màn hình túi đồ
          case '/UserBag':
            final List<dynamic> arguments = settings.arguments as List<dynamic>;
            Profile userProfile = arguments[0] as Profile;
            return MaterialPageRoute(
                builder: (context) => UsersBagView(userProfile: userProfile));
          //màn hình cài đặt
          case '/Setting':
            return MaterialPageRoute(builder: (context) => SettingGameView());
          //màn hình thay đổi tên nhân vật
          case '/ChangeName':
            final List<dynamic> arguments = settings.arguments as List<dynamic>;
            String idItem = arguments[0] as String;
            return MaterialPageRoute(
                builder: (context) => ChangeNameView(idItem: idItem));
          //màn hình xem bộ câu hỏi
          case "/WatchQuestion":
            final List<dynamic> arguments = settings.arguments as List<dynamic>;
            List<Question> questions = arguments[0] as List<Question>;
            return MaterialPageRoute(
                builder: (context) => WatchQuestionsView(questions: questions));
          //màn hình trả lời các câu hỏi ở chế độ đấu luyện
          case "/QuestionAnswer":
            final List<dynamic> arguments = settings.arguments as List<dynamic>;
            UserTopic userTopic = arguments[0] as UserTopic;
            int level = arguments[1] as int;
            String topicsType = arguments[2] as String;
            return MaterialPageRoute(
                builder: (context) => QuestionAnswerView(
                    userTopic: userTopic,
                    level: level,
                    topicsType: topicsType));
          //màn hình xem thông tin nhân vật
          case "/PersonalProfile":
            final List<dynamic> arguments = settings.arguments as List<dynamic>;
            Profile profile = arguments[0] as Profile;
            bool you = arguments[1] as bool;
            return MaterialPageRoute(
                builder: (context) =>
                    PersonalProfileView(profile: profile, you: you));
          //màn hình xem thông tin cá nhân
          case "/PersonalInformation":
            return MaterialPageRoute(
                builder: (context) => PersonalInformationView());
          //màn hình thay đổi mật khẩu
          case "/ChangePassword":
            return MaterialPageRoute(
                builder: (context) => ChangePassWordView());
          //màn hình chọn chế độ ngôn ngữ chơi đấu luyện
          case "/BattleTraining":
            return MaterialPageRoute(
                builder: (context) => BattleTrainingView());
          //màn hình chọn chế độ ngôn ngữ chơi đấu luyện
          case "/BattleTraining":
            return MaterialPageRoute(
                builder: (context) => BattleTrainingView());
          //màn hình chọn cấp độ trong chi tiết chế độ ngôn ngữ chơi đấu luyện
          case "/DetailBattleTraining":
            final List<dynamic> arguments = settings.arguments as List<dynamic>;
            UserTopic userTopic = arguments[0] as UserTopic;
            return MaterialPageRoute(
                builder: (context) =>
                    DetailBattleTrainingView(userTopic: userTopic));
          //màn hình xem lịch sử đấu
          case "/HistoryBattle":
            final List<dynamic> arguments = settings.arguments as List<dynamic>;
            Profile profile = arguments[0] as Profile;
            return MaterialPageRoute(
                builder: (context) => HistoryBattleView(profile: profile));
          //màn hình xem chi tiết lịch sử đấu
          case "/DetailHistoryBattle":
            final List<dynamic> arguments = settings.arguments as List<dynamic>;
            MatchBattle match = arguments[0] as MatchBattle;
            Profile profile = arguments[1] as Profile;
            return MaterialPageRoute(
                builder: (context) =>
                    DetailHistoryBattleView(match: match, profile: profile));
          //màn hình gửi feedback
          case "/FeedBack":
            return MaterialPageRoute(builder: (context) => FeedBackView());
          //màn hình gửi feedback
          case "/Result":
            final List<dynamic> arguments = settings.arguments as List<dynamic>;
            MatchBattle match = arguments[0] as MatchBattle;
            Profile you = arguments[1] as Profile;
            Profile rival = arguments[2] as Profile;
            String topic = arguments[3] as String;
            return MaterialPageRoute(
                builder: (context) => ReSultView(
                    match: match, you: you, rival: rival, topic: topic));
          //màn hình tìm kiếm đối thủ và sẵn sàng
          case "/FindRivalAndReady":
            final List<dynamic> arguments = settings.arguments as List<dynamic>;
            Profile profile = arguments[0] as Profile;
            String topic = arguments[1] as String;
            return MaterialPageRoute(
                builder: (context) =>
                    FindRivalAndReadyView(profile: profile, topic: topic));
          //màn hình tìm kiếm đối thủ và sẵn sàng
          case "/FindRivalAndReady":
            final List<dynamic> arguments = settings.arguments as List<dynamic>;
            Profile profile = arguments[0] as Profile;
            String topic = arguments[1] as String;
            return MaterialPageRoute(
                builder: (context) =>
                    FindRivalAndReadyView(profile: profile, topic: topic));
          //màn hình chọn chủ đề chế độ đối kháng
          case "/TopicBattleSelection":
            final List<dynamic> arguments = settings.arguments as List<dynamic>;
            Profile profile = arguments[0] as Profile;
            return MaterialPageRoute(
                builder: (context) =>
                    TopicBattleSelectionView(profile: profile));
          //màn hình chơi đối kháng
          case "/Battle":
            final List<dynamic> arguments = settings.arguments as List<dynamic>;
            Profile you = arguments[0] as Profile;
            Profile rival = arguments[1] as Profile;
            String idRoom = arguments[2] as String;
            String topic = arguments[3] as String;
            List<Question>? questions = arguments[4] as List<Question>?;
            int? rivalScore = arguments[5] as int?;
            int? yourScore = arguments[6] as int?;
            return MaterialPageRoute(
              builder: (context) => BattleView(
                you: you,
                rival: rival,
                idRoom: idRoom,
                topic: topic,
                questions: questions,
                rivalScore: rivalScore,
                yourScore: yourScore,
              ),
            );
        }
        return null;
      },
      debugShowCheckedModeBanner: false, //  xoá chữ "Debug"
      home: isLoading == 1
          ? HomeView()
          : (isLoading == 0
              ? Scaffold(
                  body: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              "assets/img/home/bg.png",
                            ),
                            fit: BoxFit.fill)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 80),
                          width: 280,
                          height: 120,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/img/home/logo.gif"),
                                  fit: BoxFit.fill)),
                        ),
                        Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                ),
                                Positioned(
                                  left: MediaQuery.of(context).size.width / 50,
                                  right: MediaQuery.of(context).size.width / 50,
                                  top: MediaQuery.of(context).size.height / 60,
                                  bottom:
                                      MediaQuery.of(context).size.height / 150,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    height:
                                        MediaQuery.of(context).size.height / 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xffB86403),
                                    ),
                                    child: AnimatedBuilder(
                                      animation: _animation,
                                      builder: (context, child) {
                                        return Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.2 *
                                                  _animation.value,
                                              height: (MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  30),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 25, 203, 9),
                                                    Color.fromARGB(
                                                        255, 146, 223, 23),
                                                    Color.fromARGB(
                                                        255, 2, 251, 26),
                                                  ],
                                                  stops: [0.0, 0.5, 1.0],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                AnimatedBuilder(
                                    animation: _animation,
                                    builder: (context, child) {
                                      return Positioned(
                                          top: 0,
                                          bottom: 0,
                                          right: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.2 -
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.2 *
                                                  _animation.value,
                                          child: RotationTransition(
                                            turns: Tween(
                                                    begin: -0.025, end: 0.025)
                                                .animate(
                                                    _animationRotateController),
                                            child: Image.asset(
                                              "assets/img/home/avtloading.png",
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                              fit: BoxFit.fill,
                                            ),
                                          ));
                                    })
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10,
                                  left: 30,
                                  right: 30,
                                  bottom:
                                      MediaQuery.of(context).size.height / 35),
                              child: Row(
                                children: [
                                  Text('$textLoading',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Mitr',
                                          color: Color(0xffFEDB10),
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w800)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : RegisterLogin()),
    );
  }
}
