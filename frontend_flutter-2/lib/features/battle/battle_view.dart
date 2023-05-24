import 'package:flutter/material.dart';
import 'package:frontend_flutter/features/battle/battle_contract.dart';
import 'package:frontend_flutter/features/battle/battle_presenter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../constants.dart';
import '../../models/Profile.dart';
import '../../models/Question.dart';

class BattleView extends StatefulWidget {
  Profile you;
  Profile rival;
  String idRoom;
  BattleView({
    super.key,
    required this.you,
    required this.rival,
    required this.idRoom,
  });

  @override
  State<BattleView> createState() => _BattleViewState();
}

class _BattleViewState extends State<BattleView> implements BattleContract {
  late BattlePresenter _presenter;
  List<Question> questions = [
    Question(
        id: "id",
        title: "title",
        answers: [Answer(answerText: "answerText", score: false, id: "")],
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
  @override
  setTime(int _time) {
    time = _time;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
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
  int getIndex() {
    return index;
  }

  @override
  setListQuestion(List<Question> _questions) {
    questions=[];
    questions = _questions;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    socket.off("Questions${this.widget.idRoom}");
    socket.off("TimerRoom${this.widget.idRoom}");
    super.dispose();
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
              fit: BoxFit.fill)),
      child: Column(
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
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      30,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 201, 106, 11),
                                      borderRadius: BorderRadius.circular(5)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    yourScore.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: MediaQuery.of(context).size.height / 10 * 0.1,
                            bottom:
                                MediaQuery.of(context).size.height / 10 * 0.1,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Image.asset(
                                "assets/img/battle/face.png",
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
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      30,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 201, 106, 11),
                                      borderRadius: BorderRadius.circular(5)),
                                  alignment: Alignment.center,
                                  child: Text(
                                    rivalScore.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w900),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: 0,
                            top: MediaQuery.of(context).size.height / 10 * 0.1,
                            bottom:
                                MediaQuery.of(context).size.height / 10 * 0.1,
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Image.asset(
                                "assets/img/battle/face.png",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 10,
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
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 20),
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
                      "Câu ${index + 1}:",
                      style: TextStyle(
                          color: Colors.yellow, fontWeight: FontWeight.w700),
                    )
                  ],
                ),
                Text(questions == [] ? "" : questions[index].title,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700)),
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
              children: questions[index].answers.asMap().entries.map((entry) {
                final answerIndex = entry.key;
                final answer = entry.value;

                return InkWell(
                  onTap: () {
                    // if (!isAnswer && answer.answerText != "") {
                    //   selectedAnswerIndex = answerIndex; // Lưu vị trí được chọn
                    //   isAnswer = true;
                    //   youAnswer = true;
                    //   handleAnswer(answer.score);
                    //   Future.delayed(Duration(seconds: 1), () {
                    //     if (youAnswer && rivalAnswer) {
                    //       print("next");
                    //       if (index < this.widget.questions.length - 1) {
                    //         time = 10;
                    //         index++;
                    //         isAnswer = false;
                    //         selectedAnswerIndex = null;
                    //         youAnswer = false;
                    //         rivalAnswer = false;
                    //         start();
                    //         setState(() {});
                    //       }
                    //     } else {
                    //       print("tong ket2");
                    //     }
                    //   });

                    //   setState(() {});
                    // }
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 25, right: 25, bottom: 5),
                    padding: EdgeInsets.all(1.5),
                    decoration: BoxDecoration(
                        color: Colors.black, // Thay đổi màu tương ứng
                        borderRadius: BorderRadius.circular(3)),
                    child: Container(
                      decoration: BoxDecoration(
                          color:
                              // selectedAnswerIndex == answerIndex
                              //     ? answer.score
                              //         ? Colors.green
                              //         : Colors.red
                              //  :
                              Colors.white, // Thay đổi màu tương ứng
                          borderRadius: BorderRadius.circular(3)),
                      constraints: BoxConstraints(minHeight: 50, minWidth: 320),
                      child: Center(
                        child: Text(answer.answerText,
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
        ],
      ),
    ));
  }
}
