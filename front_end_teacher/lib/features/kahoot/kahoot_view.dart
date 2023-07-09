// ignore_for_file: must_be_immutable, unused_field

import 'package:flutter/material.dart';
import 'package:front_end_teacher/features/kahoot/kahoot_contract.dart';
import 'package:front_end_teacher/features/kahoot/kahoot_presenter.dart';
import 'package:front_end_teacher/models/QuestionTheme.dart';

import '../../models/Test.dart';

class KahootView extends StatefulWidget {
  Test test;
  KahootView({super.key, required this.test});

  @override
  State<KahootView> createState() => _KahootViewState();
}

class _KahootViewState extends State<KahootView> implements KahootContract {
  late KahootPresenter _presenter;
  _KahootViewState() {
    _presenter = KahootPresenter(this);
  }
  List<QuestionTheMe> questions = [];
  String testroom = "";
  var havePlayer = false;
  bool skipQuestion = false;
  bool lockroom = false;
  bool isShowBoard = false;
  bool isShowQuestion = false;
  bool isShowSummary = false;
  bool isWaitingPlayer = true;
  bool isCoutDown = false;
  int countPlayer = 0;
  int indexQuestion = 0;
  Map<String, dynamic> totalScore = {};
  int answerCount = 0;
  int answer1 = 0;
  int answer2 = 0;
  int answer3 = 0;
  int answer4 = 0;
  int totalAnswer = 0;
  List<QuestionTheMe> questionTheme = [];
  @override
  setisShowBoad(bool _isShowBoard) {
    isShowBoard = _isShowBoard;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  getCountPlayer() {
    return countPlayer;
  }

  @override
  decrementCountPlayer() {
    countPlayer--;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  incrementPlayer() {
    countPlayer++;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  sethavePlayer(bool _havePlayer) {
    havePlayer = _havePlayer;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  getHavePlayer() {
    return havePlayer;
  }

  @override
  incrementAnwer1() {
    answer1++;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  incrementAnwer2() {
    answer2++;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  incrementAnwer3() {
    answer3++;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  incrementAnwer4() {
    answer4++;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  getTotalScore() {
    return totalScore;
  }

  @override
  getIndexQuestion() {
    return indexQuestion;
  }

  @override
  void initState() {
    // totalScore["456"] = {
    //   "totalscore": 0,
    //   "name": "john",
    //   "answer1": {
    //     "score": 0,
    //   },
    //   "answer2": {
    //     "score": 0,
    //   },
    //   "answer3": {
    //     "score": 0,
    //   },
    //   "answer4": {
    //     "score": 0,
    //   },
    // };
    // print(totalScore["456"]?["name"]);
    // totalScore["123"]?["answer1"]?["score"] = 10;
    // print(totalScore["123"]?["answer1"]?["score"]);
    _presenter.GetQuestionAndCodeRoom(this.widget.test.id);
    super.initState();
  }

  @override
  incrementTotalAnswer() {
    answerCount++;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setListQuestion(List<QuestionTheMe> questionList) {
    questionTheme = questionList;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setIdRoom(String idRoom) {
    testroom = idRoom;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  getLockRoom() {
    return lockroom;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isWaitingPlayer
          ? Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF05007a), Color(0xFF4d007d)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                  image: DecorationImage(
                      image: AssetImage("assets/img/star.png"),
                      fit: BoxFit.cover)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.8,
                          height: MediaQuery.of(context).size.height / 9,
                          color: Color.fromARGB(255, 249, 242, 242),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                "Mã Code",
                                style: TextStyle(
                                    fontFamily: 'Mitr',
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                testroom == "" ? "Đang tải..." : testroom,
                                style: TextStyle(
                                    fontFamily: 'Mitr',
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  lockroom = !lockroom;
                                  setState(() {});
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width / 7,
                                  height: MediaQuery.of(context).size.width / 7,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        spreadRadius: 0,
                                        blurRadius: 10,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Image.asset(
                                    lockroom
                                        ? "assets/img/lock.png"
                                        : "assets/img/padlock.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  if (countPlayer > 0) {
                                    lockroom = true;
                                    setState(() {});
                                    //coutdown();
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  padding: EdgeInsets.all(10),
                                  alignment: Alignment.center,
                                  width: MediaQuery.of(context).size.width / 3,
                                  height: MediaQuery.of(context).size.width / 7,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black,
                                        spreadRadius: 0,
                                        blurRadius: 10,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Text(
                                    "Bắt Đầu",
                                    style: TextStyle(
                                        fontFamily: 'Mitr',
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.6,
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        direction:
                            Axis.horizontal, // Hướng của các phần tử trong lưới
                        alignment: WrapAlignment.center, // Canh giữa lưới
                        runAlignment: WrapAlignment.center,
                        spacing:
                            8, // Khoảng cách giữa các phần tử theo chiều ngang
                        runSpacing:
                            8, // Khoảng cách giữa các phần tử theo chiều dọc
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 254, 254, 254),
                                borderRadius: BorderRadius.circular(5)),
                            constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width / 2.2),
                            padding: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width / 8,
                                  height: MediaQuery.of(context).size.width / 8,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/img/smiling.png"),
                                          fit: BoxFit.fill)),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 3.4,
                                  child: Text(
                                    "Phạm Ngọc Phong",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'Mitr',
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          )
                          // Container(

                          //         alignment: Alignment.center,
                          //         width: MediaQuery.of(context).size.width / 1.5,
                          //         height: MediaQuery.of(context).size.width / 7,
                          //         decoration: BoxDecoration(
                          //           color: Color.fromARGB(255, 119, 32, 250),
                          //           borderRadius: BorderRadius.circular(5),
                          //           boxShadow: [
                          //             BoxShadow(
                          //               color: Colors.black,
                          //               spreadRadius: 0,
                          //               blurRadius: 10,
                          //               offset: Offset(0, 3),
                          //             ),
                          //           ],
                          //         ),
                          //         child: Text(
                          //           "Đang chờ người chơi ...",
                          //           style: TextStyle(
                          //               fontFamily: 'Mitr',
                          //               color: Color.fromARGB(255, 255, 255, 255),
                          //               fontSize: 18,
                          //               fontWeight: FontWeight.w500),
                          //         ),
                          //       ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: MediaQuery.of(context).size.height / 13,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 135, 129, 143),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset(
                            "assets/img/player-count.png",
                            width: MediaQuery.of(context).size.width / 15,
                            height: MediaQuery.of(context).size.height / 30,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Text(
                          "0",
                          style: TextStyle(
                              fontFamily: 'Mitr',
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontSize: 22,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          : isShowBoard
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            if (indexQuestion < questionTheme.length - 1) {
                              indexQuestion++;
                              //coutdown();
                            } else {
                              //summary();
                            }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(
                                top: 5, left: 10, right: 10, bottom: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(
                              "Tiếp Theo",
                              style: TextStyle(
                                  fontFamily: 'Mitr',
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2,
                        constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height / 15),
                        color: Colors.white,
                        child: Text(
                          "Bảng Điểm",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Mitr',
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(5),
                              margin: EdgeInsets.only(left: 10, right: 10),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 10,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/img/smiling.png"),
                                                fit: BoxFit.fill)),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2,
                                        child: Text(
                                          "Phạm Ngọc Phong",
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: 'Mitr',
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "50 điểm",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontFamily: 'Mitr',
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : isShowQuestion
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.only(
                                    top: 5, left: 10, right: 10, bottom: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(
                                  "Tiếp Theo",
                                  style: TextStyle(
                                      fontFamily: 'Mitr',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 1.2,
                              constraints: BoxConstraints(
                                  minHeight:
                                      MediaQuery.of(context).size.height / 9),
                              color: Colors.white,
                              child: Text(
                                "Tiếp Theo",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Mitr',
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 1.6,
                              height: MediaQuery.of(context).size.width / 1.6,
                              color: Colors.white,
                              child: Text(
                                "Tiếp Theo",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontFamily: 'Mitr',
                                    color: Color.fromARGB(255, 0, 0, 0),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.width / 8,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(100000)),
                                child: Text(
                                  "30",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Mitr',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 6,
                                height: MediaQuery.of(context).size.height / 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      color: Colors.red,
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5 -
                                          MediaQuery.of(context).size.height /
                                              25,
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              30,
                                      color: Colors.red,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                            "assets/img/square.png",
                                            width: 10,
                                            height: 10,
                                          ),
                                          Text(
                                            "30",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Mitr',
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Image.asset(
                                            "assets/img/tick.png",
                                            width: 10,
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 6,
                                height: MediaQuery.of(context).size.height / 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      color: Colors.blue,
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5 -
                                          MediaQuery.of(context).size.height /
                                              25,
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              30,
                                      color: Colors.blue,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                            "assets/img/plain-triangle.png",
                                            width: 10,
                                            height: 10,
                                          ),
                                          Text(
                                            "30",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Mitr',
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Image.asset(
                                            "assets/img/tick.png",
                                            width: 10,
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 6,
                                height: MediaQuery.of(context).size.height / 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      color: Colors.amber,
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5 -
                                          MediaQuery.of(context).size.height /
                                              25,
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              30,
                                      color: Colors.amber,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                            "assets/img/rhombus.png",
                                            width: 10,
                                            height: 10,
                                          ),
                                          Text(
                                            "30",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Mitr',
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Image.asset(
                                            "assets/img/tick.png",
                                            width: 10,
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 6,
                                height: MediaQuery.of(context).size.height / 5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      color: Colors.green,
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5 -
                                          MediaQuery.of(context).size.height /
                                              25,
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              30,
                                      color: Colors.green,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Image.asset(
                                            "assets/img/circle.png",
                                            width: 10,
                                            height: 10,
                                          ),
                                          Text(
                                            "30",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Mitr',
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                fontSize: 13,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Image.asset(
                                            "assets/img/tick.png",
                                            width: 10,
                                            height: 10,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 8,
                                height: MediaQuery.of(context).size.width / 8,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(100000)),
                                child: Text(
                                  "30",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Mitr',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              )
                            ],
                          ),
                          Opacity(
                            opacity: 1,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              width: MediaQuery.of(context).size.width / 1.1,
                              constraints: BoxConstraints(
                                minHeight:
                                    MediaQuery.of(context).size.height / 10,
                              ),
                              color: Colors.red,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/img/circle.png",
                                    width:
                                        MediaQuery.of(context).size.width / 15,
                                    height:
                                        MediaQuery.of(context).size.width / 15,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width /
                                            1.1 -
                                        ((MediaQuery.of(context).size.width /
                                                9) *
                                            2),
                                    child: Text(
                                      "assets/img/tick.pngassets/img/tick.png",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Mitr',
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/img/tick.png",
                                    width:
                                        MediaQuery.of(context).size.width / 15,
                                    height:
                                        MediaQuery.of(context).size.width / 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: 1,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              width: MediaQuery.of(context).size.width / 1.1,
                              constraints: BoxConstraints(
                                minHeight:
                                    MediaQuery.of(context).size.height / 10,
                              ),
                              color: Colors.blue,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/img/plain-triangle.png",
                                    width:
                                        MediaQuery.of(context).size.width / 15,
                                    height:
                                        MediaQuery.of(context).size.width / 15,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width /
                                            1.1 -
                                        ((MediaQuery.of(context).size.width /
                                                9) *
                                            2),
                                    child: Text(
                                      "assets/img/tick.pngassets/img/tick.png",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Mitr',
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/img/tick.png",
                                    width:
                                        MediaQuery.of(context).size.width / 15,
                                    height:
                                        MediaQuery.of(context).size.width / 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: 1,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              width: MediaQuery.of(context).size.width / 1.1,
                              constraints: BoxConstraints(
                                minHeight:
                                    MediaQuery.of(context).size.height / 10,
                              ),
                              color: Colors.amber,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/img/rhombus.png",
                                    width:
                                        MediaQuery.of(context).size.width / 15,
                                    height:
                                        MediaQuery.of(context).size.width / 15,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width /
                                            1.1 -
                                        ((MediaQuery.of(context).size.width /
                                                9) *
                                            2),
                                    child: Text(
                                      "assets/img/tick.pngassets/img/tick.png",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Mitr',
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/img/tick.png",
                                    width:
                                        MediaQuery.of(context).size.width / 15,
                                    height:
                                        MediaQuery.of(context).size.width / 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Opacity(
                            opacity: 1,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              margin: EdgeInsets.only(top: 5, bottom: 5),
                              width: MediaQuery.of(context).size.width / 1.1,
                              constraints: BoxConstraints(
                                minHeight:
                                    MediaQuery.of(context).size.height / 10,
                              ),
                              color: Colors.green,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    "assets/img/circle.png",
                                    width:
                                        MediaQuery.of(context).size.width / 15,
                                    height:
                                        MediaQuery.of(context).size.width / 15,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width /
                                            1.1 -
                                        ((MediaQuery.of(context).size.width /
                                                9) *
                                            2),
                                    child: Text(
                                      "assets/img/tick.pngassets/img/tick.png",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Mitr',
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/img/tick.png",
                                    width:
                                        MediaQuery.of(context).size.width / 15,
                                    height:
                                        MediaQuery.of(context).size.width / 15,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : isShowSummary
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.only(
                                      top: 5, left: 10, right: 10, bottom: 5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "quay về",
                                    style: TextStyle(
                                        fontFamily: 'Mitr',
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 8.0, bottom: 8.0),
                              child: Container(
                                padding: EdgeInsets.all(10),
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 1.5,
                                constraints: BoxConstraints(
                                    minHeight:
                                        MediaQuery.of(context).size.height /
                                            15),
                                color: Colors.white,
                                child: Text(
                                  "bài kiểm tra web lần 1",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'Mitr',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 1.3,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(5),
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      width: MediaQuery.of(context).size.width,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              10,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    8,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    8,
                                                decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                        image: AssetImage(
                                                            "assets/img/smiling.png"),
                                                        fit: BoxFit.fill)),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: Text(
                                                  "Phạm Ngọc Phong",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 0, 0, 0),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            "50 điểm",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: 'Mitr',
                                                color: const Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      : isCoutDown
                          ? Center(
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(100000000000),
                                    border: Border.all(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        width: 3)),
                                child: Text(
                                  "3",
                                  style: TextStyle(
                                      fontFamily: 'Mitr',
                                      color: Color.fromARGB(255, 0, 0, 0),
                                      fontSize: 50,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            )
                          : Container(),
    );
  }
}

class TotalScore {
  int totalScore;
  String name;
  Map<String, dynamic> answers;

  TotalScore({
    required this.totalScore,
    required this.name,
    required this.answers,
  });
}
