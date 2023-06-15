import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/features/personal_profile/personal_profile_contract.dart';
import 'package:frontend_flutter/features/personal_profile/personal_profile_presenter.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import '../../models/DetailUserMatch.dart';
import '../../models/Profile.dart';
import '../../models/UserTopic.dart';
import '../../spine_flutter.dart';

// ignore: must_be_immutable
class PersonalProfileView extends StatefulWidget {
  Profile profile;
  bool you;
  PersonalProfileView({super.key, required this.profile, required this.you});

  @override
  State<PersonalProfileView> createState() => _PersonalProfileViewState();
}

class _PersonalProfileViewState extends State<PersonalProfileView>
    implements PersonalProfileContract {
  late PersonalProfilePresenter _presenter;
  _PersonalProfileViewState() {
    _presenter = PersonalProfilePresenter(this);
  }
  bool isLoadingCharacter = false;
  late String animation;
  late SkeletonAnimation skeleton;
  loadingCharacter() async {
    animation =
        "${this.widget.profile.shirt}_${this.widget.profile.trouser}_${this.widget.profile.shoe}_${this.widget.profile.bag}";
    isLoadingCharacter = false;
    setState(() {});
    skeleton = await SkeletonAnimation.createWithFiles(
        "${this.widget.profile.gender}",
        pathBase: "assets/img/character/");
    skeleton.state.setAnimation(0, animation, true);
    isLoadingCharacter = true;
    setState(() {});
  }

  @override
  void initState() {
    _presenter.Getall();
    loadingCharacter();
    super.initState();
  }

  Widget _buildCharacter() {
    return SkeletonRenderObjectWidget(
      skeleton: skeleton,
      alignment: Alignment.center,
      fit: BoxFit.fitHeight,
      playState: PlayState.playing,
      debugRendering: false,
      triangleRendering: true,
    );
  }

  bool isLoading = true;

  List<UserTopic> userTopics = [];
  @override
  setListUserTopic(List<UserTopic> _usertopics) {
    userTopics = _usertopics;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  setIsLoading(bool _isloading) {
    isLoading = _isloading;
    if (mounted) {
      setState(() {});
    }
  }

  late DetailUserMatch detailUserMath;
  List<MatchInfo> matchInfos = [];
  @override
  setUserMatch(DetailUserMatch dt) {
    detailUserMath = dt;
    matchInfos = [
      MatchInfo(
        language: "HTML",
        numOfMatch: detailUserMath.numOfMatchHtml,
        numOfWinMatch: detailUserMath.numOfWinMatchHtml,
      ),
      MatchInfo(
        language: "CSS",
        numOfMatch: detailUserMath.numOfMatchCss,
        numOfWinMatch: detailUserMath.numOfWinMatchCss,
      ),
      MatchInfo(
        language: "C++",
        numOfMatch: detailUserMath.numOfMatchCPlusPlus,
        numOfWinMatch: detailUserMath.numOfWinMatchCPlusPlus,
      ),
      MatchInfo(
        language: "SQL",
        numOfMatch: detailUserMath.numOfMatchSql,
        numOfWinMatch: detailUserMath.numOfWinMatchSql,
      ),
    ];
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 8),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/img/maingame/mainbg.jpg"),
                    fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        "Ngày Sinh: " +
                            DateFormat('dd/MM/yyyy')
                                .format(this.widget.profile.createdAt),
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 0, 0),
                            fontSize: 13,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 6,
                            height: MediaQuery.of(context).size.height / 12,
                            decoration: BoxDecoration(
                                color: Color(0xFFDA7931),
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 6.5,
                              height: MediaQuery.of(context).size.height / 13,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 253, 238, 207),
                                  borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.all(3),
                              child: Image.asset(
                                "assets/img/store/${this.widget.profile.shirt}.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 6,
                            height: MediaQuery.of(context).size.height / 12,
                            decoration: BoxDecoration(
                                color: Color(0xFFDA7931),
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 6.5,
                              height: MediaQuery.of(context).size.height / 13,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 253, 238, 207),
                                  borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.all(3),
                              child: Image.asset(
                                "assets/img/store/${this.widget.profile.trouser}.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2.8,
                          height: MediaQuery.of(context).size.height / 4,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 20),
                          width: MediaQuery.of(context).size.width / 2.8,
                          height: MediaQuery.of(context).size.height / 4,
                          child: isLoadingCharacter
                              ? _buildCharacter()
                              : Container(),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 6,
                            height: MediaQuery.of(context).size.height / 12,
                            decoration: BoxDecoration(
                                color: Color(0xFFDA7931),
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 6.5,
                              height: MediaQuery.of(context).size.height / 13,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 253, 238, 207),
                                  borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.all(3),
                              child: Image.asset(
                                "assets/img/store/${this.widget.profile.bag}.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 6,
                            height: MediaQuery.of(context).size.height / 12,
                            decoration: BoxDecoration(
                                color: Color(0xFFDA7931),
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 6.5,
                              height: MediaQuery.of(context).size.height / 13,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 253, 238, 207),
                                  borderRadius: BorderRadius.circular(5)),
                              padding: EdgeInsets.all(3),
                              child: Image.asset(
                                "assets/img/store/${this.widget.profile.shoe}.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      this.widget.profile.name,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          fontStyle: FontStyle.italic,
                          color: Colors.black),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 35,
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 149, 45, 7),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 35,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 100,
                                    right: MediaQuery.of(context).size.width /
                                        100),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.1,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              50,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 202, 59, 7),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 35,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 100,
                                    right: MediaQuery.of(context).size.width /
                                        100),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: percentExp(
                                          MediaQuery.of(context).size.width /
                                              2.1,
                                          this.widget.profile.level,
                                          this.widget.profile.exp),
                                      height:
                                          MediaQuery.of(context).size.height /
                                              50,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 48, 222, 9),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 35,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Cấp ${this.widget.profile.level} : ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  Text(
                                    "${this.widget.profile.exp}/${expNeed(this.widget.profile.level)}",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 3.2,
                              height: MediaQuery.of(context).size.height / 20,
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height / 150,
                              bottom: MediaQuery.of(context).size.height / 150,
                              right: 0,
                              left: MediaQuery.of(context).size.width / 20,
                              child: Container(
                                  padding: EdgeInsets.only(
                                      left: MediaQuery.of(context).size.width /
                                          15,
                                      right: MediaQuery.of(context).size.width /
                                          40),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 68, 148, 165),
                                    borderRadius: BorderRadius.circular(40.0),
                                  ),
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      "${getStarLevel(this.widget.profile.star)[0].toUpperCase()}${getStarLevel(this.widget.profile.star).substring(1)}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  )),
                            ),
                            Positioned(
                                top: 2.5,
                                bottom: 2.5,
                                left: 0,
                                child: Image.asset(
                                  "assets/img/home/${getStarLevel(this.widget.profile.star)}.png",
                                  width: MediaQuery.of(context).size.width / 8,
                                  fit: BoxFit.fill,
                                ))
                          ],
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "x${getRemainingStars(this.widget.profile.star)}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Image.asset(
                                "assets/img/home/star.png",
                                width: MediaQuery.of(context).size.width / 15,
                                height: MediaQuery.of(context).size.width / 15,
                                fit: BoxFit.fill,
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width - 20,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 218, 122, 49),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width - 30,
                    height: MediaQuery.of(context).size.height / 2.6,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 250, 255, 218),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: isLoading?AnimatedTextKit(
                                repeatForever: true,
                                isRepeatingAnimation: true,
                                animatedTexts: [
                                  TyperAnimatedText('Đang Tải...',
                                      textAlign: TextAlign.center,
                                      textStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 32, 32, 32),
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w500)),
                                ],
                              ):SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (!isLoading)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Đấu Luyện",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          if (!isLoading) ...[
                            for (int i = 0; i < userTopics.length; i++)
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Ngôn Ngữ ${userTopics[i].topicType.toUpperCase()}",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      margin: EdgeInsets.only(top: 5),
                                      padding: EdgeInsets.all(5),
                                      alignment: Alignment.center,
                                      width: MediaQuery.of(context).size.width -
                                          40,
                                      constraints: BoxConstraints(
                                        minHeight:
                                            MediaQuery.of(context).size.height /
                                                8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 171, 77, 5),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                50,
                                        constraints: BoxConstraints(
                                          minHeight: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              8.5,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 240, 126, 49),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  15,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Level cao nhất",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    userTopics[i]
                                                        .levelHightest
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: 2,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  8.5,
                                              decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                            ),
                                            Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  15,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Tổng số điểm",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    userTopics[i]
                                                        .totalScore
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                          ],
                          if (!isLoading)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text(
                                    "Đấu Hạng",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          if (!isLoading)
                            ...matchInfos.map((matchInfo) {
                              return buildMatchInfo(matchInfo, context);
                            }).toList(),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 20,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 10,
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 10,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/img/store/shoptitle.png"),
                            fit: BoxFit.fill)),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 20,
                  bottom: 20,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/img/store/return.png"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class XMarkPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color.fromARGB(255, 164, 77, 19)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, size.height);
    path.moveTo(size.width, 0);
    path.lineTo(0, size.height);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class MatchInfo {
  final String language;
  final int numOfMatch;
  final int numOfWinMatch;

  MatchInfo(
      {required this.language,
      required this.numOfMatch,
      required this.numOfWinMatch});
}

Widget buildMatchInfo(MatchInfo matchInfo, BuildContext context) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Ngôn Ngữ ${matchInfo.language}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          margin: EdgeInsets.only(top: 5),
          padding: EdgeInsets.all(5),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width - 40,
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height / 8,
          ),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 171, 77, 5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width - 50,
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height / 8.5,
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 240, 126, 49),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Số Trận",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        matchInfo.numOfMatch.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                Container(
                  width: 2,
                  height: MediaQuery.of(context).size.height / 8.5,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tỷ Lệ Thắng",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        (matchInfo.numOfWinMatch != 0 &&
                                matchInfo.numOfMatch != 0)
                            ? ((matchInfo.numOfWinMatch /
                                        matchInfo.numOfMatch) *
                                    100)
                                .ceil()
                                .toString()
                            : "0" + " %",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ],
  );
}
