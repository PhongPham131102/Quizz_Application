import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:frontend_flutter/detail_battle_traning/detail_battle_traning_view.dart';
import 'package:frontend_flutter/features/battle_training/battle_training_contract.dart';
import 'package:frontend_flutter/features/battle_training/battle_training_presenter.dart';
import 'package:frontend_flutter/models/UserTopic.dart';

class BattleTrainingView extends StatefulWidget {
  const BattleTrainingView({super.key});

  @override
  State<BattleTrainingView> createState() => _BattleTrainingViewState();
}

class _BattleTrainingViewState extends State<BattleTrainingView>
    with SingleTickerProviderStateMixin
    implements BattleTrainingContract {
  // ignore: unused_field
  late BattleTrainingPresenter _presenter;
  _BattleTrainingViewState() {
    _presenter = BattleTrainingPresenter(this);
  }
  late ScrollController _scrollController;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool isLoading = true;
  @override
  void initState() {
    _presenter.Getall();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

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
      _scrollController = ScrollController();
      _animationController = AnimationController(
        duration: Duration(milliseconds: 1000),
        vsync: this,
      );

      _animation =
          Tween<double>(begin: 0, end: 1).animate(_animationController);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 2000),
          curve: Curves.bounceInOut,
        );
      });

      _animationController.forward();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (DragUpdateDetails details) {
          _scrollController.position.moveTo(
            _scrollController.position.pixels - details.delta.dy,
          );
        },
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            isLoading
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/img/battle/bg2.png"),
                            fit: BoxFit.fill)),
                    child: Center(
                      child: AnimatedTextKit(
                        repeatForever: true,
                        isRepeatingAnimation: true,
                        animatedTexts: [
                          TyperAnimatedText('Đang tải...',
                              textAlign: TextAlign.center,
                              textStyle: TextStyle(
                                  color: Color.fromARGB(255, 32, 32, 32),
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                  )
                : AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return SingleChildScrollView(
                        controller: _scrollController,
                        child: Stack(
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height * 2,
                                child: Image.asset(
                                  "assets/img/battletraining/topicbg.gif",
                                  fit: BoxFit.fill,
                                )),
                            Positioned(
                              bottom: MediaQuery.of(context).size.height / 8,
                              right: MediaQuery.of(context).size.width / 9,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailBattleTrainingView(
                                                userTopic: userTopics
                                                    .where((element) =>
                                                        element.topicType ==
                                                        "c++")
                                                    .first,
                                              )));
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width / 2,
                                  height:
                                      MediaQuery.of(context).size.height / 3.5,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battletraining/chome.gif"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: MediaQuery.of(context).size.height / 1.2,
                              left: MediaQuery.of(context).size.width / 80,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailBattleTrainingView(
                                                userTopic: userTopics
                                                    .where((element) =>
                                                        element.topicType ==
                                                        "sql")
                                                    .first,
                                              )));
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battletraining/sqlhome.gif"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: MediaQuery.of(context).size.height +
                                  MediaQuery.of(context).size.height * 0.2,
                              left: MediaQuery.of(context).size.width / 5,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailBattleTrainingView(
                                                userTopic: userTopics
                                                    .where((element) =>
                                                        element.topicType ==
                                                        "html")
                                                    .first,
                                              )));
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battletraining/htmlhome.gif"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: MediaQuery.of(context).size.height / 8,
                              right: MediaQuery.of(context).size.width / 5,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailBattleTrainingView(
                                                userTopic: userTopics
                                                    .where((element) =>
                                                        element.topicType ==
                                                        "css")
                                                    .first,
                                              )));
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.2,
                                  height:
                                      MediaQuery.of(context).size.height / 5,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battletraining/csshome.gif"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
            Positioned(
              top: MediaQuery.of(context).size.height / 40,
              left: 0,
              right: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
                                "assets/img/battletraining/topic.png"),
                            fit: BoxFit.fill)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 8,
                    height: MediaQuery.of(context).size.height / 14,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
