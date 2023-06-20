// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:frontend_flutter/features/find_rival_and_ready/find_rival_and_ready_view.dart';
import 'package:frontend_flutter/features/topic_battle_selection/topic_battle_selection_contract.dart';
import 'package:frontend_flutter/features/topic_battle_selection/topic_battle_selection_presenter.dart';
import 'package:frontend_flutter/models/Profile.dart';

import '../../components/Button.dart';

class TopicBattleSelectionView extends StatefulWidget {
  Profile profile;
  TopicBattleSelectionView({super.key, required this.profile});

  @override
  State<TopicBattleSelectionView> createState() =>
      _TopicBattleSelectionViewState();
}

class _TopicBattleSelectionViewState extends State<TopicBattleSelectionView>
    implements TopicBattleSelectionContract {
       // ignore: unused_field
  late TopicBattleSelectionPresenter _presenter;
  _TopicBattleSelectionViewState() {
    _presenter = TopicBattleSelectionPresenter(this);
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonCustom(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/img/battle/return.png"),
                            fit: BoxFit.fill)),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width/1.6,
                  height: 90,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/battle/giaodau.gif"),
                          fit: BoxFit.fill)),
                ),
                Container(
                  width: 50,
                  height: 50,
                )
              ],
            ),
            Column(
              children: [
                ButtonCustom(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FindRivalAndReadyView(
                                profile: this.widget.profile, topic: "css")));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    width: MediaQuery.of(context).size.width - 30,
                    height: MediaQuery.of(context).size.height / 6,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/img/battle/boardcss.gif"),
                            fit: BoxFit.fill)),
                  ),
                ),
                ButtonCustom(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FindRivalAndReadyView(
                                profile: this.widget.profile,
                                topic: "cplusplus")));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    width: MediaQuery.of(context).size.width - 30,
                    height: MediaQuery.of(context).size.height / 6,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/img/battle/boardc++.gif"),
                            fit: BoxFit.fill)),
                  ),
                ),
                ButtonCustom(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FindRivalAndReadyView(
                                profile: this.widget.profile, topic: "html")));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    width: MediaQuery.of(context).size.width - 30,
                    height: MediaQuery.of(context).size.height / 6,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/img/battle/boardhtml.gif"),
                            fit: BoxFit.fill)),
                  ),
                ),
                ButtonCustom(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FindRivalAndReadyView(
                                profile: this.widget.profile, topic: "sql")));
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    width: MediaQuery.of(context).size.width - 30,
                    height: MediaQuery.of(context).size.height / 6,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/img/battle/boardsql.gif"),
                            fit: BoxFit.fill)),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
