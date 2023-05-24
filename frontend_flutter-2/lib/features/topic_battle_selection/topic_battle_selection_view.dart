import 'package:flutter/material.dart';
import 'package:frontend_flutter/features/find_rival_and_ready/find_rival_and_ready_view.dart';
import 'package:frontend_flutter/features/topic_battle_selection/topic_battle_selection_contract.dart';
import 'package:frontend_flutter/features/topic_battle_selection/topic_battle_selection_presenter.dart';
import 'package:frontend_flutter/models/Profile.dart';

class TopicBattleSelectionView extends StatefulWidget {
  Profile profile;
  TopicBattleSelectionView({super.key, required this.profile});

  @override
  State<TopicBattleSelectionView> createState() =>
      _TopicBattleSelectionViewState();
}

class _TopicBattleSelectionViewState extends State<TopicBattleSelectionView>
    implements TopicBattleSelectionContract {
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
                InkWell(
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
                  width: 230,
                  height: 90,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/battle/giaodau.png"),
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
                InkWell(
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
                            image: AssetImage("assets/img/battle/boardcss.png"),
                            fit: BoxFit.fill)),
                  ),
                ),
                InkWell(
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
                            image: AssetImage("assets/img/battle/boardc++.png"),
                            fit: BoxFit.fill)),
                  ),
                ),
                InkWell(
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
                                AssetImage("assets/img/battle/boardhtml.png"),
                            fit: BoxFit.fill)),
                  ),
                ),
                InkWell(
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
                            image: AssetImage("assets/img/battle/boardsql.png"),
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
