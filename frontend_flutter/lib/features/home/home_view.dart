import 'package:flutter/material.dart';
import 'package:frontend_flutter/components/DialogMessage.dart';
import 'package:frontend_flutter/constants.dart';
import 'package:frontend_flutter/features/battle/battle_view.dart';
import 'package:frontend_flutter/features/history_battle/history_battle_view.dart';
import 'package:frontend_flutter/features/home/home_contract.dart';
import 'package:frontend_flutter/features/home/home_presenter.dart';
import 'package:frontend_flutter/features/personal_profile/personal_profile_view.dart';
import 'package:frontend_flutter/features/rank/rank_view.dart';
import 'package:frontend_flutter/features/rule/rule_view.dart';
import 'package:frontend_flutter/features/setting_game/setting_game_view.dart';
import 'package:frontend_flutter/features/store/store_view.dart';
import 'package:frontend_flutter/models/Question.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/Profile.dart';
import '../../spine_flutter.dart';
import '../battle_training/battle_training_view.dart';
import '../login/login_view.dart';
import '../muster/muster_view.dart';
import '../topic_battle_selection/topic_battle_selection_view.dart';
import '../users_bag/users_bag_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> implements HomeContract {
  late Profile profile;
  bool isLoading = true;
  late String animation;
  late SkeletonAnimation skeleton;
  bool isLoadingCharacter = false;
  @override
  updateProfile(Profile _profile) {
    profile = _profile;
    loadingCharacter();
    setState(() {});
  }

  @override
  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', '');
    prefs.setString('uid', '');
    token = "";
    uid = "";
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ));
    DialogMessage(context, "Tài Khoản đã được đăng nhập ở nơi khác.");
  }

  @override
  setIsLoading(bool _isLoading) {
    isLoading = _isLoading;
    setState(() {});
  }

  @override
  void initState() {
    _presenter.getsocket();
    _presenter.getinfo();
    super.initState();
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
  }

  @override
  pushBattle(Profile rival, String idRoom, String topic,
      List<Question> questions, int rivalScore, int yourScore) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TopicBattleSelectionView(
            profile: profile,
          ),
        ));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BattleView(
                  you: profile,
                  rival: rival,
                  idRoom: idRoom,
                  topic: topic,
                  questions: questions,
                  rivalScore: rivalScore,
                  yourScore: yourScore,
                )));
  }

  late HomePresenter _presenter;
  _HomeViewState() {
    _presenter = HomePresenter(this);
  }

  loadingCharacter() async {
    print(profile.shoe);
    animation = "${profile.shirt}_${profile.trouser}_pinkshoes_${profile.bag}";
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
      body: !isLoading
          ? Container(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img/maingame/mainbg.jpg"),
                    fit: BoxFit.fill),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
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
                                child: Container(
                                  width: _width / 8,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/img/maingame/gold.png"),
                                          fit: BoxFit.fill)),
                                ),
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
                                child: Container(
                                  width: _width / 9,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/img/maingame/diamond.png"),
                                          fit: BoxFit.fill)),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
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
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => RuleView());
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
                                              MainAxisAlignment.center,
                                          children: [
                                            StrokeText(
                                                text: "Luật chơi",
                                                fontSize: 13,
                                                fontWeight: FontWeight.w900,
                                                color: Colors.white,
                                                strokeColor: Colors.black,
                                                strokeWidth: 0.5),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
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
                        Container(
                          width: _width / 2,
                          height: _height / 2.3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PersonalProfileView(
                                                profile: profile,
                                                you: true,
                                              )));
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
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                35,
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 149, 45, 7),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                35,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  100,
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  100),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2.1,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    50,
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 202, 59, 7),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                35,
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  100,
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  100),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: percentExp(
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        2.1,
                                                    profile.level,
                                                    profile.exp),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    50,
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      255, 48, 222, 9),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                35,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Cấp ${profile.level} : ",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w800),
                                            ),
                                            Text(
                                              "${profile.exp}/${expNeed(profile.level)}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w800),
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
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.2,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                20,
                                      ),
                                      Positioned(
                                        top:
                                            MediaQuery.of(context).size.height /
                                                150,
                                        bottom:
                                            MediaQuery.of(context).size.height /
                                                150,
                                        right: 0,
                                        left:
                                            MediaQuery.of(context).size.width /
                                                20,
                                        child: Container(
                                            padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    15,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    40),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 68, 148, 165),
                                              borderRadius:
                                                  BorderRadius.circular(40.0),
                                            ),
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                "${getStarLevel(profile.star)[0].toUpperCase()}${getStarLevel(profile.star).substring(1)}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            )),
                                      ),
                                      Positioned(
                                          top: 2.5,
                                          bottom: 2.5,
                                          left: 0,
                                          child: Image.asset(
                                            "assets/img/home/${getStarLevel(profile.star)}.png",
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                8,
                                            fit: BoxFit.fill,
                                          ))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "x${getRemainingStars(profile.star)}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Image.asset(
                                          "assets/img/home/star.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                          height: MediaQuery.of(context)
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
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RankView()));
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
                                          "assets/img/home/cup.png",
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
                                                MainAxisAlignment.center,
                                            children: [
                                              StrokeText(
                                                  text: "B.Xếp Hạng",
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white,
                                                  strokeColor: Colors.black,
                                                  strokeWidth: 0.5),
                                            ],
                                          ),
                                        ))
                                  ],
                                ),
                              ),
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
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TopicBattleSelectionView(
                                    profile: profile,
                                  ),
                                ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: _width / 1.9,
                            height: _height / 13,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image:
                                  AssetImage("assets/img/maingame/button.png"),
                              fit: BoxFit.fill,
                            )),
                            child: Text(
                              "1 VS 1",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BattleTrainingView()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: _width / 1.9,
                            height: _height / 13,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image:
                                  AssetImage("assets/img/maingame/button.png"),
                              fit: BoxFit.fill,
                            )),
                            child: Text(
                              "Đấu Luyện",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HistoryBattleView(
                                          profile: profile,
                                        )));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: _width / 1.9,
                            height: _height / 13,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image:
                                  AssetImage("assets/img/maingame/button.png"),
                              fit: BoxFit.fill,
                            )),
                            child: Text(
                              "Lịch Sử Đấu",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            width: _width / 1.9,
                            height: _height / 13,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image:
                                  AssetImage("assets/img/maingame/button.png"),
                              fit: BoxFit.fill,
                            )),
                            child: Text(
                              "Khóa Học",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    StrokeText(
                                        text: "Điểm danh",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        strokeColor: Colors.black,
                                        strokeWidth: 0.5),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Profile temp = profile.clone();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StoreView(
                                  userProfile: temp,
                                ),
                              ));
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    StrokeText(
                                        text: "Cửa hàng",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        strokeColor: Colors.black,
                                        strokeWidth: 0.5),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Profile temp = profile.clone();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UsersBagView(
                                  userProfile: temp,
                                ),
                              ));
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    StrokeText(
                                        text: "Túi đồ",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        strokeColor: Colors.black,
                                        strokeWidth: 0.5),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      GestureDetector(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    StrokeText(
                                        text: "Cài đặt",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        strokeColor: Colors.black,
                                        strokeWidth: 0.5),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

// ignore: must_be_immutable
class StrokeText extends StatelessWidget {
  String text;
  double fontSize;
  FontWeight fontWeight;
  Color color;
  Color strokeColor;
  double strokeWidth;
  StrokeText({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    required this.strokeColor,
    required this.strokeWidth,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            foreground: Paint()..color = color,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            foreground: Paint()
              ..strokeWidth = strokeWidth
              ..color = strokeColor
              ..style = PaintingStyle.stroke,
          ),
        ),
      ],
    );
  }
}
