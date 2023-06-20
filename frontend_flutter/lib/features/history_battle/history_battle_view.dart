import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:frontend_flutter/constants.dart';
import 'package:frontend_flutter/features/detail_history_battle/detail_history_battle_view.dart';
import 'package:frontend_flutter/features/history_battle/history_battle_contract.dart';
import 'package:frontend_flutter/features/history_battle/history_battle_presenter.dart';
import 'package:frontend_flutter/models/Match.dart';
import 'package:frontend_flutter/models/Profile.dart';
import 'package:intl/intl.dart';

import '../../components/Button.dart';

// ignore: must_be_immutable
class HistoryBattleView extends StatefulWidget {
  Profile profile;
  HistoryBattleView({super.key, required this.profile});

  @override
  State<HistoryBattleView> createState() => _HistoryBattleViewState();
}

class _HistoryBattleViewState extends State<HistoryBattleView>
    implements HistoryBattleContract {
  // ignore: unused_field
  late HistoryBattlePresenter _presenter;
  bool isloading = true;
  late List<MatchBattle> matches;
  _HistoryBattleViewState() {
    _presenter = HistoryBattlePresenter(this);
  }
  @override
  void initState() {
    _presenter.GetAllMatches();
    super.initState();
  }

  @override
  setIsLoading(bool _isloading) {
    isloading = _isloading;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setListMatches(List<MatchBattle> _matches) {
    print(_matches.length);
    matches = _matches;
    if (mounted) {
      setState(() {});
    }
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
                            "assets/img/historybattle/lichsudau.gif"),
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
            child: !isloading
                ? matches.isEmpty
                    ? Column(
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
                      )
                    : ListView(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.zero,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ...matches.asMap().entries.map((entry) {
                                MatchBattle match = entry.value;
                                print(match.createdAt);
                                return GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailHistoryBattleView(
                                                match: match,
                                                profile: this.widget.profile,
                                              ))),
                                  child: Container(
                                    width: MediaQuery.of(context).size.width /
                                        1.05,
                                    height: MediaQuery.of(context).size.height /
                                        5.3,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                              match.winner == ""
                                                  ? "assets/img/historybattle/win.gif"
                                                  : match.winner == uid
                                                      ? "assets/img/historybattle/win.gif"
                                                      : "assets/img/historybattle/lose.gif",
                                            ),
                                            fit: BoxFit.fill)),
                                    child: Stack(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.05,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              5.5,
                                        ),
                                        Positioned(
                                          top: 0,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                10,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                18,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                      "assets/img/historybattle/flag${match.topic}.png",
                                                    ),
                                                    fit: BoxFit.fill)),
                                          ),
                                        ),
                                        Positioned(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              18,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              20,
                                          child: Container(
                                            padding: EdgeInsets.all(15),
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                10,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/img/battle/frameavtwin.png"),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            child: Image.asset(
                                              "assets/img/battle/${this.widget.profile.gender}.png",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              18,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              4,
                                          child: GlowText(
                                            match.winner == ""
                                                ? "Hòa"
                                                : match.winner == uid
                                                    ? "Chiến Thắng"
                                                    : "Thất Bại",
                                            blurRadius: 4,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 19,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w500,
                                                color: match.winner == ""
                                                    ? Colors.green
                                                    : match.winner == uid
                                                        ? Color.fromARGB(
                                                            255, 255, 230, 4)
                                                        : Color.fromARGB(
                                                            255, 255, 164, 17)),
                                          ),
                                        ),
                                        Positioned(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              10,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.6,
                                          child: Text(
                                            match.player1 == uid
                                                ? "Điểm số : ${match.score1}"
                                                : "Điểm số : ${match.score2}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              40,
                                          left: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.8,
                                          child: Text(
                                            formatDateTime(match.createdAt),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 13,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white),
                                          ),
                                        ),
                                        Positioned(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              12,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              3.5,
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                9,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                23,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                      "assets/img/historybattle/circle.png",
                                                    ),
                                                    fit: BoxFit.fill)),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              40,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          child: Text(
                                            ">> Chi Tiết",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
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
                                        color: Color.fromARGB(255, 32, 32, 32),
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
    ));
  }
}

String formatDateTime(DateTime dateTime) {
  // Cộng thêm 7 giờ vào đối tượng DateTime
  dateTime = dateTime.add(Duration(hours: 7));

  // Định dạng chuỗi giờ phút
  String formattedTime = DateFormat.Hm().format(dateTime);

  // Định dạng chuỗi ngày
  String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);

  // Lấy ngày hôm nay
  DateTime today = DateTime.now();

  // Lấy ngày hôm qua
  DateTime yesterday = DateTime.now().subtract(Duration(days: 1));

  // So sánh với ngày hôm nay và trả về kết quả tương ứng
  if (dateTime.day == today.day &&
      dateTime.month == today.month &&
      dateTime.year == today.year) {
    return '$formattedTime Hôm nay';
  } else if (dateTime.day == yesterday.day &&
      dateTime.month == yesterday.month &&
      dateTime.year == yesterday.year) {
    return '$formattedTime Hôm qua';
  } else {
    return '$formattedTime $formattedDate';
  }
}
