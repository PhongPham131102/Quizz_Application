import 'package:flutter/material.dart';
import 'package:frontend_flutter/features/home/home_contract.dart';
import 'package:frontend_flutter/features/home/home_presenter.dart';
import 'package:frontend_flutter/features/setting_game/setting_game_view.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../constants.dart';
import '../../models/Profile.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> implements HomeContract {
  Profile? profile;
  bool isLoading = true;
  @override
  updateProfile(Profile _profile) {
    profile = _profile;
    setState(() {});
  }

  @override
  setIsLoading(bool _isLoading) {
    isLoading = _isLoading;
    setState(() {});
  }
  @override
  void initState() {
    _presenter.getsocket();
    _presenter.getinfo();
    super.initState();
  }
  late HomePresenter _presenter;
  _HomeViewState() {
    _presenter = HomePresenter(this);
  }
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: !isLoading
          ? Container(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img/maingame/mainbg.jpg"),
                    fit: BoxFit.fill),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: _height / 35),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          child: Stack(
                            children: [
                              Container(
                                width: _width / 2.8,
                                height: _height / 15,
                              ),
                              Positioned(
                                top: _height / 80,
                                bottom: _height / 80,
                                right: 0,
                                child: Container(
                                  width: _width / 3,
                                  height: _height / 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/img/maingame/buttoncoin.png"),
                                          fit: BoxFit.fill)),
                                  child: Text(
                                    profile!.gold.toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: _height / 150,
                                bottom: _height / 150,
                                left: 0,
                                child: Container(
                                  width: _width / 8,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/img/maingame/gold.png"),
                                          fit: BoxFit.fill)),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Stack(
                            children: [
                              Container(
                                width: _width / 2.8,
                                height: _height / 15,
                              ),
                              Positioned(
                                top: _height / 80,
                                bottom: _height / 80,
                                right: 0,
                                child: Container(
                                  width: _width / 3,
                                  height: _height / 50,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/img/maingame/buttoncoin.png"),
                                          fit: BoxFit.fill)),
                                  child: Text(
                                    profile!.diamond.toString(),
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: _height / 100,
                                bottom: _height / 100,
                                left: 0,
                                child: Container(
                                  width: _width / 9,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                              "assets/img/maingame/diamond.png"),
                                          fit: BoxFit.fill)),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _height / 50),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: _width / 5.5,
                                    height: _height / 10,
                                  ),
                                  Positioned(
                                      left: _width / 80,
                                      right: _width / 80,
                                      child: Image.asset(
                                        "assets/img/maingame/ruleicon.png",
                                        width: _width / 10,
                                        height: _height / 12,
                                      )),
                                  Positioned(
                                      bottom: _height / 150,
                                      left: 0,
                                      right: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          StrokeText(
                                              text: "Luật chơi",
                                              fontSize: 13,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                              strokeColor: Colors.black,
                                              strokeWidth: 0.5),
                                        ],
                                      ))
                                ],
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: _width / 5.5,
                                    height: _height / 10,
                                  ),
                                  Positioned(
                                      left: _width / 80,
                                      right: _width / 80,
                                      child: Image.asset(
                                        "assets/img/maingame/mustericon.png",
                                        width: _width / 10,
                                        height: _height / 12,
                                      )),
                                  Positioned(
                                      bottom: _height / 150,
                                      left: 0,
                                      right: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          StrokeText(
                                              text: "Điểm danh",
                                              fontSize: 13,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                              strokeColor: Colors.black,
                                              strokeWidth: 0.5),
                                        ],
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: _width / 2,
                          height: _height / 2.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                profile!.name,
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Image.asset(
                                "assets/img/maingame/male.png",
                                width: _width / 2 - 50,
                                height: _height / 3.5,
                              ),

                              // Stack(
                              //   children: [
                              //     Container(
                              //       width: 140,
                              //       height: 50,
                              //     ),
                              //     Positioned(
                              //       top: 5,
                              //       bottom: 5,
                              //       right: 0,
                              //       child: Container(
                              //         padding: EdgeInsets.only(left: 15),
                              //         width: 120,
                              //         height: 40,
                              //         alignment: Alignment.center,
                              //         decoration: BoxDecoration(
                              //           color: Color(0xFF38585F),
                              //           borderRadius:
                              //               BorderRadius.circular(40.0),
                              //         ),
                              //         child: Text(
                              //           "Intern",
                              //           style: TextStyle(
                              //               color: Colors.white,
                              //               fontSize: 18,
                              //               fontWeight: FontWeight.w700),
                              //         ),
                              //       ),
                              //     ),
                              //     Positioned(
                              //         top: 2.5,
                              //         bottom: 2.5,
                              //         left: 0,
                              //         child: Image.asset(
                              //           "assets/img/maingame/intern.png",
                              //           width: 60,
                              //           height: 45,
                              //           fit: BoxFit.fill,
                              //         ))
                              //   ],
                              // )
                            ],
                          ),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: _width / 5.5,
                                    height: _height / 10,
                                  ),
                                  Positioned(
                                      left: _width / 80,
                                      right: _width / 80,
                                      child: Image.asset(
                                        "assets/img/maingame/ruleicon.png",
                                        width: _width / 10,
                                        height: _height / 12,
                                      )),
                                  Positioned(
                                      bottom: _height / 150,
                                      left: 0,
                                      right: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          StrokeText(
                                              text: "Luật chơi",
                                              fontSize: 13,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                              strokeColor: Colors.black,
                                              strokeWidth: 0.5),
                                        ],
                                      ))
                                ],
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: _width / 5.5,
                                    height: _height / 10,
                                  ),
                                  Positioned(
                                      left: _width / 80,
                                      right: _width / 80,
                                      child: Image.asset(
                                        "assets/img/maingame/mustericon.png",
                                        width: _width / 10,
                                        height: _height / 12,
                                      )),
                                  Positioned(
                                      bottom: _height / 150,
                                      left: 0,
                                      right: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          StrokeText(
                                              text: "Điểm danh",
                                              fontSize: 13,
                                              fontWeight: FontWeight.w900,
                                              color: Colors.white,
                                              strokeColor: Colors.black,
                                              strokeWidth: 0.5),
                                        ],
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => FightingModeScreen(
                            //         userProfile: usersProfile!,
                            //       ),
                            //     ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: _width / 1.9,
                            height: _height / 13,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image:
                                  AssetImage("assets/img/maingame/button.png"),
                              fit: BoxFit.fill,
                            )),
                            child: Text(
                              "1 VS 1",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) => ChooseTopicScreen(),
                            //     ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: _width / 1.9,
                            height: _height / 13,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image:
                                  AssetImage("assets/img/maingame/button.png"),
                              fit: BoxFit.fill,
                            )),
                            child: Text(
                              "Đấu Luyện",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            width: _width / 1.9,
                            height: _height / 13,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image:
                                  AssetImage("assets/img/maingame/button.png"),
                              fit: BoxFit.fill,
                            )),
                            child: Text(
                              "Bảng Xếp Hạng",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            alignment: Alignment.center,
                            width: _width / 1.9,
                            height: _height / 13,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image:
                                  AssetImage("assets/img/maingame/button.png"),
                              fit: BoxFit.fill,
                            )),
                            child: Text(
                              "Khóa Học",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // showDialog(
                          //     context: context,
                          //     builder: (context) => AttendanceScreen());
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: _width / 5.5,
                              height: _height / 10,
                            ),
                            Positioned(
                                left: _width / 80,
                                right: _width / 80,
                                child: Image.asset(
                                  "assets/img/maingame/mustericon.png",
                                  width: _width / 10,
                                  height: _height / 12,
                                )),
                            Positioned(
                                bottom: _height / 150,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    StrokeText(
                                        text: "Điểm danh",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        strokeColor: Colors.black,
                                        strokeWidth: 0.5),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          // await Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => StoreScreen(
                          //         userProfile: usersProfile!,
                          //       ),
                          //     ));
                          // GetUsersProfile();
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: _width / 5.5,
                              height: _height / 10,
                            ),
                            Positioned(
                                left: _width / 80,
                                right: _width / 80,
                                child: Image.asset(
                                  "assets/img/maingame/shopicon.png",
                                  width: _width / 10,
                                  height: _height / 12,
                                )),
                            Positioned(
                                bottom: _height / 150,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    StrokeText(
                                        text: "Cửa hàng",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        strokeColor: Colors.black,
                                        strokeWidth: 0.5),
                                  ],
                                ))
                          ],
                        ),
                      ),
                      Stack(
                        children: [
                          Container(
                            width: _width / 5.5,
                            height: _height / 10,
                          ),
                          Positioned(
                              left: _width / 80,
                              right: _width / 80,
                              child: Image.asset(
                                "assets/img/maingame/bagicon.png",
                                width: _width / 10,
                                height: _height / 12,
                              )),
                          Positioned(
                              bottom: _height / 150,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  StrokeText(
                                      text: "Túi đồ",
                                      fontSize: 13,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                      strokeColor: Colors.black,
                                      strokeWidth: 0.5),
                                ],
                              ))
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => SettingGameView());
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: _width / 5.5,
                              height: _height / 10,
                            ),
                            Positioned(
                                left: _width / 80,
                                right: _width / 80,
                                child: Image.asset(
                                  "assets/img/maingame/settingicon.png",
                                  width: _width / 10,
                                  height: _height / 12,
                                )),
                            Positioned(
                                bottom: _height / 150,
                                left: 0,
                                right: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    StrokeText(
                                        text: "Cài đặt",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w900,
                                        color: Colors.white,
                                        strokeColor: Colors.black,
                                        strokeWidth: 0.5),
                                  ],
                                ))
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class StrokeText extends StatelessWidget {
  String text;
  double fontSize;
  FontWeight fontWeight;
  Color color;
  Color strokeColor;
  double strokeWidth;
  StrokeText({
    Key? key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.color,
    required this.strokeColor,
    required this.strokeWidth,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            foreground: Paint()..color = color,
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            foreground: Paint()
              ..strokeWidth = strokeWidth
              ..color = strokeColor
              ..style = PaintingStyle.stroke,
          ),
        ),
      ],
    );
  }
}
