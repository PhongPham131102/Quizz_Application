import 'package:flutter/material.dart';
import 'package:frontend_flutter/components/Button.dart';
import 'package:frontend_flutter/components/DialogMessage.dart';
import 'package:frontend_flutter/constants.dart';
import 'package:frontend_flutter/features/home/home_contract.dart';
import 'package:frontend_flutter/features/home/home_presenter.dart';
import 'package:frontend_flutter/features/rule/rule_view.dart';
import 'package:frontend_flutter/features/setting_game/setting_game_view.dart';
import 'package:frontend_flutter/models/Question.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/RobotLoading.dart';
import '../../models/Profile.dart';
import '../../sound_manager.dart';
import '../../spine_flutter.dart';
import '../kahoot/kahoot_view.dart';
import '../muster/muster_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with TickerProviderStateMixin
    implements HomeContract {
  late AnimationController _animationController;
  late AnimationController _animationScaleController;
  bool _isExpanded = false;
  late Profile profile = Profile(
      uid: "uid",
      gender: "male",
      gold: 0,
      diamond: 0,
      level: 1,
      name: "đang tải...",
      star: 1,
      exp: 1,
      medalId: "",
      shirt: "shirt",
      trouser: "trouser",
      shoe: "shoe",
      bag: "bag",
      id: "id",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());
  bool isLoading = true;
  late String animation;
  late SkeletonAnimation skeleton;
  bool isLoadingCharacter = false;
  @override
  updateProfile(Profile _profile) {
    profile = _profile;
    loadingCharacter();
    if (mounted) {
      setState(() {});
    }
  }
  @override
  OpenLevel(String level,String topicType) {
    GlobalSoundManager().playButton("open");
    DialogMessage(context, "Chúc mừng bạn đã mở khóa Level: ${level} Chủ đề : ${topicType.toUpperCase()}");
  }
    @override
 LevelUp(String level) {
  GlobalSoundManager().playButton("levelup");
    DialogMessage(context, "Chúc mừng bạn đã lên Level: ${level} ");
  }
  @override
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', '');
    prefs.setString('uid', '');
    token = "";
    uid = "";
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/Login',
      (route) => false,
    );
    // Navigator.pop(context);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => Login(),
    //     ));
    DialogMessage(context, "Tài Khoản đã được đăng nhập ở nơi khác.");
  }

  @override
  setIsLoading(bool _isLoading) {
    isLoading = _isLoading;
    setState(() {});
  }

  late AnimationController infoUserController;
  late Animation<double> infoUserAnimation;
  late AnimationController ButtonRankController;
  late Animation<double> ButtonRankAnimation;
  late AnimationController ButtonBattleTrainController;
  late Animation<double> ButtonBattleTrainAnimation;
  late AnimationController ButtonHistoryController;
  late Animation<double> ButtonHistoryAnimation;
  late AnimationController ButtonKahootController;
  late Animation<double> ButtonKahootAnimation;
  late AnimationController ButtonBelowController;
  late Animation<double> ButtonBelowAnimation;
  late Animation<double> ButtonBelowOpacityAnimation;
  late AnimationController ButtonRuleController;
  late Animation<double> ButtonRuleAnimation;
  late AnimationController ButtonPodiumController;
  late Animation<double> ButtonPodiumAnimation;
  late AnimationController ButtonMoneyController;
  late Animation<double> ButtonMoneyAnimation;
  CreateAnimationController() {
    infoUserController = AnimationController(
      duration: Duration(milliseconds: 400),
      vsync: this,
    );
    infoUserAnimation = Tween(begin: 3.0, end: 1.0).animate(
      CurvedAnimation(
        parent: infoUserController,
        curve: Curves.bounceOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          ButtonRankController.forward();
          ButtonBattleTrainController.forward();
          ButtonHistoryController.forward();
          ButtonKahootController.forward();
          ButtonBelowController.forward();
          ButtonMoneyController.forward();
          ButtonRuleController.forward();
          ButtonPodiumController.forward();
        }
      });
    ButtonRankController = AnimationController(
        duration: Duration(milliseconds: 1000), vsync: this);
    ButtonRankAnimation = Tween(begin: -1000.0, end: 0.0).animate(
        CurvedAnimation(
            parent: ButtonRankController, curve: Curves.easeInOutBack))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {}
      });
    ButtonBattleTrainController = AnimationController(
        duration: Duration(milliseconds: 1500), vsync: this);
    ButtonBattleTrainAnimation = Tween(begin: -1500.0, end: 0.0).animate(
        CurvedAnimation(
            parent: ButtonBattleTrainController, curve: Curves.easeInOutBack))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {}
      });
    ButtonHistoryController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    ButtonHistoryAnimation = Tween(begin: -1600.0, end: 0.0).animate(
        CurvedAnimation(
            parent: ButtonHistoryController, curve: Curves.easeInOutBack))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {}
      });
    ButtonKahootController = AnimationController(
        duration: Duration(milliseconds: 2500), vsync: this);
    ButtonKahootAnimation = Tween(begin: -1700.0, end: 0.0).animate(
        CurvedAnimation(
            parent: ButtonKahootController, curve: Curves.easeInOutBack))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {}
      });
    ButtonBelowController = AnimationController(
        duration: Duration(milliseconds: 2000), vsync: this);
    ButtonBelowAnimation = Tween(begin: 1000.0, end: 0.0).animate(
        CurvedAnimation(
            parent: ButtonBelowController, curve: Curves.easeInOutBack))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {}
      });
    ButtonBelowOpacityAnimation = Tween(begin: 0.1, end: 1.0).animate(
        CurvedAnimation(parent: ButtonBelowController, curve: Curves.easeInOut))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {}
      });
    ButtonRuleController = AnimationController(
        duration: Duration(milliseconds: 1800), vsync: this);
    ButtonRuleAnimation = Tween(begin: -500.0, end: 0.0).animate(
        CurvedAnimation(
            parent: ButtonRuleController, curve: Curves.easeInOutBack))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {}
      });
    ButtonPodiumController = AnimationController(
        duration: Duration(milliseconds: 1800), vsync: this);
    ButtonPodiumAnimation = Tween(begin: 500.0, end: 0.0).animate(
        CurvedAnimation(
            parent: ButtonPodiumController, curve: Curves.easeInOutBack))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {}
      });
    ButtonMoneyController = AnimationController(
        duration: Duration(milliseconds: 1800), vsync: this);
    ButtonMoneyAnimation = Tween(begin: -500.0, end: 0.0).animate(
        CurvedAnimation(
            parent: ButtonMoneyController, curve: Curves.easeInOutBack))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {}
      });
  }

  @override
  void initState() {
    _presenter.getsocket();
    _presenter.getinfo();
    CreateAnimationController();
    infoUserController.forward();
    _animationController = AnimationController(
      duration:
          const Duration(milliseconds: 1000), // Thời gian animation (1 giây)
      vsync: this,
    );

    // Bắt đầu animation
    _animationController.repeat(
        reverse: true); // Lặp lại và đảo ngược khi hoàn thành
    _animationScaleController = AnimationController(
      vsync: this,
      duration: Duration(
          milliseconds: 500), // Điều chỉnh thời gian phóng to và thu nhỏ
    );

    _animationScaleController.addListener(() {
      if (_animationScaleController.status == AnimationStatus.completed ||
          _animationScaleController.status == AnimationStatus.dismissed) {
        _toggleSize();
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _toggleSize();
    });
    setState(() {});
    super.initState();
  }

  @override
  void dispose() {
    _presenter.dispose();
    _animationController.dispose();
    _animationScaleController.dispose();
    super.dispose();
  }

  void _toggleSize() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationScaleController.forward();
      } else {
        _animationScaleController.reverse();
      }
    });
  }

  @override
  pushBattle(Profile rival, String idRoom, String topic,
      List<Question> questions, int rivalScore, int yourScore) {
    Navigator.pushNamed(context, '/TopicBattleSelection', arguments: [profile]);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => TopicBattleSelectionView(
    //         profile: profile,
    //       ),
    //     ));
    Navigator.pushNamed(context, '/Battle', arguments: [
      profile,
      rival,
      idRoom,
      topic,
      questions,
      rivalScore,
      yourScore,
    ]);
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) => BattleView(
    //               you: profile,
    //               rival: rival,
    //               idRoom: idRoom,
    //               topic: topic,
    //               questions: questions,
    //               rivalScore: rivalScore,
    //               yourScore: yourScore,
    //             )));
  }

  late HomePresenter _presenter;
  _HomeViewState() {
    _presenter = HomePresenter(this);
  }

  loadingCharacter() async {
    animation =
        "${profile.shirt}_${profile.trouser}_${profile.shoe}_${profile.bag}";
    isLoadingCharacter = false;
    setState(() {});
    skeleton = await SkeletonAnimation.createWithFiles("${profile.gender}",
        pathBase: "assets/img/character/");
    skeleton.state.setAnimation(0, animation, true);
    isLoadingCharacter = true;
    setState(() {});
  }

  Widget _buildCharacter() {
    return SkeletonRenderObjectWidget(
      skeleton: skeleton,
      alignment: Alignment.center,
      fit: BoxFit.fitHeight,
      playState: PlayState.playing,
      debugRendering: false,
      triangleRendering: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: _width,
          height: _height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/maingame/mainbg.jpg"),
                fit: BoxFit.fill),
          ),
          child: !isLoading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedBuilder(
                        animation: ButtonMoneyController,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(ButtonMoneyAnimation.value, 0),
                            child: Container(
                              margin: EdgeInsets.only(top: _height / 35),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: _width / 2.8,
                                          height: _height / 15,
                                        ),
                                        Positioned(
                                          top: _height / 80,
                                          bottom: _height / 80,
                                          right: 0,
                                          child: Container(
                                            width: _width / 3,
                                            height: _height / 50,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/img/maingame/buttoncoin.png"),
                                                    fit: BoxFit.fill)),
                                            child: Text(
                                              formatMoney(profile.gold),
                                              style: TextStyle(
                                                  fontFamily: 'Mitr',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: _height / 150,
                                          bottom: _height / 150,
                                          left: 0,
                                          child: AnimatedBuilder(
                                              animation: _animationController,
                                              builder: (context, child) {
                                                double scale = 1.0;

                                                if (_animationController
                                                        .value <=
                                                    0.5) {
                                                  scale = 1.0 -
                                                      (_animationController
                                                              .value *
                                                          0.05); // Từ 1.0 xuống 0.95
                                                } else if (_animationController
                                                        .value <=
                                                    0.7) {
                                                  scale = 0.95 +
                                                      ((_animationController
                                                                  .value -
                                                              0.25) *
                                                          0.06); // Từ 0.95 lên 0.98
                                                } else if (_animationController
                                                        .value <=
                                                    0.85) {
                                                  scale = 0.98 -
                                                      ((_animationController
                                                                  .value -
                                                              0.5) *
                                                          0.06); // Từ 0.98 xuống 0.95
                                                } else if (_animationController
                                                        .value <=
                                                    1) {
                                                  scale = 0.95 +
                                                      ((_animationController
                                                                  .value -
                                                              0.75) *
                                                          0.05); // Từ 0.95 lên 1.0
                                                }
                                                return Transform.scale(
                                                  scale: scale,
                                                  child: Container(
                                                    width: _width / 8,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                "assets/img/maingame/gold.gif"),
                                                            fit: BoxFit.fill)),
                                                  ),
                                                );
                                              }),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: _width / 2.8,
                                          height: _height / 15,
                                        ),
                                        Positioned(
                                          top: _height / 80,
                                          bottom: _height / 80,
                                          right: 0,
                                          child: Container(
                                            width: _width / 3,
                                            height: _height / 50,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/img/maingame/buttoncoin.png"),
                                                    fit: BoxFit.fill)),
                                            child: Text(
                                              formatMoney(profile.diamond),
                                              style: TextStyle(
                                                  fontFamily: 'Mitr',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w800,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: _height / 100,
                                          bottom: _height / 100,
                                          left: 0,
                                          child: AnimatedBuilder(
                                              animation: _animationController,
                                              builder: (context, child) {
                                                double scale = 1.0;

                                                if (_animationController
                                                        .value <=
                                                    0.5) {
                                                  scale = 1.0 -
                                                      (_animationController
                                                              .value *
                                                          0.05); // Từ 1.0 xuống 0.95
                                                } else if (_animationController
                                                        .value <=
                                                    0.7) {
                                                  scale = 0.95 +
                                                      ((_animationController
                                                                  .value -
                                                              0.25) *
                                                          0.06); // Từ 0.95 lên 0.98
                                                } else if (_animationController
                                                        .value <=
                                                    0.85) {
                                                  scale = 0.98 -
                                                      ((_animationController
                                                                  .value -
                                                              0.5) *
                                                          0.06); // Từ 0.98 xuống 0.95
                                                } else if (_animationController
                                                        .value <=
                                                    1) {
                                                  scale = 0.95 +
                                                      ((_animationController
                                                                  .value -
                                                              0.75) *
                                                          0.05); // Từ 0.95 lên 1.0
                                                }
                                                return Transform.scale(
                                                  scale: scale,
                                                  child: Container(
                                                    width: _width / 9,
                                                    decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                            image: AssetImage(
                                                                "assets/img/maingame/diamond.gif"),
                                                            fit: BoxFit.fill)),
                                                  ),
                                                );
                                              }),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                    Container(
                      margin: EdgeInsets.only(top: _height / 50),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AnimatedBuilder(
                                    animation: ButtonRuleController,
                                    builder: (context, child) {
                                      return Transform.translate(
                                        offset: Offset(
                                            ButtonRuleAnimation.value, 0),
                                        child: ButtonCustom(
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    RuleView());
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: _width / 5.5,
                                                height: _height / 10,
                                              ),
                                              Positioned(
                                                  left: _width / 80,
                                                  right: _width / 80,
                                                  child: Image.asset(
                                                    "assets/img/maingame/ruleicon.png",
                                                    width: _width / 10,
                                                    height: _height / 12,
                                                  )),
                                              Positioned(
                                                  bottom: _height / 150,
                                                  left: 0,
                                                  right: 0,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          // Implement the stroke
                                                          Text(
                                                            'Luật Chơi',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Mitr',
                                                              fontSize: 12,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              foreground:
                                                                  Paint()
                                                                    ..style =
                                                                        PaintingStyle
                                                                            .stroke
                                                                    ..strokeWidth =
                                                                        2.5
                                                                    ..color =
                                                                        Colors
                                                                            .black,
                                                            ),
                                                          ),
                                                          // The text inside
                                                          const Text(
                                                            'Luật Chơi',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Mitr',
                                                              fontSize: 12,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      251,
                                                                      247,
                                                                      207),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ),
                                      );
                                    })

                                // Stack(
                                //   children: [
                                //     Container(
                                //       width: _width / 5.5,
                                //       height: _height / 10,
                                //     ),
                                //     Positioned(
                                //         left: _width / 80,
                                //         right: _width / 80,
                                //         child: Image.asset(
                                //           "assets/img/maingame/mustericon.png",
                                //           width: _width / 10,
                                //           height: _height / 12,
                                //         )),
                                //     Positioned(
                                //         bottom: _height / 150,
                                //         left: 0,
                                //         right: 0,
                                //         child: Row(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.center,
                                //           children: [
                                //             StrokeText(
                                //                 text: "Điểm danh",
                                //                 fontSize: 12,
                                //                 fontWeight: FontWeight.w900,
                                //                 color: Colors.white,
                                //                 strokeColor: Colors.black,
                                //                 strokeWidth: 0.5),
                                //           ],
                                //         ))
                                //   ],
                                // )
                              ],
                            ),
                          ),
                          AnimatedBuilder(
                              animation: infoUserController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: infoUserAnimation.value,
                                  child: Container(
                                    width: _width / 1.8,
                                    height: _height / 2.25,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ButtonCustom(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, "/PersonalProfile",
                                                arguments: [profile, true]);
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             PersonalProfileView(
                                            //               profile: profile,
                                            //               you: true,
                                            //             )));
                                          },
                                          child: Container(
                                            width: _width / 2 - 50,
                                            height: _height / 3.5,
                                            child: isLoadingCharacter
                                                ? _buildCharacter()
                                                : Container(),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          profile.name,
                                          style: TextStyle(
                                              fontFamily: 'Mitr',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                              fontStyle: FontStyle.italic,
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      35,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        255, 149, 45, 7),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      35,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            100,
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            100),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              2.1,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    202,
                                                                    59,
                                                                    7),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      35,
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            100,
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            100),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          width: percentExp(
                                                              MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  2.1,
                                                              profile.level,
                                                              profile.exp),
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              50,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    48,
                                                                    222,
                                                                    9),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      35,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Stack(
                                                        children: [
                                                          Text(
                                                            "Cấp ${profile.level} : ",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Mitr',
                                                              fontSize: 11,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              foreground:
                                                                  Paint()
                                                                    ..style =
                                                                        PaintingStyle
                                                                            .stroke
                                                                    ..strokeWidth =
                                                                        2
                                                                    ..color =
                                                                        Colors
                                                                            .black,
                                                            ),
                                                          ),
                                                          Text(
                                                            "Cấp ${profile.level} : ",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Mitr',
                                                              fontSize: 11,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Stack(
                                                        children: [
                                                          Text(
                                                            "${profile.exp}/${expNeed(profile.level)}",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Mitr',
                                                              fontSize: 11,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              foreground:
                                                                  Paint()
                                                                    ..style =
                                                                        PaintingStyle
                                                                            .stroke
                                                                    ..strokeWidth =
                                                                        2
                                                                    ..color =
                                                                        Colors
                                                                            .black,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${profile.exp}/${expNeed(profile.level)}",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Mitr',
                                                              fontSize: 11,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      2.8,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      20,
                                                ),
                                                Positioned(
                                                  top: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      150,
                                                  bottom: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      150,
                                                  right: 0,
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      20,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            15,
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            40),
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: Color.fromARGB(
                                                          255, 68, 148, 165),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40.0),
                                                    ),
                                                    child: FittedBox(
                                                      fit: BoxFit.scaleDown,
                                                      child: Stack(
                                                        children: [
                                                          Text(
                                                            "${getStarLevel(profile.star)[0].toUpperCase()}${getStarLevel(profile.star).substring(1)}",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Mitr',
                                                              fontSize: 14,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              foreground:
                                                                  Paint()
                                                                    ..style =
                                                                        PaintingStyle
                                                                            .stroke
                                                                    ..strokeWidth =
                                                                        1.5
                                                                    ..color =
                                                                        Colors
                                                                            .black,
                                                            ),
                                                          ),
                                                          Text(
                                                            "${getStarLevel(profile.star)[0].toUpperCase()}${getStarLevel(profile.star).substring(1)}",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Mitr',
                                                              fontSize: 14,
                                                              letterSpacing: 0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                    top: 0,
                                                    bottom: 0,
                                                    left: 0,
                                                    child: Image.asset(
                                                      "assets/img/home/${getStarLevel(profile.star)}.gif",
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              8,
                                                      fit: BoxFit.fill,
                                                    ))
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Stack(
                                                  children: [
                                                    Text(
                                                      "x${getRemainingStars(profile.star)}",
                                                      style: TextStyle(
                                                        fontFamily: 'Mitr',
                                                        fontSize: 18,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        foreground: Paint()
                                                          ..style =
                                                              PaintingStyle
                                                                  .stroke
                                                          ..strokeWidth = 1.5
                                                          ..color =
                                                              Colors.black,
                                                      ),
                                                    ),
                                                    Text(
                                                      "x${getRemainingStars(profile.star)}",
                                                      style: TextStyle(
                                                        fontFamily: 'Mitr',
                                                        fontSize: 18,
                                                        letterSpacing: 0,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Image.asset(
                                                    "assets/img/battletraining/starwin.gif",
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            15,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            15,
                                                    fit: BoxFit.fill,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AnimatedBuilder(
                                    animation: ButtonPodiumController,
                                    builder: (context, child) {
                                      return Transform.translate(
                                        offset: Offset(
                                            ButtonPodiumAnimation.value, 0),
                                        child: ButtonCustom(
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, '/Rank');
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (context) =>
                                            //             RankView()));
                                          },
                                          child: Stack(
                                            children: [
                                              Container(
                                                width: _width / 5.5,
                                                height: _height / 10,
                                              ),
                                              Positioned(
                                                  left: _width / 80,
                                                  right: _width / 80,
                                                  child: Image.asset(
                                                    "assets/img/maingame/cup.png",
                                                    width: _width / 10,
                                                    height: _height / 12,
                                                  )),
                                              Positioned(
                                                  bottom: _height / 150,
                                                  left: 0,
                                                  right: 5,
                                                  child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Stack(
                                                          children: [
                                                            // Implement the stroke
                                                            Text(
                                                              'B.Xếp Hạng',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Mitr',
                                                                fontSize: 12,
                                                                letterSpacing:
                                                                    0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                foreground:
                                                                    Paint()
                                                                      ..style =
                                                                          PaintingStyle
                                                                              .stroke
                                                                      ..strokeWidth =
                                                                          2.5
                                                                      ..color =
                                                                          Colors
                                                                              .black,
                                                              ),
                                                            ),
                                                            // The text inside
                                                            const Text(
                                                              'B.Xếp Hạng',
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    'Mitr',
                                                                fontSize: 12,
                                                                letterSpacing:
                                                                    0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        251,
                                                                        247,
                                                                        207),
                                                              ),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ))
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                // Stack(
                                //   children: [
                                //     Container(
                                //       width: _width / 5.5,
                                //       height: _height / 10,
                                //     ),
                                //     Positioned(
                                //         left: _width / 80,
                                //         right: _width / 80,
                                //         child: Image.asset(
                                //           "assets/img/maingame/mustericon.png",
                                //           width: _width / 10,
                                //           height: _height / 12,
                                //         )),
                                //     Positioned(
                                //         bottom: _height / 150,
                                //         left: 0,
                                //         right: 0,
                                //         child: Row(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.center,
                                //           children: [
                                //             StrokeText(
                                //                 text: "Điểm danh",
                                //                 fontSize: 13,
                                //                 fontWeight: FontWeight.w900,
                                //                 color: Colors.white,
                                //                 strokeColor: Colors.black,
                                //                 strokeWidth: 0.5),
                                //           ],
                                //         ))
                                //   ],
                                // )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          AnimatedBuilder(
                              animation: ButtonRankController,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(0, ButtonRankAnimation.value),
                                  child: ButtonCustom(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/TopicBattleSelection',
                                          arguments: [profile]);
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           TopicBattleSelectionView(
                                      //         profile: profile,
                                      //       ),
                                      //     ));
                                    },
                                    child: AnimatedBuilder(
                                        animation: _animationController,
                                        builder: (context, child) {
                                          final scale =
                                              _animationController.value *
                                                      0.02 +
                                                  1.0;
                                          return Transform.scale(
                                            scale: scale,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: _width / 1.9,
                                              height: _height / 13,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/img/maingame/button.png"),
                                                fit: BoxFit.fill,
                                              )),
                                              child: Text(
                                                "Đấu Hạng",
                                                style: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                );
                              }),
                          AnimatedBuilder(
                              animation: ButtonBattleTrainController,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: Offset(
                                      0, ButtonBattleTrainAnimation.value),
                                  child: ButtonCustom(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/BattleTraining');
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             BattleTrainingView()));
                                    },
                                    child: AnimatedBuilder(
                                        animation: _animationController,
                                        builder: (context, child) {
                                          final scale =
                                              _animationController.value *
                                                      0.02 +
                                                  1.0;
                                          return Transform.scale(
                                            scale: scale,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: _width / 1.9,
                                              height: _height / 13,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/img/maingame/button.png"),
                                                fit: BoxFit.fill,
                                              )),
                                              child: Text(
                                                "Đấu Luyện",
                                                style: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                );
                              }),
                          AnimatedBuilder(
                              animation: ButtonHistoryController,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset:
                                      Offset(0, ButtonHistoryAnimation.value),
                                  child: ButtonCustom(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/HistoryBattle',
                                          arguments: [profile]);
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             HistoryBattleView(
                                      //               profile: profile,
                                      //             )));
                                    },
                                    child: AnimatedBuilder(
                                        animation: _animationController,
                                        builder: (context, child) {
                                          final scale =
                                              _animationController.value *
                                                      0.02 +
                                                  1.0;
                                          return Transform.scale(
                                            scale: scale,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: _width / 1.9,
                                              height: _height / 13,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/img/maingame/button.png"),
                                                fit: BoxFit.fill,
                                              )),
                                              child: Text(
                                                "Lịch Sử Đấu",
                                                style: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                );
                              }),
                          AnimatedBuilder(
                              animation: ButtonKahootController,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset:
                                      Offset(0, ButtonKahootAnimation.value),
                                  child: ButtonCustom(
                                    onTap: () {
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=>KahootView()));
                                    },
                                    child: AnimatedBuilder(
                                        animation: _animationController,
                                        builder: (context, child) {
                                          final scale =
                                              _animationController.value *
                                                      0.02 +
                                                  1.0;
                                          return Transform.scale(
                                            scale: scale,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: _width / 1.9,
                                              height: _height / 13,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/img/maingame/button.png"),
                                                fit: BoxFit.fill,
                                              )),
                                              child: Text(
                                                "Kahoot",
                                                style: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                );
                              }),
                        ],
                      ),
                    ),
                    Transform.translate(
                      offset: Offset(0, ButtonBelowAnimation.value),
                      child: Opacity(
                        opacity: ButtonBelowOpacityAnimation.value,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ButtonCustom(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => MusterView());
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: _width / 5.5,
                                    height: _height / 10,
                                  ),
                                  Positioned(
                                      left: _width / 80,
                                      right: _width / 80,
                                      child: Image.asset(
                                        "assets/img/maingame/mustericon.png",
                                        width: _width / 10,
                                        height: _height / 12,
                                      )),
                                  Positioned(
                                      bottom: _height / 150,
                                      left: 0,
                                      right: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              // Implement the stroke
                                              Text(
                                                'Điểm Danh',
                                                style: TextStyle(
                                                  fontFamily: 'Mitr',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.bold,
                                                  foreground: Paint()
                                                    ..style =
                                                        PaintingStyle.stroke
                                                    ..strokeWidth = 2.5
                                                    ..color = Colors.black,
                                                ),
                                              ),
                                              // The text inside
                                              const Text(
                                                'Điểm Danh',
                                                style: TextStyle(
                                                  fontFamily: 'Mitr',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 251, 247, 207),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            ButtonCustom(
                              onTap: () {
                                Profile temp = profile.clone();
                                Navigator.pushNamed(context, '/Store',
                                    arguments: [temp]);
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => StoreView(
                                //         userProfile: temp,
                                //       ),
                                //     ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: _width / 5.5,
                                    height: _height / 10,
                                  ),
                                  Positioned(
                                      left: _width / 80,
                                      right: _width / 80,
                                      child: Image.asset(
                                        "assets/img/maingame/shopicon.png",
                                        width: _width / 10,
                                        height: _height / 12,
                                      )),
                                  Positioned(
                                      bottom: _height / 150,
                                      left: 0,
                                      right: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              // Implement the stroke
                                              Text(
                                                'Cửa Hàng',
                                                style: TextStyle(
                                                  fontFamily: 'Mitr',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.bold,
                                                  foreground: Paint()
                                                    ..style =
                                                        PaintingStyle.stroke
                                                    ..strokeWidth = 2.5
                                                    ..color = Colors.black,
                                                ),
                                              ),
                                              // The text inside
                                              const Text(
                                                'Cửa Hàng',
                                                style: TextStyle(
                                                  fontFamily: 'Mitr',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 251, 247, 207),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            ButtonCustom(
                              onTap: () {
                                Profile temp = profile.clone();
                                Navigator.pushNamed(context, '/UserBag',
                                    arguments: [temp]);
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) => UsersBagView(
                                //         userProfile: temp,
                                //       ),
                                //     ));
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: _width / 5.5,
                                    height: _height / 10,
                                  ),
                                  Positioned(
                                      left: _width / 80,
                                      right: _width / 80,
                                      child: Image.asset(
                                        "assets/img/maingame/bagicon.png",
                                        width: _width / 10,
                                        height: _height / 12,
                                      )),
                                  Positioned(
                                      bottom: _height / 150,
                                      left: 0,
                                      right: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              // Implement the stroke
                                              Text(
                                                'Túi Đồ',
                                                style: TextStyle(
                                                  fontFamily: 'Mitr',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.bold,
                                                  foreground: Paint()
                                                    ..style =
                                                        PaintingStyle.stroke
                                                    ..strokeWidth = 2.5
                                                    ..color = Colors.black,
                                                ),
                                              ),
                                              // The text inside
                                              const Text(
                                                'Túi Đồ',
                                                style: TextStyle(
                                                  fontFamily: 'Mitr',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 251, 247, 207),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            ButtonCustom(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) => SettingGameView());
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    width: _width / 5.5,
                                    height: _height / 10,
                                  ),
                                  Positioned(
                                      left: _width / 80,
                                      right: _width / 80,
                                      child: Image.asset(
                                        "assets/img/maingame/settingicon.png",
                                        width: _width / 10,
                                        height: _height / 12,
                                      )),
                                  Positioned(
                                      bottom: _height / 150,
                                      left: 0,
                                      right: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Stack(
                                            children: [
                                              // Implement the stroke
                                              Text(
                                                'Cài Đặt',
                                                style: TextStyle(
                                                  fontFamily: 'Mitr',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.bold,
                                                  foreground: Paint()
                                                    ..style =
                                                        PaintingStyle.stroke
                                                    ..strokeWidth = 2.5
                                                    ..color = Colors.black,
                                                ),
                                              ),
                                              // The text inside
                                              const Text(
                                                'Cài Đặt',
                                                style: TextStyle(
                                                  fontFamily: 'Mitr',
                                                  fontSize: 12,
                                                  letterSpacing: 0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 251, 247, 207),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : Center(
                  child: RobotLoading(),
                ),
        ));
  }
}
