import 'dart:async';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/components/DialogMessage.dart';
import 'package:frontend_flutter/components/FlowerMoveFreely.dart';
import 'package:frontend_flutter/features/find_rival_and_ready/find_rival_and_ready_contract.dart';
import 'package:frontend_flutter/features/find_rival_and_ready/find_rival_and_ready_presenter.dart';
import 'package:frontend_flutter/models/Profile.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../components/Button.dart';
import '../../constants.dart';
import '../../sound_manager.dart';

// ignore: must_be_immutable
class FindRivalAndReadyView extends StatefulWidget {
  String topic;
  Profile profile;
  FindRivalAndReadyView(
      {super.key, required this.profile, required this.topic});

  @override
  State<FindRivalAndReadyView> createState() => _FindRivalAndReadyViewState();
}

class _FindRivalAndReadyViewState extends State<FindRivalAndReadyView>
    with TickerProviderStateMixin
    implements FindRivalAndReadyContract {
  late AnimationController _RivalSideController;
  late Animation<double> _RivalSideAnimation;
  late AnimationController _YouSideController;
  late Animation<double> _YouSideAnimation;
  late AnimationController _LightningController;
  late Animation<double> _scaleLightningAnimation;
  late Animation<double> _opacityLightningAnimation;
  late AnimationController _VsController;
  late Animation<double> _scaleVsAnimation;
  late Animation<double> _opacityVsAnimation;
  late AnimationController _ReadyController;
  late Animation<double> _scaleReadyAnimation;
  late Animation<double> _opacityReadyAnimation;
  late bool isCompleteAnimation = false;
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
      gender: "male",
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
      _YouSideController.forward();
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

  bool outWhenhaveRoom = false;
  String roomId = "";
  @override
  setRoomId(String _roomId) {
    outWhenhaveRoom = true;
    socket.emit("OutRoom${this.widget.topic}", {"uid": uid, "roomid": roomId});
    roomId = _roomId;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  outBattle() {
    if (mounted) {
      Navigator.pop(context);
      DialogMessage(context, "Trận đấu bị hủy vì bạn chưa sẵn sàng");
    }
  }

  @override
  resumeFinding() {
    if (mounted) {
      Navigator.pop(context);
      Navigator.pushNamed(context, "/FindRivalAndReady",
          arguments: [this.widget.profile, this.widget.topic]);
    }
  }

  @override
  getYouReady() {
    return youReady;
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

  int _currentIndex = 0;
  List<String> _texts = [
    'Câu hỏi ngẫu nhiên của trận đấu sẽ được x2 số điểm lưu ý nhé.',
    'Trong chế độ đấu luyện bạn có thể dùng vàng để sử dụng các tính năng trả lời câu hỏi.',
    'Điểm danh đầy đủ để nhận các vật phẩm trong trò chơi nhé!'
  ];
  bool _isVisible = true;
  Timer? _timer;
  CreateAnimationController() {
    _YouSideController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _YouSideAnimation =
        Tween(begin: 300.0, end: 0.0).animate(_YouSideController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _RivalSideController.forward();
            }
          });
    _RivalSideController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _RivalSideAnimation =
        Tween(begin: -500.0, end: 0.0).animate(_RivalSideController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _LightningController.forward();
              GlobalSoundManager().playButton("lightning");
            }
          });
    _LightningController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    final _scaleTween = Tween(begin: 5.0, end: 1.0);
    _scaleLightningAnimation = _scaleTween.animate(CurvedAnimation(
      parent: _LightningController,
      curve: Curves.easeInOut,
    ));

    final _opacityTween = Tween(begin: 0.0, end: 1.0);
    _opacityLightningAnimation = _opacityTween.animate(CurvedAnimation(
      parent: _LightningController,
      curve: Curves.easeInOut,
    ))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _VsController.forward();
          Future.delayed(Duration(seconds: 2), () {
            isCompleteAnimation = true;
            if (mounted) {
              setState(() {});
            }
          });
        }
      });
    _VsController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleVsAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _VsController,
      curve: Curves.easeInOut,
    ));

    _opacityVsAnimation = _opacityTween.animate(CurvedAnimation(
      parent: _VsController,
      curve: Curves.easeInOut,
    ))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _ReadyController.forward();
        }
      });
    _ReadyController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleReadyAnimation = _scaleTween.animate(CurvedAnimation(
      parent: _ReadyController,
      curve: Curves.easeInOut,
    ));

    _opacityReadyAnimation = _opacityTween.animate(CurvedAnimation(
      parent: _ReadyController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void initState() {
    GlobalSoundManager().playBackgroundMusic("findrival");
    CreateAnimationController();
    _startTimer();
    _presenter.FindRival(this.widget.topic);
    super.initState();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (_) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _texts.length;
      });
    });
  }

  Widget _buildIndicator(int index) {
    return Container(
      width: 14,
      height: 14,
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(1.5),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          strokeAlign: BorderSide.strokeAlignCenter,
          color: _currentIndex == index ? Colors.white : Colors.transparent,
          width: 2,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: _currentIndex == index
              ? Colors.white.withOpacity(0.8)
              : Colors.white,
        ),
      ),
    );
  }

  @override
  void dispose() {
    if (!outWhenhaveRoom) {
      socket
          .emit("OutRoom${this.widget.topic}", {"uid": uid, "roomid": roomId});
    }
    _RivalSideController.dispose();
    _YouSideController.dispose();
    _LightningController.dispose();
    _VsController.dispose();
    _ReadyController.dispose();
    _timer?.cancel();

    socket.off("Room$roomId");
    socket.off("GetReady$roomId");
    super.dispose();
  }

  // late String animation;
  // late SkeletonAnimation skeleton;
  // bool isLoadingCharacter = false;
  // loadingCharacter() async {
  //   print("object");
  //   animation = "animation";
  //   isLoadingCharacter = false;
  //   setState(() {});
  //   skeleton = await SkeletonAnimation.createWithFiles("robot",
  //       pathBase: "assets/img/character/");
  //   skeleton.state.setAnimation(0, animation, true);
  //   isLoadingCharacter = true;
  //   if (mounted) {
  //     setState(() {});
  //     print("object");
  //   }
  // }

  // Widget _buidRobotLoading() {
  //   return SkeletonRenderObjectWidget(
  //     skeleton: skeleton,
  //     alignment: Alignment.center,
  //     fit: BoxFit.fitWidth,
  //     playState: PlayState.playing,
  //     debugRendering: false,
  //     triangleRendering: true,
  //   );
  // }

  @override
  pushBattle() {
    if (mounted) {
      Navigator.pushReplacementNamed(context, "/Battle", arguments: [
        this.widget.profile,
        rivalProfile,
        roomId,
        this.widget.topic,
        null,
        null,
        null
      ]);

      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => BattleView(
      //             you: this.widget.profile,
      //             rival: rivalProfile,
      //             idRoom: roomId,
      //             topic: this.widget.topic)));
    }
  }

  @override
  Widget build(BuildContext context) {
    Random random = Random();
    int numberOfFlowerFreeMoves = random.nextInt(6) + 4;
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
                    image: AssetImage("assets/img/battle/bg2.jpg"),
                    fit: BoxFit.fill)),
          ),
          ...List.generate(numberOfFlowerFreeMoves, (_) {
            return FlowerFreeMove(
                maxWidth: MediaQuery.of(context).size.width,
                maxHeight: MediaQuery.of(context).size.height);
          }),
          Container(
            padding: EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: finding
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ButtonCustom(
                            onTap: () {
                              Navigator.pop(context);
                              GlobalSoundManager().playBackgroundMusic("home");
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
                                        "assets/img/battle/${this.widget.topic}.gif"),
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
                              child: Image.asset(
                                  "assets/img/battle/${this.widget.profile.gender}.png"),
                            ),
                            Text(
                              "${this.widget.profile.name}",
                              style: TextStyle(
                                  fontFamily: 'Mitr',
                                  fontSize: 15,
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromARGB(255, 63, 1, 1)),
                            ),
                            AnimatedTextKit(
                              repeatForever: false,
                              isRepeatingAnimation: false,
                              animatedTexts: [
                                TyperAnimatedText(
                                  "Đang tìm đối thủ...",
                                  speed: Duration(milliseconds: 70),
                                  textAlign: TextAlign.center,
                                  textStyle: TextStyle(
                                      fontFamily: 'Mitr',
                                      fontSize: 18,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black),
                                ),
                              ],
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
                            left: MediaQuery.of(context).size.width / 10,
                            right: MediaQuery.of(context).size.width / 10,
                            child: Container(
                              alignment: Alignment.center,
                              height: MediaQuery.of(context).size.height / 5.2,
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color.fromARGB(255, 254, 206, 156)
                                        .withOpacity(0.5),
                                    blurRadius: 20,
                                    spreadRadius: 10,
                                  ),
                                ],
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                height:
                                    MediaQuery.of(context).size.height / 5.2,
                                decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Color(0xfffc7535).withOpacity(0.5),
                                        blurRadius: 20,
                                        spreadRadius: 10,
                                        blurStyle: BlurStyle.inner),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AnimatedOpacity(
                                      opacity: _isVisible ? 1.0 : 0.0,
                                      duration: Duration(milliseconds: 500),
                                      child: Text(
                                        _texts[_currentIndex],
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 16,
                                            color: Colors.white),
                                      ),
                                    ),
                                    SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        _buildIndicator(0),
                                        _buildIndicator(1),
                                        _buildIndicator(2),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              height: MediaQuery.of(context).size.height / 5,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                        "assets/img/battle/robot.gif",
                                      ),
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
                              fontFamily: 'Mitr',
                              fontSize: 28,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.5,
                        child: Stack(
                          children: [
                            AnimatedBuilder(
                                animation: _RivalSideAnimation,
                                builder: (context, child) {
                                  return Positioned(
                                    bottom: 0,
                                    right: _RivalSideAnimation.value,
                                    child: Container(
                                      padding: EdgeInsets.only(right: 30),
                                      alignment: Alignment.centerRight,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
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
                                                "assets/img/battle/${rivalProfile.gender}.png"),
                                          ),
                                          Text(
                                            "${rivalProfile.name}",
                                            style: TextStyle(
                                                fontFamily: 'Mitr',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                                color: Color.fromARGB(
                                                    255, 63, 1, 1)),
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/img/battle/frameuser2.png"),
                                              fit: BoxFit.fill)),
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.5,
                                    ),
                                  );
                                }),
                            AnimatedBuilder(
                                animation: _YouSideAnimation,
                                builder: (context, child) {
                                  return Positioned(
                                    top: 0,
                                    left: _YouSideAnimation.value,
                                    child: Container(
                                      padding: EdgeInsets.only(left: 30),
                                      alignment: Alignment.centerLeft,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/img/battle/frameuser1.png"),
                                              fit: BoxFit.fill)),
                                      width: MediaQuery.of(context).size.width /
                                          1.5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                "assets/img/battle/${this.widget.profile.gender}.png"),
                                          ),
                                          Text(
                                            this.widget.profile.name,
                                            style: TextStyle(
                                                fontFamily: 'Mitr',
                                                fontSize: 18,
                                                fontWeight: FontWeight.w800,
                                                color: Color.fromARGB(
                                                    255, 63, 1, 1)),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                })
                          ],
                        ),
                      ),
                      AnimatedBuilder(
                          animation: _ReadyController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _scaleReadyAnimation.value,
                              child: Opacity(
                                opacity: _opacityReadyAnimation.value,
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 50),
                                  child: ButtonCustom(
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
                                        youReady
                                            ? "Đã Sẵn Sàng"
                                            : "Sẵn Sàng",
                                        style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 18,
                                            fontWeight: FontWeight.w900),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })
                    ],
                  ),
          ),
          !finding
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      AnimatedBuilder(
                          animation: _LightningController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _scaleLightningAnimation.value,
                              child: Opacity(
                                opacity: !isCompleteAnimation
                                    ? _opacityLightningAnimation.value
                                    : 0.0,
                                child: Center(
                                  child: Image.asset(
                                      "assets/img/battle/thunder.gif"),
                                ),
                              ),
                            );
                          }),
                      AnimatedBuilder(
                          animation: _VsController,
                          builder: (context, child) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 15),
                              child: Transform.scale(
                                scale: _scaleVsAnimation.value,
                                child: Opacity(
                                  opacity: _opacityVsAnimation.value,
                                  child: Center(
                                    child:
                                        Image.asset("assets/img/battle/vs.png"),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
