import 'package:flutter/material.dart';
import 'package:frontend_flutter/features/muster/muster_presenter.dart';
import 'package:intl/intl.dart';

import 'muster_contract.dart';

class MusterView extends StatefulWidget {
  const MusterView({super.key});

  @override
  State<MusterView> createState() => _MusterViewState();
}

class _MusterViewState extends State<MusterView> implements MusterContract {
  late MusterPresenter _presenter;
  _MusterViewState() {
    _presenter = MusterPresenter(this);
  }
  var now = DateTime.now();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    String monday = DateFormat('yyyy-MM-dd')
        .format(now.subtract(Duration(days: now.weekday - 1)));
    String tuesday = DateFormat('yyyy-MM-dd')
        .format(now.subtract(Duration(days: now.weekday - 2)));
    String wednesday = DateFormat('yyyy-MM-dd')
        .format(now.subtract(Duration(days: now.weekday - 3)));
    String thursday = DateFormat('yyyy-MM-dd')
        .format(now.subtract(Duration(days: now.weekday - 4)));
    String friday = DateFormat('yyyy-MM-dd')
        .format(now.subtract(Duration(days: now.weekday - 5)));
    String saturday = DateFormat('yyyy-MM-dd')
        .format(now.subtract(Duration(days: now.weekday - 6)));
    String sunday = DateFormat('yyyy-MM-dd')
        .format(now.subtract(Duration(days: now.weekday - 7)));
    return Material(
        color: Colors.transparent,
        child: Center(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 1.2,
              ),
              Positioned(
                bottom: 0,
                top: MediaQuery.of(context).size.height / 15,
                left: MediaQuery.of(context).size.width / 25,
                right: MediaQuery.of(context).size.width / 25,
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 10,
                      right: MediaQuery.of(context).size.width / 10,
                      bottom: MediaQuery.of(context).size.height / 10,
                      top: MediaQuery.of(context).size.height / 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/home/frame.png"),
                          fit: BoxFit.fill)),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // if (!musterList.contains(monday) &&
                                      //     DateFormat('yyyy-MM-dd')
                                      //             .format(now) ==
                                      //         monday) {
                                      //   musterList.add(monday);
                                      //   CreateMuster(monday, 20.toString());
                                      // }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6,
                                      decoration: BoxDecoration(
                                          color: Color(0xffC3570D),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Container(
                                        margin: EdgeInsets.all(4),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        decoration: BoxDecoration(
                                            color: Color(0xff783401),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Thứ 2",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                            Image.asset(
                                              "assets/img/maingame/gold.png",
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.fill,
                                            ),
                                            Text(
                                              "+20 Vàng",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //  musterList.contains(monday)
                                  //     ?
                                  Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    height:
                                        MediaQuery.of(context).size.height / 6,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(108, 0, 0, 0),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/img/home/check.png",
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                  )
                                  //  : Container(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // if (!musterList.contains(tuesday) &&
                                      //     DateFormat('yyyy-MM-dd')
                                      //             .format(now) ==
                                      //         tuesday) {
                                      //   musterList.add(tuesday);
                                      //   CreateMuster(tuesday, 30.toString());
                                      // }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6,
                                      decoration: BoxDecoration(
                                          color: Color(0xffC3570D),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Container(
                                        margin: EdgeInsets.all(4),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        decoration: BoxDecoration(
                                            color: Color(0xff783401),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Thứ 3",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                            Image.asset(
                                              "assets/img/maingame/gold.png",
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.fill,
                                            ),
                                            Text(
                                              "+30 Vàng",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //    musterList.contains(tuesday)
                                  //       ?
                                  Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    height:
                                        MediaQuery.of(context).size.height / 6,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(108, 0, 0, 0),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/img/home/check.png",
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                  )
                                  //   : Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // if (!musterList.contains(wednesday) &&
                                      //     DateFormat('yyyy-MM-dd')
                                      //             .format(now) ==
                                      //         wednesday) {
                                      //   musterList.add(wednesday);
                                      //   CreateMuster(wednesday, 40.toString());
                                      // }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6,
                                      decoration: BoxDecoration(
                                          color: Color(0xffC3570D),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Container(
                                        margin: EdgeInsets.all(4),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        decoration: BoxDecoration(
                                            color: Color(0xff783401),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Thứ 4",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                            Image.asset(
                                              "assets/img/maingame/gold.png",
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.fill,
                                            ),
                                            Text(
                                              "+40 Vàng",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // musterList.contains(wednesday)
                                  //    ?
                                  Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    height:
                                        MediaQuery.of(context).size.height / 6,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(108, 0, 0, 0),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/img/home/check.png",
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                  )
                                  //  : Container(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // if (!musterList.contains(thursday) &&
                                      //     DateFormat('yyyy-MM-dd')
                                      //             .format(now) ==
                                      //         thursday) {
                                      //   musterList.add(thursday);
                                      //   CreateMuster(thursday, 50.toString());
                                      // }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6,
                                      decoration: BoxDecoration(
                                          color: Color(0xffC3570D),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Container(
                                        margin: EdgeInsets.all(4),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        decoration: BoxDecoration(
                                            color: Color(0xff783401),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Thứ 5",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                            Image.asset(
                                              "assets/img/maingame/gold.png",
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.fill,
                                            ),
                                            Text(
                                              "+50 Vàng",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //    musterList.contains(thursday)
                                  //        ?
                                  Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    height:
                                        MediaQuery.of(context).size.height / 6,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(108, 0, 0, 0),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/img/home/check.png",
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                  )
                                  //  : Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // if (!musterList.contains(friday) &&
                                      //     DateFormat('yyyy-MM-dd')
                                      //             .format(now) ==
                                      //         friday) {
                                      //   musterList.add(friday);
                                      //   CreateMuster(friday, 60.toString());
                                      // }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6,
                                      decoration: BoxDecoration(
                                          color: Color(0xffC3570D),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Container(
                                        margin: EdgeInsets.all(4),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        decoration: BoxDecoration(
                                            color: Color(0xff783401),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Thứ 6",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                            Image.asset(
                                              "assets/img/maingame/gold.png",
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.fill,
                                            ),
                                            Text(
                                              "+60 Vàng",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //  musterList.contains(friday)
                                  //   ?
                                  Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    height:
                                        MediaQuery.of(context).size.height / 6,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(108, 0, 0, 0),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/img/home/check.png",
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                  )
                                  //  : Container(),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // if (!musterList.contains(saturday) &&
                                      //     DateFormat('yyyy-MM-dd')
                                      //             .format(now) ==
                                      //         saturday) {
                                      //   musterList.add(saturday);
                                      //   CreateMuster(saturday, 70.toString());
                                      // }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6,
                                      decoration: BoxDecoration(
                                          color: Color(0xffC3570D),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Container(
                                        margin: EdgeInsets.all(4),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        decoration: BoxDecoration(
                                            color: Color(0xff783401),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Thứ 7",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                            Image.asset(
                                              "assets/img/maingame/gold.png",
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.fill,
                                            ),
                                            Text(
                                              "+70 Vàng",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  //   musterList.contains(saturday)
                                  //      ?
                                  Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    height:
                                        MediaQuery.of(context).size.height / 6,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(108, 0, 0, 0),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/img/home/check.png",
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                  )
                                  //   : Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Stack(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // if (!musterList.contains(sunday) &&
                                      //     DateFormat('yyyy-MM-dd')
                                      //             .format(now) ==
                                      //         sunday) {
                                      //   musterList.add(sunday);
                                      //   CreateMuster(sunday, 80.toString());
                                      // }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width /
                                          3.5,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6,
                                      decoration: BoxDecoration(
                                          color: Color(0xffC3570D),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Container(
                                        margin: EdgeInsets.all(4),
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                6,
                                        decoration: BoxDecoration(
                                            color: Color(0xff783401),
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "Chủ Nhật",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                            Image.asset(
                                              "assets/img/maingame/gold.png",
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.fill,
                                            ),
                                            Text(
                                              "+80 Vàng",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w700,
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  // musterList.contains(sunday)
                                  //    ?
                                  Container(
                                    alignment: Alignment.center,
                                    width:
                                        MediaQuery.of(context).size.width / 3.5,
                                    height:
                                        MediaQuery.of(context).size.height / 6,
                                    decoration: BoxDecoration(
                                        color: Color.fromARGB(108, 0, 0, 0),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/img/home/check.png",
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                  )
                                  //    : Container(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 7,
                right: MediaQuery.of(context).size.width / 7,
                top: MediaQuery.of(context).size.height / 30,
                bottom: MediaQuery.of(context).size.height / 1.5,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/home/muster.png"),
                          fit: BoxFit.fill)),
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height / 15,
                  right: MediaQuery.of(context).size.width / 25,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image:
                                  AssetImage("assets/img/home/closebutton.png"),
                              fit: BoxFit.fill)),
                    ),
                  )),
              isLoading
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.2,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      width: 0,
                      height: 0,
                    ),
            ],
          ),
        ));
  }
}
