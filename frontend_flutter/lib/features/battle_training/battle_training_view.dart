import 'package:flutter/material.dart';
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
      duration: Duration(milliseconds: 5000),
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
      body: Center(
        child: GestureDetector(
          onVerticalDragUpdate: (DragUpdateDetails details) {
            _scrollController.position.moveTo(
              _scrollController.position.pixels - details.delta.dy,
            );
          },
          child: Stack(
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return SingleChildScrollView(
                    controller: _scrollController,
                    physics: NeverScrollableScrollPhysics(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 2,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/img/battletraining/topicbg.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
