// ignore_for_file: must_be_immutable, unused_field, unused_local_variable

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:front_end_teacher/components/ButtonCustom.dart';
import 'package:front_end_teacher/features/kahoot/kahoot_contract.dart';
import 'package:front_end_teacher/features/kahoot/kahoot_presenter.dart';
import 'package:front_end_teacher/models/QuestionTheme.dart';

import '../../constants.dart';
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
   Random random = Random();
  //mã phòng
  String testroom = "";
  //biến kiểm tra xem có người chơi không
  var havePlayer = false;
  //biến xem xét bỏ qua câu hỏi
  bool skipQuestion = false;
  //biến khóa phòng
  bool lockroom = false;
  //biến xem xét hiển thị bảng điểm từng câu hỏi
  bool isShowBoard = false;
  //biến thời gian câu hỏi
  int time = 99;
  //biến xem xét hiển thị câu hỏi
  bool isShowQuestion = false;
  //biến xem xét hiển thị tổng kết bài
  bool isShowSummary = false;
  //biến xem xét đợi người chơi đồng thời nhận mã phòng từ server
  bool isWaitingPlayer = true;
  //biến xem xét đếm ngược thời gian
  bool isCoutDown = false;
  //biến đếm số người chơi đã tham gia
  int countPlayer = 0;
  //biến xét vị trí câu hỏi sẽ hiển thị
  int indexQuestion = 0;
  //biến map lưu dữ liệu người chơi và số điểm của người chơi qua từng câu hỏi và tổng điểm
  Map<String, dynamic> totalScore = {};
  //biến đếm số người trả lời câu hỏi đó
  int answerCount = 0;
  //biến đếm số lượng người trả lời câu hỏi 1
  int answer1 = 0;
  //biến đếm số lượng người trả lời câu hỏi 2
  int answer2 = 0;
  //biến đếm số lượng người trả lời câu hỏi 3
  int answer3 = 0;
  //biến đếm số lượng người trả lời câu hỏi 4
  int answer4 = 0;
  int coutdown = 99;
  //mảng chứa danh sách các câu hỏi
  List<QuestionTheMe> questionTheme = [];
  @override
  setSkipQuestion(bool value) {
    skipQuestion = value;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setIsSummary() {
    isShowBoard = false;
    isShowQuestion = false;
    isShowSummary = true;
    isWaitingPlayer = false;
    isCoutDown = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setisShowQuestion() {
    isShowBoard = false;
    isShowQuestion = true;
    isShowSummary = false;
    isWaitingPlayer = false;
    isCoutDown = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setValueCoutdown(int i) {
    coutdown = i;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setIsCoutdown() {
    isShowBoard = false;
    isShowQuestion = false;
    isShowSummary = false;
    isWaitingPlayer = false;
    isCoutDown = true;
    if (mounted) {
      setState(() {});
    }
  }

  //hàm đặt lại indexquestion
  @override
  setIndexQuestion(int index) {
    indexQuestion = index;
    if (mounted) {
      setState(() {});
    }
  }

  //hàm lấy loại bài tổng kết
  @override
  getTypePost() {
    return this.widget.test.typePost;
  }

//hàm đặt thời gian
  @override
  setTime(int _time) {
    time = _time;
    if (mounted) {
      setState(() {});
    }
  }

//hàm lấy danh sách câu hỏi
  @override
  getListQuestion() {
    return questionTheme;
  }

//hàm reset lại các biến đếm câu trả lời khi reset
  @override
  resetAnswer() {
    answerCount = 0;
    answer1 = 0;
    answer2 = 0;
    answer3 = 0;
    answer4 = 0;
    if (mounted) {
      setState(() {});
    }
  }

  //hàm hiển thị giao diện bảng tổng điểm câu hỏi
  @override
  setisShowBoad(bool _isShowBoard) {
    isShowBoard = _isShowBoard;
    if (mounted) {
      setState(() {});
    }
  }

  //hàm đếm số người chơi hiện có trong phòng
  @override
  getCountPlayer() {
    return countPlayer;
  }

  //hàm giảm số người chơi trong phòng
  @override
  decrementCountPlayer() {
    countPlayer--;
    if (mounted) {
      setState(() {});
    }
  }

  //hàm tăng số người chơi trong phòng
  @override
  incrementPlayer() {
    countPlayer++;
    if (mounted) {
      setState(() {});
    }
  }

  //hàm xét giá trị có người chơi trong phòng
  @override
  sethavePlayer(bool _havePlayer) {
    havePlayer = _havePlayer;
    if (mounted) {
      setState(() {});
    }
  }

  //hàm lấy giá trị có người chơi trong phòng
  @override
  getHavePlayer() {
    return havePlayer;
  }

  //hàm tăng số câu trả lời 1
  @override
  incrementAnwer1() {
    answer1++;
    if (mounted) {
      setState(() {});
    }
  }

//hàm tăng số câu trả lời 2
  @override
  incrementAnwer2() {
    answer2++;
    if (mounted) {
      setState(() {});
    }
  }

//hàm tăng số câu trả lời 3
  @override
  incrementAnwer3() {
    answer3++;
    if (mounted) {
      setState(() {});
    }
  }

  //hàm tăng số câu trả lời 4
  @override
  incrementAnwer4() {
    answer4++;
    if (mounted) {
      setState(() {});
    }
  }

  //hàm lấy map số điểm trả lời
  @override
  getTotalScore() {
    return totalScore;
  }

  //hàm lấy vị trí câu hỏi
  @override
  int getIndexQuestion() {
    return indexQuestion;
  }

  @override
  void dispose() {
    _presenter.dispose();
    super.dispose();
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

  //hàm tăng số câu trả lời
  @override
  incrementTotalAnswer() {
    answerCount++;
    if (mounted) {
      setState(() {});
    }
  }

  //hàm gán giá trị danh sách câu hỏi
  @override
  setListQuestion(List<QuestionTheMe> questionList) {
    questionTheme = questionList;
    if (mounted) {
      setState(() {});
    }
  }

  //hàm gán giá trị id phòng
  @override
  setIdRoom(String idRoom) {
    testroom = idRoom;
    if (mounted) {
      setState(() {});
    }
  }

  //lấy giá trị phòng có bị khóa không
  @override
  getLockRoom() {
    return lockroom;
  }

  List<MapEntry<String, dynamic>> sortedEntries = [];
  @override
  SetsortedEntries(List<MapEntry<String, dynamic>> _sortedEntries) {
    sortedEntries = [];
    sortedEntries = _sortedEntries;
    print(sortedEntries);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
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
            child: isWaitingPlayer
                ? Column(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Mã Code",
                                    style: TextStyle(
                                        fontFamily: 'Mitr',
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    testroom == "" ? "Đang tải..." : testroom,
                                    style: TextStyle(
                                        fontFamily: 'Mitr',
                                        color:
                                            const Color.fromARGB(255, 0, 0, 0),
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
                                      width:
                                          MediaQuery.of(context).size.width / 7,
                                      height:
                                          MediaQuery.of(context).size.width / 7,
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
                                        _presenter.coutdown();
                                      }
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(left: 10, right: 10),
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height:
                                          MediaQuery.of(context).size.width / 7,
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
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
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
                            direction: Axis
                                .horizontal, // Hướng của các phần tử trong lưới
                            alignment: WrapAlignment.center, // Canh giữa lưới
                            runAlignment: WrapAlignment.center,
                            spacing:
                                8, // Khoảng cách giữa các phần tử theo chiều ngang
                            runSpacing:
                                8, // Khoảng cách giữa các phần tử theo chiều dọc
                            children: [
                              ...totalScore.keys.map((key) {
                                final value = totalScore[key];

                                return ButtonCustom(
                                  onTap: () {
                                    String uid = key;
                                    _presenter.kickOut(uid);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 254, 254, 254),
                                        borderRadius: BorderRadius.circular(5)),
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width /
                                                2.2),
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
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
                                                      "assets/img/${random.nextInt(15) + 1}.png"),
                                                  fit: BoxFit.fill)),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.4,
                                          child: Text(
                                            "${value['name']}",
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
                                  ),
                                );
                              }).toList(),
                              if (!havePlayer)
                                Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  height: MediaQuery.of(context).size.width / 7,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 119, 32, 250),
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
                                    "Đang chờ người chơi ...",
                                    style: TextStyle(
                                        fontFamily: 'Mitr',
                                        color:
                                            Color.fromARGB(255, 255, 255, 255),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
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
                              "${countPlayer}",
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
                  )
                : isShowBoard
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  if (indexQuestion <
                                      questionTheme.length - 1) {
                                    indexQuestion++;
                                    _presenter.coutdown();
                                  } else {
                                    _presenter.Summary();
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
                            padding:
                                const EdgeInsets.only(top: 8.0, bottom: 8.0),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2,
                              constraints: BoxConstraints(
                                  minHeight:
                                      MediaQuery.of(context).size.height / 15),
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
                                children: sortedEntries.map((entry) {
                                  final key = entry.key;
                                  final value = entry.value;
                                  final name = value['name'];
                                  final score =
                                      value['answer${indexQuestion + 1}']
                                          ['score'];

                                  return Container(
                                    padding: EdgeInsets.all(5),
                                    margin: EdgeInsets.only(
                                        left: 10, right: 10, top: 5, bottom: 5),
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height / 10,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
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
                                                      "assets/img/${random.nextInt(15) + 1}.png"),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 5),
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Text(
                                                name,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontFamily: 'Mitr',
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          '$score điểm',
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            color: const Color.fromARGB(
                                                255, 0, 0, 0),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
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
                                    InkWell(
                                      onTap: () =>
                                          _presenter.functionSkipQuestion(),
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.only(
                                            top: 5,
                                            left: 10,
                                            right: 10,
                                            bottom: 5),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "Tiếp Theo",
                                          style: TextStyle(
                                              fontFamily: 'Mitr',
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8.0),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    constraints: BoxConstraints(
                                        minHeight:
                                            MediaQuery.of(context).size.height /
                                                9),
                                    color: Colors.white,
                                    child: Text(
                                      "${questionTheme[indexQuestion].title}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'Mitr',
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                questionTheme[indexQuestion].image != ""
                                    ? Padding(
                                        padding: const EdgeInsets.only(
                                            top: 8.0, bottom: 8.0),
                                        child: Image.network(
                                          '${baseUrl.replaceAll("/api", "")}/${questionTheme[indexQuestion].image}',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.6,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.6,
                                        ),
                                      )
                                    : Container(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.center,
                                      width:
                                          MediaQuery.of(context).size.width / 8,
                                      height:
                                          MediaQuery.of(context).size.width / 8,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100000)),
                                      child: Text(
                                        "${time}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Mitr',
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Container(
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            color: Colors.red,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            height: (MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        5 -
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        25) *
                                                (answer1 / countPlayer),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
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
                                                  "${answer1}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Image.asset(
                                                  questionTheme[indexQuestion]
                                                          .answers[0]
                                                          .score
                                                      ? "assets/img/tick.png"
                                                      : "assets/img/wrong.png",
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
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            color: Colors.blue,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            height: (MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        5 -
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        25) *
                                                (answer2 / countPlayer),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
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
                                                  "${answer2}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Image.asset(
                                                  questionTheme[indexQuestion]
                                                          .answers[1]
                                                          .score
                                                      ? "assets/img/tick.png"
                                                      : "assets/img/wrong.png",
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
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            color: Colors.amber,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            height: (MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        5 -
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        25) *
                                                (answer3 / countPlayer),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
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
                                                  "${answer3}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Image.asset(
                                                  questionTheme[indexQuestion]
                                                          .answers[2]
                                                          .score
                                                      ? "assets/img/tick.png"
                                                      : "assets/img/wrong.png",
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
                                      width:
                                          MediaQuery.of(context).size.width / 6,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(bottom: 5),
                                            color: Colors.green,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            height: (MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        5 -
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height /
                                                        25) *
                                                (answer4 / countPlayer),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                6,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
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
                                                  "${answer4}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Image.asset(
                                                  questionTheme[indexQuestion]
                                                          .answers[3]
                                                          .score
                                                      ? "assets/img/tick.png"
                                                      : "assets/img/wrong.png",
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
                                      width:
                                          MediaQuery.of(context).size.width / 8,
                                      height:
                                          MediaQuery.of(context).size.width / 8,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(100000)),
                                      child: Text(
                                        "${answerCount}",
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
                                  opacity: questionTheme[indexQuestion]
                                          .answers[0]
                                          .score
                                      ? 1
                                      : 0.7,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    constraints: BoxConstraints(
                                      minHeight:
                                          MediaQuery.of(context).size.height /
                                              10,
                                    ),
                                    color: Colors.red,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          "assets/img/circle.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.1 -
                                              ((MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      9) *
                                                  2),
                                          child: Text(
                                            "${questionTheme[indexQuestion].answers[0].answerText}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Mitr',
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Image.asset(
                                          questionTheme[indexQuestion]
                                                  .answers[0]
                                                  .score
                                              ? "assets/img/tick.png"
                                              : "assets/img/wrong.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Opacity(
                                  opacity: questionTheme[indexQuestion]
                                          .answers[1]
                                          .score
                                      ? 1
                                      : 0.7,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    constraints: BoxConstraints(
                                      minHeight:
                                          MediaQuery.of(context).size.height /
                                              10,
                                    ),
                                    color: Colors.blue,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          "assets/img/plain-triangle.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.1 -
                                              ((MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      9) *
                                                  2),
                                          child: Text(
                                            "${questionTheme[indexQuestion].answers[1].answerText}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Mitr',
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Image.asset(
                                          questionTheme[indexQuestion]
                                                  .answers[1]
                                                  .score
                                              ? "assets/img/tick.png"
                                              : "assets/img/wrong.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Opacity(
                                  opacity: questionTheme[indexQuestion]
                                          .answers[2]
                                          .score
                                      ? 1
                                      : 0.7,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    constraints: BoxConstraints(
                                      minHeight:
                                          MediaQuery.of(context).size.height /
                                              10,
                                    ),
                                    color: Colors.amber,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          "assets/img/rhombus.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.1 -
                                              ((MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      9) *
                                                  2),
                                          child: Text(
                                            "${questionTheme[indexQuestion].answers[2].answerText}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Mitr',
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Image.asset(
                                          questionTheme[indexQuestion]
                                                  .answers[2]
                                                  .score
                                              ? "assets/img/tick.png"
                                              : "assets/img/wrong.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Opacity(
                                  opacity: questionTheme[indexQuestion]
                                          .answers[3]
                                          .score
                                      ? 1
                                      : 0.7,
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    margin: EdgeInsets.only(top: 5, bottom: 5),
                                    width:
                                        MediaQuery.of(context).size.width / 1.1,
                                    constraints: BoxConstraints(
                                      minHeight:
                                          MediaQuery.of(context).size.height /
                                              10,
                                    ),
                                    color: Colors.green,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          "assets/img/circle.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                        ),
                                        Container(
                                          width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.1 -
                                              ((MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      9) *
                                                  2),
                                          child: Text(
                                            "${questionTheme[indexQuestion].answers[3].answerText}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'Mitr',
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                        Image.asset(
                                          questionTheme[indexQuestion]
                                                  .answers[3]
                                                  .score
                                              ? "assets/img/tick.png"
                                              : "assets/img/wrong.png",
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              15,
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
                                      InkWell(
                                        onTap: () => Navigator.pop(context),
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.only(
                                              top: 5,
                                              left: 10,
                                              right: 10,
                                              bottom: 5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            "quay về",
                                            style: TextStyle(
                                                fontFamily: 'Mitr',
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 8.0),
                                    child: Container(
                                      padding: EdgeInsets.all(10),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      constraints: BoxConstraints(
                                          minHeight: MediaQuery.of(context)
                                                  .size
                                                  .height /
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
                                    height: MediaQuery.of(context).size.height /
                                        1.3,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: sortedEntries.map((entry) {
                                          final key = entry.key;
                                          final value = entry.value;
                                          final name = value['name'];
                                          final score = value['totalScore'];

                                          return Container(
                                            padding: EdgeInsets.all(5),
                                            margin: EdgeInsets.only(
                                                left: 10,
                                                right: 10,
                                                top: 5,
                                                bottom: 5),
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              8,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              8,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              "assets/img/${random.nextInt(15) + 1}.png"),
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 5),
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              2,
                                                      child: Text(
                                                        name,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontFamily: 'Mitr',
                                                          color: const Color
                                                                  .fromARGB(
                                                              255, 0, 0, 0),
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  '$score điểm',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    color: const Color.fromARGB(
                                                        255, 0, 0, 0),
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : isCoutDown
                                ? Center(
                                    child: Container(
                                      alignment: Alignment.center,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      height:
                                          MediaQuery.of(context).size.width / 2,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              100000000000),
                                          border: Border.all(
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              width: 3)),
                                      child: Text(
                                        "${coutdown}",
                                        style: TextStyle(
                                            fontFamily: 'Mitr',
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 50,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  )
                                : Container(),
          ),
          !isShowSummary
              ? Positioned(
                  top: MediaQuery.of(context).size.height / 20,
                  left: 0,
                  child: Container(
                    padding:
                        EdgeInsets.only(top: 2, bottom: 2, left: 10, right: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_sharp,
                        weight: 5,
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
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
