import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HistoryBattleView extends StatefulWidget {
  const HistoryBattleView({super.key});

  @override
  State<HistoryBattleView> createState() => _HistoryBattleViewState();
}

class _HistoryBattleViewState extends State<HistoryBattleView> {
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
              InkWell(
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
                            "assets/img/historybattle/lichsudau.png"),
                        fit: BoxFit.fill)),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: AnimatedTextKit(
                    repeatForever: false,
                    isRepeatingAnimation: false,
                    animatedTexts: [
                      TyperAnimatedText(
                          'Bạn chưa tham gia trận đấu nào gần đây.',
                          textAlign: TextAlign.center,
                          textStyle: TextStyle(
                              color: Color.fromARGB(255, 32, 32, 32),
                              fontSize: 15,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
