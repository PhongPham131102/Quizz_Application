import 'package:flutter/material.dart';
import 'package:frontend_flutter/detail_battle_traning/detail_battle_traning_view.dart';
import 'package:frontend_flutter/features/battle_training/battle_training_contract.dart';
import 'package:frontend_flutter/features/battle_training/battle_training_presenter.dart';

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

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 2000),
        curve: Curves.bounceInOut,
      );
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
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
            AnimatedBuilder(
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
                                        DetailBattleTrainingView()));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2,
                            height: MediaQuery.of(context).size.height / 3.5,
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
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.2,
                          height: MediaQuery.of(context).size.height / 5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/img/battletraining/sqlhome.gif"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: MediaQuery.of(context).size.height +
                            MediaQuery.of(context).size.height * 0.2,
                        left: MediaQuery.of(context).size.width / 5,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.2,
                          height: MediaQuery.of(context).size.height / 5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/img/battletraining/htmlhome.gif"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height / 8,
                        right: MediaQuery.of(context).size.width / 5,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.2,
                          height: MediaQuery.of(context).size.height / 5,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  "assets/img/battletraining/csshome.gif"),
                              fit: BoxFit.fill,
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
                                "assets/img/historybattle/lichsudau.png"),
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
