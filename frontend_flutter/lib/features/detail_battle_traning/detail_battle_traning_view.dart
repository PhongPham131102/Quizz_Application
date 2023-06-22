// ignore_for_file: unused_field

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:frontend_flutter/components/Star.dart';
import 'package:frontend_flutter/features/detail_battle_traning/detail_battle_traning_contract.dart';
import 'package:frontend_flutter/features/detail_battle_traning/detail_battle_traning_presenter.dart';
import 'package:frontend_flutter/models/UserTopic.dart';

import '../../components/Button.dart';
import '../../components/TextCustom.dart';
import '../question_answer/question_answer_view.dart';
import '../../models/Level.dart';
import '../../models/UserLevel.dart';

// ignore: must_be_immutable
class DetailBattleTrainingView extends StatefulWidget {
  UserTopic userTopic;
  DetailBattleTrainingView({super.key, required this.userTopic});

  @override
  State<DetailBattleTrainingView> createState() =>
      _DetailBattleTrainingViewState();
}

class _DetailBattleTrainingViewState extends State<DetailBattleTrainingView>
    with TickerProviderStateMixin
    implements DetailBattleTrainingContract {
  late DetailBattleTrainingPresenter _presenter;
  _DetailBattleTrainingViewState() {
    _presenter = DetailBattleTrainingPresenter(this);
  }
  late ScrollController _scrollController;
  late AnimationController _animationscrollController;
  late Animation<double> _animationscroll;
  late AnimationController _animationController;
  bool _isExpanded = false;
  bool isloading = true;
  int totalpage = 0;
  @override
  setIsLoading(bool _isloading) {
    isloading = _isloading;
    if (mounted) {
      _scrollController = ScrollController();
      _animationscrollController = AnimationController(
        duration: Duration(milliseconds: 1000),
        vsync: this,
      );

      _animationscroll =
          Tween<double>(begin: 0, end: 1).animate(_animationscrollController);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 2000),
          curve: Curves.easeOutBack,
        );
      });

      _animationscrollController.forward();
      _animationController = AnimationController(
        vsync: this,
        duration: Duration(
            milliseconds: 500), // Điều chỉnh thời gian phóng to và thu nhỏ
      );

      _animationController.addListener(() {
        if (_animationController.status == AnimationStatus.completed ||
            _animationController.status == AnimationStatus.dismissed) {
          _toggleSize();
        }
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _toggleSize();
      });
      if (mounted) setState(() {});
    }
  }

  List<UserLevel> userlevels = [];
  @override
  updateLevel(List<UserLevel> _userlevels) {
    for (int i = 0; i < _userlevels.length; i++) {
      int level = _userlevels[i].level;
      bool isExisting = false;

      for (int j = 0; j < userlevels.length; j++) {
        if (userlevels[j].level == level) {
          userlevels[j].id = _userlevels[i].id;
          userlevels[j].uid = _userlevels[i].uid;
          userlevels[j].topicType = _userlevels[i].topicType;
          userlevels[j].level = _userlevels[i].level;
          userlevels[j].score = _userlevels[i].score;
          userlevels[j].star = _userlevels[i].star;
          userlevels[j].createdAt = _userlevels[i].createdAt;
          userlevels[j].updatedAt = _userlevels[i].updatedAt;
          isExisting = true;
          break; // Kết thúc vòng lặp nếu đã cập nhật UserLevel
        }
      }

      if (!isExisting) {
        userlevels.add(_userlevels[i]);
      }
    }
    if (mounted) {
      setState(() {});
    }
  }

  List<Level> levels = [];
  @override
  setListUserLevel(List<UserLevel> _listuserlevels) {
    userlevels = _listuserlevels;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setListLevel(List<Level> _listlevels) {
    levels = _listlevels;
    totalpage = (levels.length / 4).ceil();
    print(totalpage);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    _presenter.Getall(this.widget.userTopic.topicType);

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationscrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSize() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          isloading
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/battle/bg2.png"),
                          fit: BoxFit.fill)),
                  child: Center(
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
                )
              : AnimatedBuilder(
                  animation: _animationscroll,
                  builder: (context, child) {
                    return SingleChildScrollView(
                      physics: ClampingScrollPhysics(),
                      controller: _scrollController,
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height:
                                MediaQuery.of(context).size.height * totalpage,
                          ),
                          for (int i = 0; i < totalpage; i++) ...{
                            Positioned(
                              bottom: MediaQuery.of(context).size.height * i,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        "assets/img/battletraining/topic${this.widget.userTopic.topicType}.png"),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ), //level 1
                            AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                final scale =
                                    _animationController.value * 0.01 + 1.0;
                                return Positioned(
                                  bottom:
                                      MediaQuery.of(context).size.height * i,
                                  left: MediaQuery.of(context).size.width / 2.4,
                                  right:
                                      MediaQuery.of(context).size.width / 3.4,
                                  child: ButtonCustom(
                                    onTap: () {},
                                    child: Transform.scale(
                                      scale: scale,
                                      child: Builder(builder: (context) {
                                        int indexFirst = 4 * i + 1;
                                        return Stack(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5.5,
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: ButtonCustom(
                                                onTap: () {
                                                  if (userlevels
                                                          .where((e) =>
                                                              e.level ==
                                                              indexFirst)
                                                          .firstOrNull !=
                                                      null) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              QuestionAnswerView(
                                                                  level:
                                                                      indexFirst,
                                                                  topicsType: this
                                                                      .widget
                                                                      .userTopic
                                                                      .topicType),
                                                        ));
                                                  }
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      8,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/img/battletraining/levelbutton.png"),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            (userlevels
                                                        .where((e) =>
                                                            e.level ==
                                                                indexFirst &&
                                                            e.star != 0)
                                                        .firstOrNull !=
                                                    null)
                                                ? Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            20,
                                                    child: Stars(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              17,
                                                      star: userlevels
                                                          .where((e) =>
                                                              e.level ==
                                                                  indexFirst &&
                                                              e.star != 0)
                                                          .first
                                                          .star,
                                                    ),
                                                  )
                                                : Container(),
                                            Positioned(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  13,
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                              child: CustomText(
                                                indexFirst.toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    color: Colors.white,
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            (userlevels
                                                        .where((e) =>
                                                            e.level ==
                                                            indexFirst)
                                                        .firstOrNull !=
                                                    null)
                                                ? Container()
                                                : Positioned(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            60,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            40,
                                                    child: Transform.rotate(
                                                      angle:
                                                          -25 * 3.1415927 / 180,
                                                      child: Image.asset(
                                                        "assets/img/battletraining/key.png",
                                                        fit: BoxFit.fill,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            17,
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                );
                              },
                            ), //level 1
                            Positioned(
                              bottom: MediaQuery.of(context).size.height * i +
                                  MediaQuery.of(context).size.height / 25,
                              left: MediaQuery.of(context).size.width / 25,
                              child: Builder(builder: (context) {
                                int indexFirst = i * 4 + 1;
                                return Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              8,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/img/battletraining/board2.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: MediaQuery.of(context).size.height /
                                          70,
                                      left: MediaQuery.of(context).size.width /
                                          30,
                                      right: MediaQuery.of(context).size.width /
                                          50,
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              25,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: AutoSizeText(
                                          (levels
                                                      .where((e) =>
                                                          e.level == indexFirst)
                                                      .firstOrNull !=
                                                  null)
                                              ? levels
                                                  .where((e) =>
                                                      e.level == indexFirst)
                                                  .first
                                                  .title
                                              : "Đang Cập Nhật",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Mitr',
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                            //level 2
                            AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                final scale =
                                    _animationController.value * 0.01 + 1.0;
                                return Positioned(
                                  bottom: MediaQuery.of(context).size.height *
                                          i +
                                      MediaQuery.of(context).size.height / 4,
                                  left: MediaQuery.of(context).size.width / 4,
                                  right:
                                      MediaQuery.of(context).size.width / 2.2,
                                  child: ButtonCustom(
                                    onTap: () {},
                                    child: Transform.scale(
                                      scale: scale,
                                      child: Builder(builder: (context) {
                                        int indexSecond = 4 * i + 2;
                                        return Stack(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5.5,
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: ButtonCustom(
                                                onTap: () {
                                                  if (userlevels
                                                          .where((e) =>
                                                              e.level ==
                                                              indexSecond)
                                                          .firstOrNull !=
                                                      null) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              QuestionAnswerView(
                                                                  level:
                                                                      indexSecond,
                                                                  topicsType: this
                                                                      .widget
                                                                      .userTopic
                                                                      .topicType),
                                                        ));
                                                  }
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      8,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/img/battletraining/levelbutton.png"),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            (userlevels
                                                        .where((e) =>
                                                            e.level ==
                                                                indexSecond &&
                                                            e.star != 0)
                                                        .firstOrNull !=
                                                    null)
                                                ? Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            20,
                                                    child: Stars(
                                                      star: userlevels
                                                          .where((e) =>
                                                              e.level ==
                                                                  indexSecond &&
                                                              e.star != 0)
                                                          .first
                                                          .star,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              17,
                                                    ),
                                                  )
                                                : Container(),
                                            Positioned(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  13,
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                              child: CustomText(
                                                indexSecond.toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    color: Colors.white,
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            (userlevels
                                                        .where((e) =>
                                                            e.level ==
                                                            indexSecond)
                                                        .firstOrNull !=
                                                    null)
                                                ? Container()
                                                : Positioned(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            60,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            40,
                                                    child: Transform.rotate(
                                                      angle:
                                                          -25 * 3.1415927 / 180,
                                                      child: Image.asset(
                                                        "assets/img/battletraining/key.png",
                                                        fit: BoxFit.fill,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            17,
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                );
                              },
                            ), //level 2
                            Positioned(
                              bottom: MediaQuery.of(context).size.height * i +
                                  MediaQuery.of(context).size.height / 4,
                              right: MediaQuery.of(context).size.width / 8,
                              child: Builder(builder: (context) {
                                int indexSecond = i * 4 + 2;
                                return Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              8,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/img/battletraining/board2.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: MediaQuery.of(context).size.height /
                                          70,
                                      left: MediaQuery.of(context).size.width /
                                          30,
                                      right: MediaQuery.of(context).size.width /
                                          50,
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              25,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: AutoSizeText(
                                          (levels
                                                      .where((e) =>
                                                          e.level ==
                                                          indexSecond)
                                                      .firstOrNull !=
                                                  null)
                                              ? levels
                                                  .where((e) =>
                                                      e.level == indexSecond)
                                                  .first
                                                  .title
                                              : "Đang Cập Nhật",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Mitr',
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ), //level 3
                            AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                final scale =
                                    _animationController.value * 0.01 + 1.0;
                                return Positioned(
                                  bottom: MediaQuery.of(context).size.height *
                                          i +
                                      MediaQuery.of(context).size.height / 2.5,
                                  left: MediaQuery.of(context).size.width / 1.8,
                                  right: MediaQuery.of(context).size.width / 6,
                                  child: ButtonCustom(
                                    onTap: () {},
                                    child: Transform.scale(
                                      scale: scale,
                                      child: Builder(builder: (context) {
                                        int indexThird = 4 * i + 3;
                                        return Stack(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5.5,
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: ButtonCustom(
                                                onTap: () {
                                                  if (userlevels
                                                          .where((e) =>
                                                              e.level ==
                                                              indexThird)
                                                          .firstOrNull !=
                                                      null) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              QuestionAnswerView(
                                                                  level:
                                                                      indexThird,
                                                                  topicsType: this
                                                                      .widget
                                                                      .userTopic
                                                                      .topicType),
                                                        ));
                                                  }
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      8,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/img/battletraining/levelbutton.png"),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            (userlevels
                                                        .where((e) =>
                                                            e.level ==
                                                                indexThird &&
                                                            e.star != 0)
                                                        .firstOrNull !=
                                                    null)
                                                ? Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            20,
                                                    child: Stars(
                                                      star: userlevels
                                                          .where((e) =>
                                                              e.level ==
                                                                  indexThird &&
                                                              e.star != 0)
                                                          .first
                                                          .star,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              17,
                                                    ),
                                                  )
                                                : Container(),
                                            Positioned(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  13,
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                              child: CustomText(
                                                indexThird.toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    color: Colors.white,
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            (userlevels
                                                        .where((e) =>
                                                            e.level ==
                                                            indexThird)
                                                        .firstOrNull !=
                                                    null)
                                                ? Container()
                                                : Positioned(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            60,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            40,
                                                    child: Transform.rotate(
                                                      angle:
                                                          -25 * 3.1415927 / 180,
                                                      child: Image.asset(
                                                        "assets/img/battletraining/key.png",
                                                        fit: BoxFit.fill,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            17,
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                );
                              },
                            ), //level 3
                            Positioned(
                              bottom: MediaQuery.of(context).size.height * i +
                                  MediaQuery.of(context).size.height / 2.3,
                              left: MediaQuery.of(context).size.width / 8,
                              child: Builder(builder: (context) {
                                int indexThird = i * 4 + 3;
                                return Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              8,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/img/battletraining/board2.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: MediaQuery.of(context).size.height /
                                          70,
                                      left: MediaQuery.of(context).size.width /
                                          30,
                                      right: MediaQuery.of(context).size.width /
                                          50,
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              25,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: AutoSizeText(
                                          (levels
                                                      .where((e) =>
                                                          e.level == indexThird)
                                                      .firstOrNull !=
                                                  null)
                                              ? levels
                                                  .where((e) =>
                                                      e.level == indexThird)
                                                  .first
                                                  .title
                                              : "Đang Cập Nhật",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Mitr',
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ), //level 4
                            AnimatedBuilder(
                              animation: _animationController,
                              builder: (context, child) {
                                final scale =
                                    _animationController.value * 0.01 + 1.0;
                                return Positioned(
                                  bottom: MediaQuery.of(context).size.height *
                                          i +
                                      MediaQuery.of(context).size.height / 1.6,
                                  left: MediaQuery.of(context).size.width / 6,
                                  right:
                                      MediaQuery.of(context).size.width / 1.8,
                                  child: ButtonCustom(
                                    onTap: () {},
                                    child: Transform.scale(
                                      scale: scale,
                                      child: Builder(builder: (context) {
                                        int indexFourth = 4 * i + 4;
                                        return Stack(
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5.5,
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: ButtonCustom(
                                                onTap: () {
                                                  if (userlevels
                                                          .where((e) =>
                                                              e.level ==
                                                              indexFourth)
                                                          .firstOrNull !=
                                                      null) {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              QuestionAnswerView(
                                                                  level:
                                                                      indexFourth,
                                                                  topicsType: this
                                                                      .widget
                                                                      .userTopic
                                                                      .topicType),
                                                        ));
                                                  }
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      8,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: AssetImage(
                                                          "assets/img/battletraining/levelbutton.png"),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            (userlevels
                                                        .where((e) =>
                                                            e.level ==
                                                                indexFourth &&
                                                            e.star != 0)
                                                        .firstOrNull !=
                                                    null)
                                                ? Positioned(
                                                    top: 0,
                                                    left: 0,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            20,
                                                    child: Stars(
                                                      star: userlevels
                                                          .where((e) =>
                                                              e.level ==
                                                                  indexFourth &&
                                                              e.star != 0)
                                                          .first
                                                          .star,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height /
                                                              17,
                                                    ),
                                                  )
                                                : Container(),
                                            Positioned(
                                              top: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  13,
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                              child: CustomText(
                                                indexFourth.toString(),
                                                style: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    color: Colors.white,
                                                    fontSize: 26,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            (userlevels
                                                        .where((e) =>
                                                            e.level ==
                                                            indexFourth)
                                                        .firstOrNull !=
                                                    null)
                                                ? Container()
                                                : Positioned(
                                                    bottom:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height /
                                                            60,
                                                    right:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            40,
                                                    child: Transform.rotate(
                                                      angle:
                                                          -25 * 3.1415927 / 180,
                                                      child: Image.asset(
                                                        "assets/img/battletraining/key.png",
                                                        fit: BoxFit.fill,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            17,
                                                      ),
                                                    ),
                                                  ),
                                          ],
                                        );
                                      }),
                                    ),
                                  ),
                                );
                              },
                            ), //level 4
                            Positioned(
                              bottom: MediaQuery.of(context).size.height * i +
                                  MediaQuery.of(context).size.height / 1.5,
                              right: MediaQuery.of(context).size.width / 6,
                              child: Builder(builder: (context) {
                                int indexFourth = i * 4 + 4;
                                return Stack(
                                  children: [
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              8,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              "assets/img/battletraining/board2.png"),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: MediaQuery.of(context).size.height /
                                          70,
                                      left: MediaQuery.of(context).size.width /
                                          30,
                                      right: MediaQuery.of(context).size.width /
                                          50,
                                      bottom:
                                          MediaQuery.of(context).size.height /
                                              25,
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: AutoSizeText(
                                          (levels
                                                      .where((e) =>
                                                          e.level ==
                                                          indexFourth)
                                                      .firstOrNull !=
                                                  null)
                                              ? levels
                                                  .where((e) =>
                                                      e.level == indexFourth)
                                                  .first
                                                  .title
                                              : "Đang Cập Nhật",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontFamily: 'Mitr',
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 4,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          }
                        ],
                      ),
                    );
                  }),
          Positioned(
            top: MediaQuery.of(context).size.height / 40,
            left: 0,
            right: 0,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
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
                            fit: BoxFit.fill)),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.height / 10,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(this.widget.userTopic.topicType ==
                                  "c++"
                              ? "assets/img/battle/cplusplus.gif"
                              : "assets/img/battle/${this.widget.userTopic.topicType}.gif"),
                          fit: BoxFit.fill)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 8,
                  height: MediaQuery.of(context).size.height / 14,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
