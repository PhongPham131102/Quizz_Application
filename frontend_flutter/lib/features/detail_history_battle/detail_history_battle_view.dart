import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:frontend_flutter/features/detail_history_battle/detail_history_battle_contract.dart';
import 'package:frontend_flutter/features/detail_history_battle/detail_history_battle_presenter.dart';
import 'package:frontend_flutter/models/Match.dart';

import '../../components/Button.dart';
import '../../constants.dart';
import '../../models/Profile.dart';

// ignore: must_be_immutable
class DetailHistoryBattleView extends StatefulWidget {
  Profile profile;
  MatchBattle match;
  DetailHistoryBattleView(
      {super.key, required this.match, required this.profile});

  @override
  State<DetailHistoryBattleView> createState() =>
      _DetailHistoryBattleViewState();
}

class _DetailHistoryBattleViewState extends State<DetailHistoryBattleView>
    implements DetailHistoryBattleContract {
  // ignore: unused_field
  late DetailHistoryBattlePresenter _presenter;
  late Profile rivalProfile;
  bool isloading = true;
  _DetailHistoryBattleViewState() {
    _presenter = DetailHistoryBattlePresenter(this);
  }
  @override
  SetRivalProfile(Profile _rival) {
    rivalProfile = _rival;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setIsLoading(bool _isloading) {
    isloading = _isloading;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _presenter.GetRivalProfile(this.widget.match);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 30),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/battle/bg2.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonCustom(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width / 8,
                    height: MediaQuery.of(context).size.height / 14,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/img/battle/return.png"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.height / 9,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          "assets/img/historybattle/detail.gif"),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 8,
                  height: MediaQuery.of(context).size.height / 14,
                ),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height -
                  MediaQuery.of(context).size.height / 6,
              child: !isloading
                  ? ListView(
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.zero,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                    ),
                                    Positioned(
                                      left: 0,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10,
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  10,
                                            ),
                                            Positioned(
                                              right: 10,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    this.widget.profile.name,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            30,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 201, 106, 11),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      this
                                                                  .widget
                                                                  .match
                                                                  .player1 ==
                                                              uid
                                                          ? this
                                                              .widget
                                                              .match
                                                              .score1
                                                              .toString()
                                                          : this
                                                              .widget
                                                              .match
                                                              .score2
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  10 *
                                                  0.1,
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  10 *
                                                  0.1,
                                              child: Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Image.asset(
                                                  "assets/img/battle/${this.widget.profile.gender}.png",
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10,
                                        child: Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  10,
                                            ),
                                            Positioned(
                                              left: 10,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    rivalProfile.name,
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                    .size
                                                                    .width /
                                                                2 -
                                                            30,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        color: Color.fromARGB(
                                                            255, 201, 106, 11),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5)),
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      this
                                                                  .widget
                                                                  .match
                                                                  .player1 ==
                                                              rivalProfile.uid
                                                          ? this
                                                              .widget
                                                              .match
                                                              .score1
                                                              .toString()
                                                          : this
                                                              .widget
                                                              .match
                                                              .score2
                                                              .toString(),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w900),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Positioned(
                                              right: 0,
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  10 *
                                                  0.1,
                                              bottom: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  10 *
                                                  0.1,
                                              child: Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                child: Image.asset(
                                                  "assets/img/battle/${rivalProfile.gender}.png",
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10,
                                            alignment: Alignment.bottomCenter,
                                            child: Image.asset(
                                              "assets/img/battle/vs2.png",
                                              width: 50,
                                              height: 50,
                                            )))
                                  ],
                                )
                              ],
                            ),
                            ...this
                                .widget
                                .match
                                .questions
                                .asMap()
                                .entries
                                .map((entry) {
                              int index = entry.key;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(20),
                                    margin: EdgeInsets.only(
                                        left: 20, right: 20, top: 20),
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/img/iconquestion/board.png"),
                                            fit: BoxFit.fill)),
                                    constraints: BoxConstraints(
                                      minHeight:
                                          MediaQuery.of(context).size.height /
                                              3.8,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Câu ${index + 1}:",
                                              style: TextStyle(
                                                  color: Colors.yellow,
                                                  fontWeight: FontWeight.w700),
                                            )
                                          ],
                                        ),
                                        Text(
                                            this
                                                .widget
                                                .match
                                                .questions[index]
                                                .title,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700)),
                                        Container(
                                          width: 1,
                                          height: 1,
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(top: 5, left: 5),
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                    height:
                                        MediaQuery.of(context).size.height / 20,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/img/battle/review.png"),
                                            fit: BoxFit.fill)),
                                    child: GlowText(
                                      "Đáp án:",
                                      blurRadius: 7,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                    ),
                                  ),
                                  ...this
                                      .widget
                                      .match
                                      .questions[index]
                                      .answers
                                      .asMap()
                                      .entries
                                      .map((entry) {
                                    int indexAnswer = entry.key;
                                    final answer = entry.value;
                                    List<AnswerBattle> youAnswer =
                                        this.widget.match.player1 == uid
                                            ? this.widget.match.answer1
                                            : this.widget.match.answer2;
                                    List<AnswerBattle> rivalAnswer =
                                        this.widget.match.player1 == uid
                                            ? this.widget.match.answer2
                                            : this.widget.match.answer1;

                                    return Stack(
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              left: 25,
                                              right: 25,
                                              bottom: 5,
                                              top: 5),
                                          padding: EdgeInsets.all(1.5),
                                          decoration: BoxDecoration(
                                              color: Colors
                                                  .black, // Thay đổi màu tương ứng
                                              borderRadius:
                                                  BorderRadius.circular(3)),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: answer.score
                                                    ? Colors.green
                                                    : Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                            constraints: BoxConstraints(
                                                minHeight: 50, minWidth: 320),
                                            child: Center(
                                              child: Text(answer.answerText,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w700)),
                                            ),
                                          ),
                                        ),
                                        (youAnswer.any((element) =>
                                                element.index == index &&
                                                element.selectedIndex ==
                                                    indexAnswer))
                                            ? Positioned(
                                                left: 5,
                                                top: 10,
                                                bottom: 10,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      8,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      6,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/img/battle/${this.widget.profile.gender}.png"),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        (rivalAnswer.any((element) =>
                                                element.index == index &&
                                                element.selectedIndex ==
                                                    indexAnswer))
                                            ? Positioned(
                                                right: 5,
                                                top: 10,
                                                bottom: 10,
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      8,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      6,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/img/battle/${rivalProfile.gender}.png"),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container()
                                      ],
                                    );
                                  }).toList(),
                                ],
                              );
                            })
                          ],
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Đang tải',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 32, 32, 32),
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500)),
                              AnimatedTextKit(
                                pause: Duration(milliseconds: 1000),
                                repeatForever: true,
                                isRepeatingAnimation: true,
                                animatedTexts: [
                                  TyperAnimatedText('...',
                                      speed: Duration(milliseconds: 500),
                                      textAlign: TextAlign.center,
                                      textStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 32, 32, 32),
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
