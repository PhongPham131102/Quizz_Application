import 'package:flutter/material.dart';
import 'package:frontend_flutter/components/DialogMessage.dart';
import 'package:frontend_flutter/features/find_rival_and_ready/find_rival_and_ready_contract.dart';
import 'package:frontend_flutter/features/find_rival_and_ready/find_rival_and_ready_presenter.dart';
import 'package:frontend_flutter/models/Profile.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../constants.dart';
import '../battle/battle_view.dart';

class FindRivalAndReadyView extends StatefulWidget {
  String topic;
  Profile profile;
  FindRivalAndReadyView(
      {super.key, required this.profile, required this.topic});

  @override
  State<FindRivalAndReadyView> createState() => _FindRivalAndReadyViewState();
}

class _FindRivalAndReadyViewState extends State<FindRivalAndReadyView>
    implements FindRivalAndReadyContract {
  IO.Socket socket =
      IO.io('${baseUrl.replaceAll("/api", "")}', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true,
  });
  late FindRivalAndReadyPresenter _presenter;
  _FindRivalAndReadyViewState() {
    _presenter = FindRivalAndReadyPresenter(this);
  }
  bool finding = true;
  Profile rivalProfile = Profile(
      uid: "uid",
      gender: "gender",
      gold: 0,
      diamond: 0,
      level: 1,
      name: "đang tải...",
      star: 1,
      exp: 1,
      medalId: "",
      shirt: "shirt",
      trouser: "trouser",
      shoe: "shoe",
      bag: "bag",
      id: "id",
      createdAt: DateTime.now(),
      updatedAt: DateTime.now());
  int time = 99;
  bool youReady = false;
  @override
  setFinding(bool _finding) {
    finding = _finding;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  IO.Socket getSocket() {
    return socket;
  }

  @override
  setrivalProfile(Profile _rivalProfile) {
    rivalProfile = _rivalProfile;
    if (mounted) {
      setState(() {});
    }
  }

  String roomId = "";
  @override
  setRoomId(String _roomId) {
    roomId = _roomId;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  outBattle() {
    if (mounted) {
      Navigator.pop(context);
      DialogMessage(context,
          "Trận đấu bị hủy vì bạn hoăc đối thủ chưa sẵn sàng");
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
  String getroomId() {
    return roomId;
  }

  @override
  setyouReady(bool _youReady) {
    youReady = _youReady;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  bool getyouready() {
    return youReady;
  }

  @override
  void initState() {
    _presenter.FindRival(this.widget.topic);
    super.initState();
  }

  @override
  void dispose() {
    socket.emit("OutRoom${this.widget.topic}", {"uid": uid, "roomid": roomId});
    // socket.off("Room$roomId");
    // socket.off("GetReady$roomId");
    super.dispose();
  }

  @override
  pushBattle() {
    if (mounted) {
      Navigator.pop(context);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BattleView(
                  you: this.widget.profile,
                  rival: rivalProfile,
                  idRoom: roomId,topic:this.widget.topic)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img/battle/bg2.png"),
                    fit: BoxFit.fill)),
            child: finding
                ? Column(
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
                                      image: AssetImage(
                                          "assets/img/battle/return.png"),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                          Container(
                            width: 230,
                            height: 90,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/img/battle/${this.widget.topic}.png"),
                                    fit: BoxFit.fill)),
                          ),
                          Container(
                            width: 50,
                            height: 50,
                          )
                        ],
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 100,
                              height: 100,
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battle/frameavt.png"),
                                      fit: BoxFit.fill)),
                              child: Image.asset("assets/img/battle/face.png"),
                            ),
                            Text(
                              "Phong",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromARGB(255, 63, 1, 1)),
                            ),
                            Text(
                              "Đang tìm đối thủ...",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 63, 1, 1)),
                            ),
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height / 3.5,
                          ),
                          Positioned(
                            top: 0,
                            left: MediaQuery.of(context).size.width / 9,
                            right: MediaQuery.of(context).size.width / 9,
                            child: Container(
                              height: MediaQuery.of(context).size.height / 4,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battle/boardrule.png"),
                                      fit: BoxFit.fill)),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              height: MediaQuery.of(context).size.height / 6,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battle/robot.png"),
                                      fit: BoxFit.fill)),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          "$time",
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: Stack(
                          children: [
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: EdgeInsets.only(right: 30),
                                alignment: Alignment.centerRight,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/img/battle/frameavt.png"),
                                              fit: BoxFit.fill)),
                                      child: Image.asset(
                                          "assets/img/battle/face.png"),
                                    ),
                                    Text(
                                      "${rivalProfile.name}",
                                      style: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.w800,
                                          color: Color.fromARGB(255, 63, 1, 1)),
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/img/battle/frameuser2.png"),
                                        fit: BoxFit.fill)),
                                width: MediaQuery.of(context).size.width / 1.5,
                                height:
                                    MediaQuery.of(context).size.height / 3.5,
                              ),
                            ),
                            Positioned(
                              top: 0,
                              left: 0,
                              child: Container(
                                padding: EdgeInsets.only(left: 30),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/img/battle/frameuser1.png"),
                                        fit: BoxFit.fill)),
                                width: MediaQuery.of(context).size.width / 1.5,
                                height:
                                    MediaQuery.of(context).size.height / 3.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 80,
                                      padding: EdgeInsets.all(15),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/img/battle/frameavt.png"),
                                              fit: BoxFit.fill)),
                                      child: Image.asset(
                                          "assets/img/battle/face.png"),
                                    ),
                                    Text(
                                      this.widget.profile.name,
                                      style: TextStyle(
                                          fontSize: 23,
                                          fontWeight: FontWeight.w800,
                                          color: Color.fromARGB(255, 63, 1, 1)),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: InkWell(
                          onTap: () => _presenter.Ready(),
                          child: Container(
                            width: 150,
                            alignment: Alignment.center,
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/img/battle/button.png"),
                                  fit: BoxFit.fill),
                            ),
                            child: Text(
                              youReady ? "Đã Sẵn Sàng" : "Sẵn Sàng",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
          ),
          !finding
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Center(
                        child: Image.asset("assets/img/battle/thunder.png"),
                      ),
                      Center(
                        child: Image.asset("assets/img/battle/vs.png"),
                      )
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
