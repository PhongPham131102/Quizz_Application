import 'dart:math';

import 'package:flutter/material.dart';
import 'package:frontend_flutter/components/Button.dart';
import 'package:frontend_flutter/components/TextCustom.dart';
import 'package:frontend_flutter/features/battle/battle_contract.dart';
import 'package:frontend_flutter/features/battle/battle_presenter.dart';
import 'package:frontend_flutter/features/result/result_view.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../components/FlowerMoveFreely.dart';
import '../../constants.dart';
import '../../models/Match.dart';
import '../../models/Profile.dart';
import '../../models/Question.dart';

// ignore: must_be_immutable
class BattleView extends StatefulWidget {
  Profile you;
  Profile rival;
  String idRoom;
  String topic;
  List<Question>? questions;
  int? rivalScore;
  int? yourScore;
  BattleView({
    super.key,
    required this.you,
    required this.rival,
    required this.idRoom,
    required this.topic,
    this.questions,
    this.rivalScore,
    this.yourScore,
  });

  @override
  State<BattleView> createState() => _BattleViewState();
}

class _BattleViewState extends State<BattleView>
    with TickerProviderStateMixin
    implements BattleContract {
  late BattlePresenter _presenter;
  List<Question> questions = [
    Question(
        id: "id",
        title: "Đang tải...",
        answers: [
          Answer(answerText: "Đang tải...", score: false, id: ""),
          Answer(answerText: "Đang tải...", score: false, id: ""),
          Answer(answerText: "Đang tải...", score: false, id: ""),
          Answer(answerText: "Đang tải...", score: false, id: "")
        ],
        difficulty: 1,
        score: 12,
        image: "image",
        typeQuestion: "typeQuestion",
        typeLanguage: "typeLanguage",
        level: 1,
        idPost: "idPost",
        createdAt: DateTime.now(),
        updatedAt: DateTime.now())
  ];
  int index = 0;
  bool youAnswered = false;
  _BattleViewState() {
    _presenter = BattlePresenter(this);
  }
  IO.Socket socket =
      IO.io('${baseUrl.replaceAll("/api", "")}', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
  });
  int yourScore = 0;
  int rivalScore = 0;
  int time = 10;
  int? yourSelectedAnswerIndex;
  int? rivalSelectedAnswerIndex;
  @override
  setTime(int _time) {
    time = _time;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setRivalScore(int _rivalScore) {
    if (mounted) {
      setState(() {
        _isRivalScorecontrollerForwarded = true;
        RivalScore1 = _rivalScore;
        _RivalScorecontroller.reset();
        _RivalScorecontroller.forward();
        rivalScore += _rivalScore;
      });
    }
  }

  @override
  setYourScore(int _yourScore) {
    setState(() {
      _isYourScorecontrollerForwarded = true;
      YourScore1 = _yourScore;
    });
    _YourScorecontroller.reset();
    _YourScorecontroller.forward();
    yourScore += _yourScore;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setRivalSelectedAnswerIndex(_rivalSelectedAnswerIndex) {
    rivalSelectedAnswerIndex = _rivalSelectedAnswerIndex;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setyourSelectedAnswerIndex(_yourSelectedAnswerIndex) {
    yourSelectedAnswerIndex = _yourSelectedAnswerIndex;
    if (mounted) {
      setState(() {});
    }
  }

  late AnimationController _Vscontroller;
  late Animation<double> _Vsanimation;
  late AnimationController _Rotatecontroller;
  late Animation<double> _Rotateanimation;
  late AnimationController _YourScorecontroller;
  late Animation<double> _YourScoreanimation;
  int YourScore1 = 0;
  bool _isYourScorecontrollerForwarded = false;
  late Animation<double> _YourScoreOpacityanimation;
  late AnimationController _RivalScorecontroller;
  late Animation<double> _RivalScoreanimation;
  late Animation<double> _RivalScoreOpacityanimation;
  bool _isRivalScorecontrollerForwarded = false;
  int RivalScore1 = 0;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _YourScoreanimation = Tween(
            begin: 0.0, end: -MediaQuery.of(context).size.height / 20)
        .animate(
            CurvedAnimation(parent: _YourScorecontroller, curve: Curves.ease))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _isYourScorecontrollerForwarded = false;
          setState(() {});
        }
      });
    ;
    _YourScoreOpacityanimation = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _YourScorecontroller, curve: Curves.ease));
    _RivalScorecontroller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _RivalScoreanimation = Tween(
            begin: 0.0, end: -MediaQuery.of(context).size.height / 20)
        .animate(
            CurvedAnimation(parent: _RivalScorecontroller, curve: Curves.ease))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _isRivalScorecontrollerForwarded = false;
          setState(() {});
        }
      });
    _RivalScoreOpacityanimation = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _RivalScorecontroller, curve: Curves.ease));
  }

  @override
  void initState() {
    _Vscontroller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _Vsanimation = Tween(begin: 1.0, end: 1.2).animate(
        CurvedAnimation(parent: _Vscontroller, curve: Curves.elasticOut));
    _Vscontroller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _Vscontroller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _Vscontroller.forward();
      }
    });
    _Vscontroller.forward();
    _Rotatecontroller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _Rotateanimation = Tween(begin: -10.0, end: 10.0).animate(
        CurvedAnimation(parent: _Rotatecontroller, curve: Curves.easeIn));
    _Rotatecontroller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _Rotatecontroller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _Rotatecontroller.forward();
      }
    });
    _Rotatecontroller.forward();
    _YourScorecontroller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    if (this.widget.questions != null && this.widget.questions!.isNotEmpty) {
      questions = [];
      questions = this.widget.questions!;
      if (mounted) {
        setState(() {});
      }
    }
    if (this.widget.rivalScore != null) {
      rivalScore = this.widget.rivalScore!;
      if (mounted) {
        setState(() {});
      }
    }
    if (this.widget.yourScore != null) {
      yourScore = this.widget.yourScore!;
      if (mounted) {
        setState(() {});
      }
    }
    _presenter.CountDown(this.widget.idRoom);
    super.initState();
  }

  @override
  IO.Socket getSocket() {
    return socket;
  }

  @override
  setIndex(int _index) {
    index = _index;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  pushResult(MatchBattle match) {
    if (mounted) {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReSultView(
                match: match,
                you: this.widget.you,
                rival: this.widget.rival,
                topic: this.widget.topic),
          ));
    }
  }

  @override
  int getIndex() {
    return index;
  }

  @override
  setYouAnswered(bool _youAnswered) {
    youAnswered = _youAnswered;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setListQuestion(List<Question> _questions) {
    questions = [];
    questions = _questions;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _Vscontroller.dispose();
    _Rotatecontroller.dispose();
    _RivalScorecontroller.dispose();
    _YourScorecontroller.dispose();
    socket.off("Questions${this.widget.idRoom}");
    socket.off("TimerRoom${this.widget.idRoom}");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int numberOfFlowerFreeMoves = random.nextInt(3) + 2;
    return Scaffold(
        body: Container(
      padding: EdgeInsets.only(top: 30),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/img/battle/bg2.png"),
              fit: BoxFit.fill)),
      child: Stack(
        children: [
          ...List.generate(numberOfFlowerFreeMoves, (_) {
            return FlowerFreeMove(
                maxWidth: MediaQuery.of(context).size.width,
                maxHeight: MediaQuery.of(context).size.height);
          }),
          Column(
            children: [
              Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 10,
                      ),
                      Positioned(
                        left: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 10,
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.height / 10,
                              ),
                              Positioned(
                                right: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      this.widget.you.name,
                                      style: TextStyle(
                                        fontFamily: 'Mitr',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          30,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 201, 106, 11),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      alignment: Alignment.center,
                                      child: Text(
                                        yourScore.toString(),
                                        style: TextStyle(
                                            fontFamily: 'Mitr',
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height /
                                    10 *
                                    0.1,
                                bottom: MediaQuery.of(context).size.height /
                                    10 *
                                    0.1,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: AnimatedBuilder(
                                      animation: _Rotatecontroller,
                                      builder: (context, child) {
                                        return Transform.rotate(
                                          angle:
                                              _Rotateanimation.value * pi / 180,
                                          child: Image.asset(
                                            "assets/img/battle/${this.widget.you.gender}.png",
                                          ),
                                        );
                                      }),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: MediaQuery.of(context).size.height / 10,
                          child: Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.height / 10,
                              ),
                              Positioned(
                                left: 10,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      this.widget.rival.name,
                                      style: TextStyle(
                                        fontFamily: 'Mitr',
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          30,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 201, 106, 11),
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      alignment: Alignment.center,
                                      child: Text(
                                        rivalScore.toString(),
                                        style: TextStyle(
                                            fontFamily: 'Mitr',
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: MediaQuery.of(context).size.height /
                                    10 *
                                    0.1,
                                bottom: MediaQuery.of(context).size.height /
                                    10 *
                                    0.1,
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30)),
                                  child: AnimatedBuilder(
                                      animation: _Rotatecontroller,
                                      builder: (context, child) {
                                        return Transform.rotate(
                                          angle:
                                              _Rotateanimation.value * pi / 180,
                                          child: Image.asset(
                                            "assets/img/battle/${this.widget.rival.gender}.png",
                                          ),
                                        );
                                      }),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          child: AnimatedBuilder(
                              animation: _Vscontroller,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _Vsanimation.value,
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                      alignment: Alignment.bottomCenter,
                                      child: Image.asset(
                                        "assets/img/battle/vs2.png",
                                        width: 50,
                                        height: 50,
                                      )),
                                );
                              }))
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 4),
                    child: AnimatedBuilder(
                        animation: _YourScorecontroller,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _YourScoreanimation.value),
                            child: Opacity(
                              opacity: _isYourScorecontrollerForwarded
                                  ? _YourScoreOpacityanimation.value
                                  : 0,
                              child: CustomText("+" + YourScore1.toString(),
                                  style: TextStyle(
                                      fontFamily: 'Mitr',
                                      color: Color(0xffFEDB10),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800)),
                            ),
                          );
                        }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.width / 4),
                    child: AnimatedBuilder(
                        animation: _RivalScorecontroller,
                        builder: (context, child) {
                          return Transform.translate(
                            offset: Offset(0, _RivalScoreanimation.value),
                            child: Opacity(
                              opacity: _isRivalScorecontrollerForwarded
                                  ? _RivalScoreOpacityanimation.value
                                  : 0,
                              child: CustomText("+" + RivalScore1.toString(),
                                  style: TextStyle(
                                      fontFamily: 'Mitr',
                                      color: Color(0xffFEDB10),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800)),
                            ),
                          );
                        }),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(25)),
                      child: Text(
                        time.toString(),
                        style: TextStyle(
                            fontFamily: 'Mitr',
                            fontSize: 18,
                            color: Colors.black,
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
                        image: AssetImage("assets/img/iconquestion/board.png"),
                        fit: BoxFit.fill)),
                constraints: BoxConstraints(minHeight: 200, minWidth: 320),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Câu ${index + 1}/${questions.length}:",
                          style: TextStyle(
                              fontFamily: 'Mitr',
                              color: Colors.yellow,
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    Text(questions == [] ? "" : questions[index].title,
                        style: TextStyle(
                            fontFamily: 'Mitr',
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
                padding: const EdgeInsets.only(top: 15, bottom: 15.0),
                child: Column(
                  children:
                      questions[index].answers.asMap().entries.map((entry) {
                    final answerIndex = entry.key;
                    final answer = entry.value;

                    return ButtonCustom(
                      onTap: () => _presenter.handlerAnswer(
                          index,
                          answerIndex,
                          answer.score,
                          youAnswered,
                          time,
                          this.widget.idRoom,
                          answer.id),
                      isButton: false,
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: 25, right: 25, bottom: 5, top: 5),
                            padding: EdgeInsets.all(1.5),
                            decoration: BoxDecoration(
                                color: Colors.black, // Thay đổi màu tương ứng
                                borderRadius: BorderRadius.circular(3)),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: youAnswered
                                      ? (yourSelectedAnswerIndex == answerIndex)
                                          ? answer.score
                                              ? Colors.green
                                              : Colors.red
                                          : (rivalSelectedAnswerIndex ==
                                                  answerIndex)
                                              ? answer.score
                                                  ? Colors.green
                                                  : Colors.red
                                              : Colors.white
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(3)),
                              constraints:
                                  BoxConstraints(minHeight: 50, minWidth: 320),
                              child: Center(
                                child: Text(answer.answerText,
                                    style: TextStyle(
                                        fontFamily: 'Mitr',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700)),
                              ),
                            ),
                          ),
                          youAnswered
                              ? yourSelectedAnswerIndex == answerIndex
                                  ? Positioned(
                                      left: 5,
                                      top: 10,
                                      bottom: 10,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/img/battle/${this.widget.rival.gender}.png"),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container()
                              : Container(),
                          youAnswered
                              ? rivalSelectedAnswerIndex == answerIndex
                                  ? Positioned(
                                      right: 5,
                                      top: 10,
                                      bottom: 10,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/img/battle/${this.widget.you.gender}.png"),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Container()
                              : Container(),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
