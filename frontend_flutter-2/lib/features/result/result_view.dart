import 'package:flutter/material.dart';
import 'package:frontend_flutter/features/result/result_contract.dart';
import 'package:frontend_flutter/features/result/result_presenter.dart';
import 'package:flutter_glow/flutter_glow.dart';

class ReSultView extends StatefulWidget {
  const ReSultView({super.key});

  @override
  State<ReSultView> createState() => _ReSultViewState();
}

class _ReSultViewState extends State<ReSultView>
    with TickerProviderStateMixin
    implements ResultContract {
  late AnimationController _animationController;
  late ResultPresenter _presenter;
  _ReSultViewState() {
    _presenter = ResultPresenter(this);
  }
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/battle/bg2.png"),
                fit: BoxFit.fill)),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/img/battle/shadowques.png"),
                  fit: BoxFit.fill)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.35,
                  ),
                  Positioned(
                    bottom: 0,
                    left: MediaQuery.of(context).size.width / 25,
                    right: MediaQuery.of(context).size.width / 25,
                    child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.width / 15,
                          left: MediaQuery.of(context).size.width / 20,
                          right: MediaQuery.of(context).size.width / 20),
                      height: MediaQuery.of(context).size.height / 2.7,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/img/battle/win.png"),
                            fit: BoxFit.fill),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Stack(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  height:
                                      MediaQuery.of(context).size.height / 5.5,
                                  child: Stack(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            top: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                45,
                                            bottom: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                45),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5.5,
                                        child: Image.asset(
                                          "assets/img/battle/thundermsg.png",
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      Positioned(
                                          top: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              17,
                                          bottom: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              17,
                                          left: MediaQuery.of(
                                                      context)
                                                  .size
                                                  .width /
                                              8,
                                          right: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              8,
                                          child: Image.asset(
                                              "assets/img/battle/vs2.png",
                                              fit: BoxFit.fitHeight))
                                    ],
                                  )),
                              Positioned(
                                left: 0,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          50),
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  child: Column(
                                    children: [
                                      AnimatedBuilder(
                                        animation: _animationController,
                                        builder: (BuildContext context,
                                            Widget? child) {
                                          return GlowText(
                                            "1130 Điểm",
                                            blurRadius: Tween<double>(
                                                    begin: 4, end: 7)
                                                .animate(_animationController)
                                                .value,
                                            glowColor: Colors.red,
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          );
                                        },
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/img/battle/frameavtwin.png"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: Image.asset(
                                          "assets/img/battle/face.png",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      AnimatedBuilder(
                                        animation: _animationController,
                                        builder: (BuildContext context,
                                            Widget? child) {
                                          return GlowText(
                                            "phong",
                                            blurRadius: Tween<double>(
                                                    begin: 3, end: 5)
                                                .animate(_animationController)
                                                .value,
                                            glowColor: Colors.black,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w600),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height /
                                          50),
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  child: Column(
                                    children: [
                                      AnimatedBuilder(
                                        animation: _animationController,
                                        builder: (BuildContext context,
                                            Widget? child) {
                                          return GlowText(
                                            "phong",
                                            blurRadius: Tween<double>(
                                                    begin: 3, end: 5)
                                                .animate(_animationController)
                                                .value,
                                            glowColor: Colors.black,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontStyle: FontStyle.italic,
                                                fontWeight: FontWeight.w600),
                                          );
                                        },
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(15),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                10,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage(
                                                "assets/img/battle/frameavtwin.png"),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: Image.asset(
                                          "assets/img/battle/face.png",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      AnimatedBuilder(
                                        animation: _animationController,
                                        builder: (BuildContext context,
                                            Widget? child) {
                                          return GlowText(
                                            "1130 Điểm",
                                            blurRadius: Tween<double>(
                                                    begin: 4, end: 7)
                                                .animate(_animationController)
                                                .value,
                                            glowColor:
                                                Color.fromARGB(255, 44, 1, 1),
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 44, 1, 1),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w700),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: MediaQuery.of(context).size.width / 2.9,
                    right: MediaQuery.of(context).size.width / 2.9,
                    child: Image.asset("assets/img/battle/starwin.png"),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 15,
                    bottom: MediaQuery.of(context).size.height / 15),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 8,
                          right: MediaQuery.of(context).size.width / 8),
                      child: Text(
                        "Bộ câu hỏi này có vẻ thú vị bạn có muốn xem lại đáp án không?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 23, 22, 22)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width / 4,
                      height: MediaQuery.of(context).size.height / 20,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/img/battle/review.png"),
                              fit: BoxFit.fill)),
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (BuildContext context, Widget? child) {
                          return GlowText(
                            "Xem Lại",
                            blurRadius: Tween<double>(begin: 1, end: 10)
                                .animate(_animationController)
                                .value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(right: 5),
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.height / 15,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/img/battle/button.png"),
                            fit: BoxFit.fill),
                      ),
                      child: Text(
                        "Trận Mới",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 5),
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: MediaQuery.of(context).size.height / 15,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/img/battle/button.png"),
                            fit: BoxFit.fill),
                      ),
                      child: Text(
                        "Trang Chủ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
