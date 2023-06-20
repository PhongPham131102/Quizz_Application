import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:frontend_flutter/features/rank/rank_contract.dart';
import 'package:frontend_flutter/features/rank/rank_presenter.dart';
import 'package:frontend_flutter/models/Profile.dart';

import '../../components/Button.dart';
import '../../constants.dart';
import '../../models/UserTopic.dart';
import '../personal_profile/personal_profile_view.dart';

class RankView extends StatefulWidget {
  const RankView({super.key});

  @override
  State<RankView> createState() => _RankViewState();
}

class _RankViewState extends State<RankView>
    with SingleTickerProviderStateMixin
    implements RankContract {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isLoading = true;
  List<UserTopic> userTopics = [];
  List<UserTopic> filterUserTopics = [];
  List<Profile> profiles = [];
  List<Profile> Top10profiles = [];
  @override
  setTop10UserProfile(List<Profile> _profiles) {
    Top10profiles = _profiles;
    if (mounted) setState(() {});
  }

  @override
  setListProfiles(List<Profile> _profiles) {
    profiles.addAll(_profiles);
    if (mounted) {
      setState(() {});
    }
  }

  FitlerUserTopic() {
    filterUserTopics = [];
    for (var element in userTopics) {
      if (element.topicType == Language.toLowerCase()) {
        filterUserTopics.add(element);
      }
    }
    print(filterUserTopics.length);
    if (mounted) {
      setState(() {});
    }
  }

  late RankPresenter _presenter;
  bool isModeBattle = true;
  String Language = "C++";
  _RankViewState() {
    _presenter = RankPresenter(this);
  }
  @override
  setIsLoading(bool _isloading) {
    isLoading = _isloading;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setListUserTopic(List<UserTopic> _usertopics) {
    userTopics = _usertopics;
    FitlerUserTopic();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _presenter.Getall();
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 5).animate(_controller)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IgnorePointer(
        ignoring: isLoading,
        child: Container(
          padding: EdgeInsets.only(top: 15),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/battle/bg2.jpg"),
                  fit: BoxFit.fill)),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 10,
                    alignment: Alignment.center,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.height / 10,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/img/maingame/bangxephang.gif"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 20,
                    bottom: 20,
                    child: ButtonCustom(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/img/store/return.png"),
                                fit: BoxFit.fill)),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonCustom(
                    onTap: () {
                      isModeBattle = true;
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 2.05,
                      height: MediaQuery.of(context).size.height / 12,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/img/maingame/buttonbattle.png"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  ButtonCustom(
                    onTap: () {
                      isModeBattle = false;
                      setState(() {});
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width / 2.05,
                      height: MediaQuery.of(context).size.height / 12,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/img/maingame/buttonbattletraining.png"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                ],
              ),
              ColorFiltered(
                colorFilter: !isModeBattle ? transparentscale : greyscale,
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 25,
                      right: MediaQuery.of(context).size.width / 25),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 15,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      Row(
                        children: [
                          ButtonCustom(
                            onTap: () {
                              Language = "C++";
                              print(Language.toLowerCase());
                              FitlerUserTopic();
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width / 25),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: MediaQuery.of(context).size.height / 15,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battle/button.png"),
                                      fit: BoxFit.fill)),
                              child: Text(
                                "C++",
                                style: TextStyle(
                                    fontFamily: 'Mitr',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          ButtonCustom(
                            onTap: () {
                              Language = "SQL";
                              print(Language.toLowerCase());
                              FitlerUserTopic();
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width / 25),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: MediaQuery.of(context).size.height / 15,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battle/button.png"),
                                      fit: BoxFit.fill)),
                              child: Text(
                                "SQL",
                                style: TextStyle(
                                    fontFamily: 'Mitr',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          ButtonCustom(
                            onTap: () {
                              Language = "HTML";
                              print(Language.toLowerCase());
                              FitlerUserTopic();
                              setState(() {});
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width / 25),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: MediaQuery.of(context).size.height / 15,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battle/button.png"),
                                      fit: BoxFit.fill)),
                              child: Text(
                                "HTML",
                                style: TextStyle(
                                    fontFamily: 'Mitr',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          ButtonCustom(
                            onTap: () {
                              Language = "CSS";
                              print(Language.toLowerCase());
                              FitlerUserTopic();
                              setState(() {});
                            },
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.3,
                              height: MediaQuery.of(context).size.height / 15,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battle/button.png"),
                                      fit: BoxFit.fill)),
                              child: Text(
                                "CSS",
                                style: TextStyle(
                                    fontFamily: 'Mitr',
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              !isModeBattle
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "trượt sang phải để xem thêm BXH ngôn ngữ khác.",
                          style: TextStyle(
                              fontFamily: 'Mitr',
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              fontStyle: FontStyle.italic),
                        )
                      ],
                    )
                  : Container(),
              AnimatedBuilder(
                  animation: _animation,
                  builder: (context, child) {
                    final scale = _animation.value;
                    return Container(
                      padding: EdgeInsets.only(bottom: scale),
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/img/battle/boardques.png"),
                              fit: BoxFit.fill)),
                      child: !isLoading
                          ? Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 3,
                                  // child: Center(
                                  //   child: AnimatedTextKit(
                                  //     repeatForever: false,
                                  //     isRepeatingAnimation: false,
                                  //     animatedTexts: [
                                  //       TyperAnimatedText(
                                  //         'Chưa Có Người Chơi Nào.',
                                  //         textAlign: TextAlign.center,
                                  //         textStyle: TextStyle(
                                  //             color: Color.fromARGB(
                                  //                 255, 255, 255, 255),
                                  //             fontSize: 15,
                                  //             fontStyle: FontStyle.italic,
                                  //             fontWeight: FontWeight.w500),
                                  //       ),
                                  //     ],
                                  //   ),
                                  // ),
                                ),
                                Positioned(
                                    top:
                                        MediaQuery.of(context).size.height / 30,
                                    left:
                                        MediaQuery.of(context).size.width / 15,
                                    child: Column(
                                      children: [
                                        Text(
                                          "Chế độ:",
                                          style: TextStyle(
                                              fontFamily: 'Mitr',
                                              fontSize: 13,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        GlowText(
                                          isModeBattle
                                              ? "Đấu hạng"
                                              : "Đấu luyện",
                                          style: TextStyle(
                                              fontFamily: 'Mitr',
                                              fontStyle: FontStyle.italic,
                                              fontSize: 13,
                                              color: Color.fromARGB(
                                                  255, 243, 240, 38),
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                                Positioned(
                                    top:
                                        MediaQuery.of(context).size.height / 30,
                                    right:
                                        MediaQuery.of(context).size.width / 15,
                                    child: Column(
                                      children: [
                                        isModeBattle
                                            ? Container()
                                            : Text(
                                                "Ngôn ngữ:",
                                                style: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    fontSize: 13,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                        isModeBattle
                                            ? Container()
                                            : GlowText(
                                                Language,
                                                style: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 13,
                                                    color: Color.fromARGB(
                                                        255, 243, 240, 38),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                      ],
                                    )),
                                //1st
                                isModeBattle
                                    ? Top10profiles.length > 1
                                        ? Positioned(
                                            top: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    30 +
                                                scale -
                                                10,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    'assets/img/home/1stlogo.png',
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            10,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  Stack(
                                                    children: [
                                                      Positioned(
                                                        left: 5,
                                                        top: 2,
                                                        child: CircleAvatar(
                                                          foregroundColor:
                                                              Colors.red,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/img/battle/frameavtwin.png'),
                                                          radius: 45,
                                                        ),
                                                      ),
                                                      Image.asset(
                                                        'assets/img/home/st1.png',
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.fill,
                                                      ),
                                                      Positioned(
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            20,
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            20,
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            20,
                                                        bottom: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            20,
                                                        child: ButtonCustom(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            PersonalProfileView(
                                                                              profile: Top10profiles[0],
                                                                              you: true,
                                                                            )));
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        'assets/img/battle/${Top10profiles[0].gender}.png'))),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 80,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Text(
                                                      Top10profiles[0].name,
                                                      style: TextStyle(
                                                        fontFamily: 'Mitr',
                                                        color: Color.fromARGB(
                                                            255, 9, 15, 198),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            4,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            25,
                                                      ),
                                                      Positioned(
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            150,
                                                        bottom: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            150,
                                                        right: 0,
                                                        left: MediaQuery.of(
                                                                    context)
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
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      68,
                                                                      148,
                                                                      165),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40.0),
                                                            ),
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                              child: Text(
                                                                "${getStarLevel(Top10profiles[0].star)[0].toUpperCase()}${getStarLevel(Top10profiles[0].star).substring(1)}",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Mitr',
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            )),
                                                      ),
                                                      Positioned(
                                                          top: 2.5,
                                                          bottom: 2.5,
                                                          left: 0,
                                                          child: Image.asset(
                                                            "assets/img/home/${getStarLevel(Top10profiles[0].star)}.gif",
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                8,
                                                            fit: BoxFit.fill,
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container()
                                    : filterUserTopics.length > 1
                                        ? Positioned(
                                            top: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    30 +
                                                scale -
                                                10,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                3,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4.5,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    'assets/img/home/1stlogo.png',
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            10,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            25,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  Stack(
                                                    children: [
                                                      Positioned(
                                                        left: 5,
                                                        top: 2,
                                                        child: CircleAvatar(
                                                          foregroundColor:
                                                              Colors.red,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/img/battle/frameavtwin.png'),
                                                          radius: 45,
                                                        ),
                                                      ),
                                                      Image.asset(
                                                        'assets/img/home/st1.png',
                                                        width: 100,
                                                        height: 100,
                                                        fit: BoxFit.fill,
                                                      ),
                                                      Positioned(
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            20,
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            20,
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            20,
                                                        bottom: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            20,
                                                        child: ButtonCustom(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            PersonalProfileView(
                                                                              profile: profiles.where((element) => element.uid == filterUserTopics[0].uid).first,
                                                                              you: true,
                                                                            )));
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        'assets/img/battle/${profiles.where((element) => element.uid == filterUserTopics[0].uid).first.gender}.png'))),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 80,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Text(
                                                      profiles
                                                          .where((element) =>
                                                              element.uid ==
                                                              filterUserTopics[
                                                                      0]
                                                                  .uid)
                                                          .first
                                                          .name,
                                                      style: TextStyle(
                                                        fontFamily: 'Mitr',
                                                        color: Color.fromARGB(
                                                            255, 9, 15, 198),
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${filterUserTopics[0].totalScore} điểm',
                                                    style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      color: Color.fromARGB(
                                                          255, 213, 239, 13),
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(),

                                //3rd
                                isModeBattle
                                    ? Top10profiles.length > 2
                                        ? Positioned(
                                            top: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    9 +
                                                scale -
                                                10,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                20,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    'assets/img/home/3stlogo.png',
                                                    width: 25,
                                                    height: 20,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  Stack(
                                                    children: [
                                                      Positioned(
                                                        left: 12,
                                                        top: 2,
                                                        child: CircleAvatar(
                                                          foregroundColor:
                                                              Colors.red,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/img/battle/frameavtwin.png'),
                                                          radius: 38,
                                                        ),
                                                      ),
                                                      Image.asset(
                                                        'assets/img/home/st3.png',
                                                        width: 100,
                                                        height: 80,
                                                        fit: BoxFit.fill,
                                                      ),
                                                      Positioned(
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            30,
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            30,
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            30,
                                                        bottom: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            30,
                                                        child: ButtonCustom(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            PersonalProfileView(
                                                                              profile: Top10profiles[2],
                                                                              you: true,
                                                                            )));
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        'assets/img/battle/${Top10profiles[2].gender}.png'))),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 80,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Text(
                                                      Top10profiles[2].name,
                                                      style: TextStyle(
                                                        fontFamily: 'Mitr',
                                                        color: Color.fromARGB(
                                                            255, 9, 15, 198),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            4,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            25,
                                                      ),
                                                      Positioned(
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            150,
                                                        bottom: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            150,
                                                        right: 0,
                                                        left: MediaQuery.of(
                                                                    context)
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
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      68,
                                                                      148,
                                                                      165),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40.0),
                                                            ),
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                              child: Text(
                                                                "${getStarLevel(Top10profiles[2].star)[0].toUpperCase()}${getStarLevel(Top10profiles[2].star).substring(1)}",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Mitr',
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            )),
                                                      ),
                                                      Positioned(
                                                          top: 2.5,
                                                          bottom: 2.5,
                                                          left: 0,
                                                          child: Image.asset(
                                                            "assets/img/home/${getStarLevel(Top10profiles[2].star)}.gif",
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                8,
                                                            fit: BoxFit.fill,
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container()
                                    : filterUserTopics.length > 2
                                        ? Positioned(
                                            top: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    9 +
                                                scale -
                                                10,
                                            left: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                20,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3.5,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    'assets/img/home/3stlogo.png',
                                                    width: 25,
                                                    height: 20,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  Stack(
                                                    children: [
                                                      Positioned(
                                                        left: 12,
                                                        top: 2,
                                                        child: CircleAvatar(
                                                          foregroundColor:
                                                              Colors.red,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/img/battle/frameavtwin.png'),
                                                          radius: 38,
                                                        ),
                                                      ),
                                                      Image.asset(
                                                        'assets/img/home/st3.png',
                                                        width: 100,
                                                        height: 80,
                                                        fit: BoxFit.fill,
                                                      ),
                                                      Positioned(
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            30,
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            30,
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            30,
                                                        bottom: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            30,
                                                        child: ButtonCustom(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            PersonalProfileView(
                                                                              profile: profiles.where((element) => element.uid == filterUserTopics[2].uid).first,
                                                                              you: true,
                                                                            )));
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        'assets/img/battle/${profiles.where((element) => element.uid == filterUserTopics[2].uid).first.gender}.png'))),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 80,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Text(
                                                      profiles
                                                          .where((element) =>
                                                              element.uid ==
                                                              filterUserTopics[
                                                                      2]
                                                                  .uid)
                                                          .first
                                                          .name,
                                                      style: TextStyle(
                                                        fontFamily: 'Mitr',
                                                        color: Color.fromARGB(
                                                            255, 9, 15, 198),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${filterUserTopics[2].totalScore} điểm',
                                                    style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      color: Color.fromARGB(
                                                          255, 213, 239, 13),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container(),
                                //2nd
                                isModeBattle
                                    ? Top10profiles.length > 1
                                        ? Positioned(
                                            top: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    12 +
                                                scale -
                                                10,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                15,
                                            child: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4.5,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    'assets/img/home/2stlogo.png',
                                                    width: 30,
                                                    height: 25,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  Stack(
                                                    children: [
                                                      Positioned(
                                                        left: 12,
                                                        top: 2,
                                                        child: CircleAvatar(
                                                          foregroundColor:
                                                              Colors.red,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/img/battle/frameavtwin.png'),
                                                          radius: 38,
                                                        ),
                                                      ),
                                                      Image.asset(
                                                        'assets/img/home/st2.png',
                                                        width: 100,
                                                        height: 80,
                                                        fit: BoxFit.fill,
                                                      ),
                                                      Positioned(
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            30,
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            30,
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            30,
                                                        bottom: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            30,
                                                        child: ButtonCustom(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            PersonalProfileView(
                                                                              profile: Top10profiles[1],
                                                                              you: true,
                                                                            )));
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        'assets/img/battle/${Top10profiles[1].gender}.png'))),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 80,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Text(
                                                      Top10profiles[1].name,
                                                      style: TextStyle(
                                                        fontFamily: 'Mitr',
                                                        color: Color.fromARGB(
                                                            255, 9, 15, 198),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Stack(
                                                    children: [
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            4,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            25,
                                                      ),
                                                      Positioned(
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            150,
                                                        bottom: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            150,
                                                        right: 0,
                                                        left: MediaQuery.of(
                                                                    context)
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
                                                            alignment: Alignment
                                                                .center,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color
                                                                  .fromARGB(
                                                                      255,
                                                                      68,
                                                                      148,
                                                                      165),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          40.0),
                                                            ),
                                                            child: FittedBox(
                                                              fit: BoxFit
                                                                  .scaleDown,
                                                              child: Text(
                                                                "${getStarLevel(Top10profiles[1].star)[0].toUpperCase()}${getStarLevel(Top10profiles[1].star).substring(1)}",
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      'Mitr',
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                ),
                                                              ),
                                                            )),
                                                      ),
                                                      Positioned(
                                                          top: 2.5,
                                                          bottom: 2.5,
                                                          left: 0,
                                                          child: Image.asset(
                                                            "assets/img/home/${getStarLevel(Top10profiles[1].star)}.gif",
                                                            width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width /
                                                                8,
                                                            fit: BoxFit.fill,
                                                          ))
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container()
                                    : filterUserTopics.length > 1
                                        ? Positioned(
                                            top: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    12 +
                                                scale -
                                                10,
                                            right: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                15,
                                            child: Container(
                                              width: 110,
                                              height: 155,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Image.asset(
                                                    'assets/img/home/2stlogo.png',
                                                    width: 30,
                                                    height: 25,
                                                    fit: BoxFit.fill,
                                                  ),
                                                  Stack(
                                                    children: [
                                                      Positioned(
                                                        left: 12,
                                                        top: 2,
                                                        child: CircleAvatar(
                                                          foregroundColor:
                                                              Colors.red,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  'assets/img/battle/frameavtwin.png'),
                                                          radius: 38,
                                                        ),
                                                      ),
                                                      Image.asset(
                                                        'assets/img/home/st2.png',
                                                        width: 100,
                                                        height: 80,
                                                        fit: BoxFit.fill,
                                                      ),
                                                      Positioned(
                                                        top: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            30,
                                                        left: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            30,
                                                        right: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            30,
                                                        bottom: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            30,
                                                        child: ButtonCustom(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            PersonalProfileView(
                                                                              profile: profiles.where((element) => element.uid == filterUserTopics[1].uid).first,
                                                                              you: true,
                                                                            )));
                                                          },
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(
                                                                    image: AssetImage(
                                                                        'assets/img/battle/${profiles.where((element) => element.uid == filterUserTopics[1].uid).first.gender}.png'))),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Container(
                                                    alignment: Alignment.center,
                                                    width: 80,
                                                    height: 20,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    child: Text(
                                                      profiles
                                                          .where((element) =>
                                                              element.uid ==
                                                              filterUserTopics[
                                                                      1]
                                                                  .uid)
                                                          .first
                                                          .name,
                                                      style: TextStyle(
                                                        fontFamily: 'Mitr',
                                                        color: Color.fromARGB(
                                                            255, 9, 15, 198),
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    '${filterUserTopics[1].totalScore} điểm',
                                                    style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      color: Color.fromARGB(
                                                          255, 213, 239, 13),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        : Container()
                              ],
                            )
                          : Center(
                              child: AnimatedTextKit(
                                repeatForever: true,
                                isRepeatingAnimation: true,
                                animatedTexts: [
                                  TyperAnimatedText('Đang tải...',
                                      textAlign: TextAlign.center,
                                      textStyle: TextStyle(
                                          fontFamily: 'Mitr',
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ),
                    );
                  }),
              Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                height: MediaQuery.of(context).size.height / 3.5,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 218, 122, 49),
                    borderRadius: BorderRadius.circular(10)),
                child: Container(
                  alignment: Alignment.topCenter,
                  height: MediaQuery.of(context).size.height / 3.4,
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 250, 255, 218),
                      borderRadius: BorderRadius.circular(10)),
                  child: !isLoading
                      ? SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (isModeBattle && Top10profiles.length < 4)
                                Center(
                                  child: AnimatedTextKit(
                                    repeatForever: false,
                                    isRepeatingAnimation: false,
                                    animatedTexts: [
                                      TyperAnimatedText(
                                          'Không có dữ liệu người chơi nào.',
                                          textAlign: TextAlign.center,
                                          textStyle: TextStyle(
                                              fontFamily: 'Mitr',
                                              color: Color.fromARGB(
                                                  255, 32, 32, 32),
                                              fontSize: 15,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              if (isModeBattle && Top10profiles.length > 3)
                                for (int i = 3; i < Top10profiles.length; i++)
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    height:
                                        MediaQuery.of(context).size.height / 8,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 218, 122, 49),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              8.1,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 157, 79, 11),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              GlowText(
                                                "${i + 1}.",
                                                style: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                              ButtonCustom(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PersonalProfileView(
                                                                profile:
                                                                    Top10profiles[
                                                                        i],
                                                                you: true,
                                                              )));
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      12,
                                                  padding: EdgeInsets.all(15),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/img/battle/frameavtwin.png"),
                                                          fit: BoxFit.fill)),
                                                  child: Image.asset(
                                                      "assets/img/battle/${Top10profiles[i].gender}.png"),
                                                ),
                                              ),
                                              Text(
                                                Top10profiles[i].name,
                                                style: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Stack(
                                                children: [
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            3.2,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            20,
                                                  ),
                                                  Positioned(
                                                    top: MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        150,
                                                    bottom:
                                                        MediaQuery.of(context)
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
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Color.fromARGB(
                                                              255,
                                                              68,
                                                              148,
                                                              165),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      40.0),
                                                        ),
                                                        child: FittedBox(
                                                          fit: BoxFit.scaleDown,
                                                          child: Text(
                                                            "${getStarLevel(Top10profiles[i].star)[0].toUpperCase()}${getStarLevel(Top10profiles[i].star).substring(1)}",
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Mitr',
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
                                                        )),
                                                  ),
                                                  Positioned(
                                                      top: 2.5,
                                                      bottom: 2.5,
                                                      left: 0,
                                                      child: Image.asset(
                                                        "assets/img/home/${getStarLevel(Top10profiles[i].star)}.gif",
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            8,
                                                        fit: BoxFit.fill,
                                                      ))
                                                ],
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "x${getRemainingStars(Top10profiles[i].star)}",
                                                    style: TextStyle(
                                                        fontFamily: 'Mitr',
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w700),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 5),
                                                    child: Image.asset(
                                                      "assets/img/home/star.png",
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
                                  ),
                              if (!isModeBattle && filterUserTopics.length < 4)
                                Center(
                                  child: AnimatedTextKit(
                                    repeatForever: false,
                                    isRepeatingAnimation: false,
                                    animatedTexts: [
                                      TyperAnimatedText(
                                          'Không có dữ liệu người chơi nào.',
                                          textAlign: TextAlign.center,
                                          textStyle: TextStyle(
                                              fontFamily: 'Mitr',
                                              color: Color.fromARGB(
                                                  255, 32, 32, 32),
                                              fontSize: 15,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w500)),
                                    ],
                                  ),
                                ),
                              if (!isModeBattle && filterUserTopics.length > 3)
                                for (int i = 3;
                                    i < filterUserTopics.length;
                                    i++)
                                  Container(
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    height:
                                        MediaQuery.of(context).size.height / 8,
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 218, 122, 49),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              8.1,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 157, 79, 11),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              GlowText(
                                                "${i + 1}.",
                                                style: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    fontSize: 15,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                              ButtonCustom(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PersonalProfileView(
                                                                profile: profiles
                                                                    .where((element) =>
                                                                        element
                                                                            .uid ==
                                                                        filterUserTopics[i]
                                                                            .uid)
                                                                    .first,
                                                                you: true,
                                                              )));
                                                },
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      5,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      12,
                                                  padding: EdgeInsets.all(15),
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/img/battle/frameavtwin.png"),
                                                          fit: BoxFit.fill)),
                                                  child: Image.asset(
                                                      "assets/img/battle/${profiles.where((element) => element.uid == filterUserTopics[i].uid).first.gender}.png"),
                                                ),
                                              ),
                                              Text(
                                                Top10profiles[i].name,
                                                style: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    fontSize: 18,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "${filterUserTopics[i].totalScore} Điểm",
                                              style: TextStyle(
                                                  fontFamily: 'Mitr',
                                                  fontSize: 18,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            ],
                          ),
                        )
                      : Center(
                          child: AnimatedTextKit(
                            repeatForever: true,
                            isRepeatingAnimation: true,
                            animatedTexts: [
                              TyperAnimatedText('Đang tải...',
                                  textAlign: TextAlign.center,
                                  textStyle: TextStyle(
                                      fontFamily: 'Mitr',
                                      color: Color.fromARGB(255, 32, 32, 32),
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
