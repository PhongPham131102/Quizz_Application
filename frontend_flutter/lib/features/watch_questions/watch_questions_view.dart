import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

import '../../components/Button.dart';
import '../../models/Question.dart';

// ignore: must_be_immutable
class WatchQuestionsView extends StatefulWidget {
  List<Question> questions;
  WatchQuestionsView({super.key, required this.questions});

  @override
  State<WatchQuestionsView> createState() => _WatchQuestionsViewState();
}

class _WatchQuestionsViewState extends State<WatchQuestionsView> {
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
                              fit: BoxFit.fill)),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 10,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                "assets/img/battle/questiontitle.gif"),
                            fit: BoxFit.fill)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 8,
                    height: MediaQuery.of(context).size.height / 14,
                  )
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height -
                    MediaQuery.of(context).size.height / 6,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: this.widget.questions.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/img/iconquestion/board.png"),
                                  fit: BoxFit.fill)),
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height / 3.8,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "Câu ${index + 1}:",
                                    style: TextStyle(
                                        color: Colors.yellow,
                                        fontWeight: FontWeight.w700),
                                  )
                                ],
                              ),
                              Text(this.widget.questions[index].title,
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
                          width: MediaQuery.of(context).size.width / 4,
                          height: MediaQuery.of(context).size.height / 20,
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
                            .questions[index]
                            .answers
                            .asMap()
                            .entries
                            .map((entry) {
                          final answer = entry.value;
                          return Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width / 16,
                                right: MediaQuery.of(context).size.width / 16,
                                top: 10),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                                color:
                                    answer.score ? Colors.green : Colors.white),
                            constraints: BoxConstraints(
                              minHeight:
                                  MediaQuery.of(context).size.height / 14,
                            ),
                            child: Center(
                              child: Text(answer.answerText,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700)),
                            ),
                          );
                        }).toList(),
                      ],
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
