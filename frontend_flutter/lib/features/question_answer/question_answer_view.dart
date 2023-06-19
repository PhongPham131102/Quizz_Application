import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/features/question_answer/question_answer_contract.dart';
import 'package:frontend_flutter/features/question_answer/question_answer_presenter.dart';
import 'package:frontend_flutter/models/Question.dart';

import '../../components/Button.dart';
import '../../constants.dart';

// ignore: must_be_immutable
class QuestionAnswerView extends StatefulWidget {
  String topicsType;
  int level;
  QuestionAnswerView(
      {super.key, required this.level, required this.topicsType});

  @override
  State<QuestionAnswerView> createState() => _QuestionAnswerViewState();
}

class _QuestionAnswerViewState extends State<QuestionAnswerView>
    with TickerProviderStateMixin
    implements QuestionAnswerContract {
  late QuestionAnswerPresenter _presenter;
  _QuestionAnswerViewState() {
    _presenter = QuestionAnswerPresenter(this);
  }
  late AnimationController _animationController;
  bool _isExpanded = false;
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

  int? selectedAnswerIndex;
  int? time;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  int _countDown = 3;
  int expEarned = 0;
  int goldEarned = 0;
  int star = 1;
  bool isSumarry = false;
  bool summaring = false;
  int oldLevel = 0;
  int oldExp = 0;
  int nowExp = 0;
  int newLevel = 0;
  @override
  SetParameterResult(int _oldLevel, int _expEarned, int _oldExp, int _nowExp,
      int _newLevel, int _gold, int _star) {
    star = _star;
    oldLevel = _oldLevel;
    expEarned = _expEarned;
    oldExp = _oldExp;
    nowExp = _nowExp;
    newLevel = _newLevel;
    goldEarned = _gold;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  SetEnd(bool _isend) {
    isEnd = _isend;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  SetSummaring(bool _summaring) {
    summaring = _summaring;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setTime(int _time) {
    time = _time;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setGold(int _gold) {
    gold = _gold;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setMaxScore(int _maxscore) {
    maxScore = _maxscore;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setQuestion(List<Question> _questions) {
    questions = _questions;
    questions!.shuffle();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  CountDown() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reset();
          setState(() {
            --_countDown;
          });

          if (_countDown == -1) {
            _controller.stop();
            start();
          } else {
            _controller.forward();
          }
        }
      });
    _scaleAnimation = Tween<double>(begin: 1.0, end: 2.0).animate(_controller);
    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_controller);
    _controller.forward();
  }

  List<Question>? questions;
  int? gold;
  int maxScore = 0;
  int index = 0;
  int score = 0;
  int x2Score = 1;
  bool toolWasUsed = false;
  bool fiftyFiftyWasUsed = false;
  bool specialWasUsed = false;
  bool doubleScoreWasUsed = false;
  bool TimePlusWasUsed = false;
  bool isloading = true;
  bool isAnswer = false;
  bool isEnd = false;
  int isCorrect = 0;
  @override
  void initState() {
    _presenter.getGoldAndQuestion(this.widget.topicsType, this.widget.level);
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
    setState(() {});
    super.initState();
  }

  void start() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (time! > 0) {
        setState(() {
          time = time! - 1;
        });
      } else {
        timer.cancel();
        _presenter.Sumarry(
            this.widget.topicsType, this.widget.level, score, maxScore, gold!);
      }
    });
  }

  void handleFiftyFifty() {
    if (!toolWasUsed && !fiftyFiftyWasUsed && gold! > 100 && !isAnswer) {
      gold=gold!-100;
      fiftyFiftyWasUsed = true;
      // Lấy ra 2 đáp án sai
      List<Answer> wrongAnswers =
          questions![index].answers.where((answer) => !answer.score).toList();
      wrongAnswers.shuffle();
      wrongAnswers = wrongAnswers.sublist(0, 2);
// Thay thế 2 đáp án sai bằng chuỗi rỗng
      questions![index].answers.forEach((answer) {
        if (answer.answerText == wrongAnswers[0].answerText ||
            answer.answerText == wrongAnswers[1].answerText) {
          answer.answerText = "";
        }
      });

      // Cập nhật lại giao diện
      setState(() {});
      toolWasUsed = true;
    }
  }

  void handleDoubleScore() {
    if (!toolWasUsed && !doubleScoreWasUsed && gold! > 50 && !isAnswer) { gold=gold!-50;
      doubleScoreWasUsed = true;
      x2Score = 2;
      // Cập nhật lại giao diện
      setState(() {});
      toolWasUsed = true;
    }
  }

  void handlePlusTime() {
    if (!toolWasUsed && !TimePlusWasUsed && gold! > 30 && !isAnswer) { gold=gold!-30;
      TimePlusWasUsed = true;
      time = time! + 5;
      // Cập nhật lại giao diện
      setState(() {});
      toolWasUsed = true;
    }
  }

  void handleSpecial() {
    if (!toolWasUsed && !specialWasUsed && gold! > 200 && !isAnswer) {
       gold=gold!-200;
      specialWasUsed = true;
      // thay thế chuổi rỗng tất cả đáp án sai khỏi câu hỏi
      questions![index].answers.forEach((answer) {
        if (!answer.score) {
          answer.answerText = "";
        }
      });

      // Cập nhật lại giao diện
      setState(() {});
      toolWasUsed = true;
    }
  }

  void handleAnswer(answer) {
    if (answer) {
      setState(() {
        score += questions![index].score * x2Score;

        if (index < questions!.length - 1) {
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              index++;
              x2Score = 1;
              isAnswer = false;
              toolWasUsed = false;
              selectedAnswerIndex = null;
            });
          });
        } else {
          setState(() {
            time = 1;
            isAnswer = true;
          });
          print("hết câu hỏi");
        }
      });
    } else {
      // Đáp án sai
      setState(() {
        x2Score = 1;
        isAnswer = false;
        toolWasUsed = false;

        if (index < questions!.length - 1) {
          Future.delayed(Duration(seconds: 1), () {
            setState(() {
              index++;
              x2Score = 1;
              isAnswer = false;
              toolWasUsed = false;
              selectedAnswerIndex = null;
            });
          });
        } else {
          setState(() {
            time = 1;
            isAnswer = true;
          });

          print("hết câu hỏi");
        }
      });
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
  void dispose() {
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        AssetImage("assets/img/battletraining/bgquestion.png"),
                    fit: BoxFit.fill)),
            child: !isloading
                ? Stack(
                    children: [
                      IgnorePointer(
                        ignoring: !(_countDown == -1) || isEnd||summaring,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ButtonCustom(
                                    onTap: () {
                                      Navigator.pop(context, 1);
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/img/battletraining/back.png"))),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 180,
                                    height: 65,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/img/battletraining/cloudtitle.png"),
                                            fit: BoxFit.fill)),
                                    child: Text(
                                      "Ngôn Ngữ ${this.widget.topicsType.toUpperCase()}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Container(
                                    width: 50,
                                    height: 50,
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: 110,
                                    height: 65,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/img/battletraining/cloud.png"),
                                            fit: BoxFit.fill)),
                                    child: Text(
                                      "Level ${this.widget.level}",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 50,
                                    height: 50,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/img/battletraining/alarm.png"),
                                            fit: BoxFit.fill)),
                                    child: Text(
                                      "${time}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 110,
                                    height: 65,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/img/battletraining/cloud.png"),
                                            fit: BoxFit.fill)),
                                    child: Text(
                                      "$score",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(20),
                              margin: EdgeInsets.only(left: 20, right: 20),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battletraining/board.png"),
                                      fit: BoxFit.fill)),
                              constraints:
                                  BoxConstraints(minHeight: 200, minWidth: 320),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Câu ${index + 1}/${questions!.length}:",
                                        style: TextStyle(
                                            color: Colors.yellow,
                                            fontWeight: FontWeight.w700),
                                      )
                                    ],
                                  ),
                                  Text('${questions![index].title}',
                                  textAlign: TextAlign.center,
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: questions![index]
                                    .answers
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  final answerIndex = entry.key;
                                  final answer = entry.value;

                                  return InkWell(
                                    onTap: () {
                                      if (!isAnswer &&
                                          answer.answerText != "") {
                                        selectedAnswerIndex =
                                            answerIndex; // Lưu vị trí được chọn
                                        handleAnswer(answer.score);
                                        isAnswer = true;
                                      }
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: 25, right: 25, bottom: 5),
                                      padding: EdgeInsets.all(1.5),
                                      decoration: BoxDecoration(
                                          color: Colors
                                              .black, // Thay đổi màu tương ứng
                                          borderRadius:
                                              BorderRadius.circular(3)),
                                      child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: selectedAnswerIndex ==
                                                    answerIndex
                                                ? answer.score
                                                    ? Colors.green
                                                    : Colors.red
                                                : Colors
                                                    .white, // Thay đổi màu tương ứng
                                            borderRadius:
                                                BorderRadius.circular(3)),
                                        constraints: BoxConstraints(
                                            minHeight: 50, minWidth: 320),
                                        child: Center(
                                          child: Text(answer.answerText,
                                          textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w700)),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 5, right: 5, bottom: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  //5050
                                  Column(
                                    children: [
                                      ButtonCustom(
                                        onTap: () {
                                          handleFiftyFifty();
                                        },
                                        child: ColorFiltered(
                                          colorFilter: (gold! > 100 &&
                                                  !fiftyFiftyWasUsed)
                                              ? transparentscale
                                              : greyscale,
                                          child: Container(
                                            width: 65,
                                            height: 55,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/img/battletraining/50.png"),
                                                    fit: BoxFit.fill)),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "100",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Image.asset(
                                              "assets/img/maingame/gold.gif",
                                              fit: BoxFit.fill,
                                              width: 30,
                                              height: 30,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  //đạc biệt
                                  Column(
                                    children: [
                                      ButtonCustom(
                                        onTap: () {
                                          handleSpecial();
                                        },
                                        child: ColorFiltered(
                                          colorFilter:
                                              (gold! > 200 && !specialWasUsed)
                                                  ? transparentscale
                                                  : greyscale,
                                          child: Container(
                                            width: 65,
                                            height: 55,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/img/battletraining/special.png"),
                                                    fit: BoxFit.fill)),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "200",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Image.asset(
                                              "assets/img/maingame/gold.gif",
                                              fit: BoxFit.fill,
                                              width: 30,
                                              height: 30,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  //+5 giây
                                  Column(
                                    children: [
                                      ButtonCustom(
                                        onTap: () {
                                          handlePlusTime();
                                        },
                                        child: ColorFiltered(
                                          colorFilter:
                                              (gold! > 30 && !TimePlusWasUsed)
                                                  ? transparentscale
                                                  : greyscale,
                                          child: Container(
                                            width: 65,
                                            height: 55,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/img/battletraining/plustime.png"),
                                                    fit: BoxFit.fill)),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "30",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Image.asset(
                                              "assets/img/maingame/gold.gif",
                                              fit: BoxFit.fill,
                                              width: 30,
                                              height: 30,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  //x2 điểm
                                  Column(
                                    children: [
                                      ButtonCustom(
                                        onTap: () {
                                          handleDoubleScore();
                                        },
                                        child: ColorFiltered(
                                          colorFilter: (gold! > 50 &&
                                                  !doubleScoreWasUsed)
                                              ? transparentscale
                                              : greyscale,
                                          child: Container(
                                            width: 65,
                                            height: 55,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/img/battletraining/x2score.png"),
                                                    fit: BoxFit.fill)),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "50",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5),
                                            child: Image.asset(
                                              "assets/img/maingame/gold.gif",
                                              fit: BoxFit.fill,
                                              width: 30,
                                              height: 30,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      !(_countDown == -1)
                          ? Center(
                              child: Stack(
                                children: [
                                  Text(
                                    _countDown == 0
                                        ? "Bắt Đầu"
                                        : '$_countDown',
                                    style: TextStyle(
                                      fontSize: 50.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                    ),
                                  ),
                                  AnimatedBuilder(
                                    animation: _scaleAnimation,
                                    builder: (context, child) =>
                                        Transform.scale(
                                      scale: _scaleAnimation.value,
                                      child: child,
                                    ),
                                    child: AnimatedBuilder(
                                      animation: _opacityAnimation,
                                      builder: (context, child) => Opacity(
                                        opacity: _opacityAnimation.value,
                                        child: child,
                                      ),
                                      child: Text(
                                        _countDown == 0
                                            ? "Bắt Đầu"
                                            : '$_countDown',
                                        style: TextStyle(
                                          fontSize: 50.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : Container()
                    ],
                  )
                : Container(),
          ),
          isEnd
              ? Center(
                  child: Container(
                    color: Colors.transparent,
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 2,
                        ),
                        Positioned(
                          top: 40,
                          left: 10,
                          right: 10,
                          child: Container(
                            height: MediaQuery.of(context).size.height / 3,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/img/home/frame.png"),
                                    fit: BoxFit.fill)),
                            child: Center(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedBuilder(
                                    animation: _animationController,
                                    builder: (context, child) {
                                      final scale =
                                          _animationController.value * 0.01 +
                                              1.0;
                                      return Transform.scale(
                                        scale: scale,
                                        child: Image.asset(
                                          "assets/img/battletraining/${star}star.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              2.5,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          fit: BoxFit.fill,
                                        ),
                                      );
                                    }),
                                SizedBox(
                                  height: 30,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      children: [
                                        TweenAnimationBuilder<double>(
                                          tween: Tween<double>(
                                              begin: 0,
                                              end: goldEarned.toDouble()),
                                          duration: Duration(seconds: 2),
                                          builder: (context, value, child) {
                                            return Text(
                                              "+${value.round()}",
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            );
                                          },
                                        ),
                                        Image.asset(
                                          "assets/img/maingame/gold.gif",
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.fill,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 30,
                                    ),
                                    Row(
                                      children: [
                                        TweenAnimationBuilder<double>(
                                          tween: Tween<double>(
                                              begin: 0,
                                              end: expEarned.toDouble()),
                                          duration: Duration(seconds: 2),
                                          builder: (context, value, child) {
                                            return Text(
                                              "+${value.round()}",
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w800,
                                              ),
                                            );
                                          },
                                        ),
                                        Image.asset(
                                          "assets/img/home/exp.png",
                                          width: 40,
                                          height: 40,
                                          fit: BoxFit.fill,
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            )),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: MediaQuery.of(context).size.width / 6,
                          right: MediaQuery.of(context).size.width / 6,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 230,
                                height: 90,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/img/home/logo.gif"),
                                        fit: BoxFit.fill)),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: MediaQuery.of(context).size.height / 10,
                          left: MediaQuery.of(context).size.width / 10,
                          right: MediaQuery.of(context).size.width / 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: ButtonCustom(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height:
                                        MediaQuery.of(context).size.height / 15,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/img/home/button.png"),
                                            fit: BoxFit.fill)),
                                    child: Text(
                                      "Quay Về",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _countDown = 3;
                                      index = 0;
                                      score = 0;
                                      x2Score = 1;
                                      toolWasUsed = false;
                                      fiftyFiftyWasUsed = false;
                                      specialWasUsed = false;
                                      doubleScoreWasUsed = false;
                                      TimePlusWasUsed = false;
                                      isloading = false;
                                      isAnswer = false;
                                      isEnd = false;
                                      isCorrect = 0;
                                      selectedAnswerIndex = null;
                                      questions = null;
                                      isSumarry = false;
                                      _presenter.getGoldAndQuestion(
                                          this.widget.topicsType,
                                          this.widget.level);
                                    });
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    height:
                                        MediaQuery.of(context).size.height /
                                            15,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                "assets/img/home/button.png"),
                                            fit: BoxFit.fill)),
                                    child: Text(
                                      "Chơi Lại",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
          summaring
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: AnimatedTextKit(
                      repeatForever: true,
                      isRepeatingAnimation: true,
                      animatedTexts: [
                        TyperAnimatedText('Đang Tổng Kết...',
                            textAlign: TextAlign.center,
                            textStyle: TextStyle(
                                color: Color.fromARGB(255, 32, 32, 32),
                                fontSize: 15,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ))
              : Container()
        ],
      ),
    );
  }
}
