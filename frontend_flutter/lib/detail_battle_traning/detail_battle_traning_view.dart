import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:auto_size_text/auto_size_text.dart';

class DetailBattleTrainingView extends StatefulWidget {
  const DetailBattleTrainingView({super.key});

  @override
  State<DetailBattleTrainingView> createState() =>
      _DetailBattleTrainingViewState();
}

class _DetailBattleTrainingViewState extends State<DetailBattleTrainingView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isExpanded = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
          milliseconds: 500), // Điều chỉnh thời gian phóng to và thu nhỏ
    );

    _animationController.addListener(() {
      if (_animationController.status == AnimationStatus.completed ||
          _animationController.status == AnimationStatus.dismissed) {
        _toggleSize();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _toggleSize();
    });

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSize() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 2,
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/img/battletraining/topicc++.gif"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                //level 1
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    final scale = _animationController.value * 0.05 + 1.0;

                    return Positioned(
                      bottom: 0,
                      left: MediaQuery.of(context).size.width / 2.4,
                      right: MediaQuery.of(context).size.width / 3.4,
                      child: GestureDetector(
                        onTap: () {},
                        child: Transform.scale(
                          scale: scale,
                          child: Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battletraining/levelbutton.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: MediaQuery.of(context).size.width / 20,
                                child: Image.asset(
                                  "assets/img/battletraining/1star.png",
                                  fit: BoxFit.fill,
                                  height:
                                      MediaQuery.of(context).size.height / 17,
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height / 13,
                                left: MediaQuery.of(context).size.width / 10,
                                child: GlowText(
                                  "1",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                bottom: MediaQuery.of(context).size.height / 60,
                                right: MediaQuery.of(context).size.width / 40,
                                child: Transform.rotate(
                                  angle: -25 * 3.1415927 / 180,
                                  child: Image.asset(
                                    "assets/img/battletraining/key.png",
                                    fit: BoxFit.fill,
                                    height:
                                        MediaQuery.of(context).size.height / 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                //level 1
                Positioned(
                  bottom: MediaQuery.of(context).size.height / 25,
                  left: MediaQuery.of(context).size.width / 25,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/img/battletraining/board2.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.height / 70,
                          left: MediaQuery.of(context).size.width / 30,
                          right: MediaQuery.of(context).size.width / 50,
                          bottom: MediaQuery.of(context).size.height / 25,
                          child: Container(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                'Giới Thiệu C++',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              )))
                    ],
                  ),
                ),
                //level 2
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    final scale = _animationController.value * 0.05 + 1.0;
                    return Positioned(
                      bottom: MediaQuery.of(context).size.height / 4,
                      left: MediaQuery.of(context).size.width / 4.8,
                      right: MediaQuery.of(context).size.width / 2,
                      child: GestureDetector(
                        onTap: () {},
                        child: Transform.scale(
                          scale: scale,
                          child: Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battletraining/levelbutton.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: MediaQuery.of(context).size.width / 20,
                                child: Image.asset(
                                  "assets/img/battletraining/1star.png",
                                  fit: BoxFit.fill,
                                  height:
                                      MediaQuery.of(context).size.height / 17,
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height / 13,
                                left: MediaQuery.of(context).size.width / 10,
                                child: GlowText(
                                  "1",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                bottom: MediaQuery.of(context).size.height / 60,
                                right: MediaQuery.of(context).size.width / 40,
                                child: Transform.rotate(
                                  angle: -25 * 3.1415927 / 180,
                                  child: Image.asset(
                                    "assets/img/battletraining/key.png",
                                    fit: BoxFit.fill,
                                    height:
                                        MediaQuery.of(context).size.height / 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // level 2
                Positioned(
                  bottom: MediaQuery.of(context).size.height / 4,
                  right: MediaQuery.of(context).size.width / 8,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/img/battletraining/board2.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.height / 70,
                          left: MediaQuery.of(context).size.width / 30,
                          right: MediaQuery.of(context).size.width / 50,
                          bottom: MediaQuery.of(context).size.height / 25,
                          child: Container(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                'Giới Thiệu C++',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              )))
                    ],
                  ),
                ),
                //level 3
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    final scale = _animationController.value * 0.05 + 1.0;
                    return Positioned(
                      bottom: MediaQuery.of(context).size.height / 2.5,
                      left: MediaQuery.of(context).size.width / 1.8,
                      right: MediaQuery.of(context).size.width / 6,
                      child: GestureDetector(
                        onTap: () {},
                        child: Transform.scale(
                          scale: scale,
                          child: Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battletraining/levelbutton.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: MediaQuery.of(context).size.width / 20,
                                child: Image.asset(
                                  "assets/img/battletraining/1star.png",
                                  fit: BoxFit.fill,
                                  height:
                                      MediaQuery.of(context).size.height / 17,
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height / 13,
                                left: MediaQuery.of(context).size.width / 10,
                                child: GlowText(
                                  "1",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                bottom: MediaQuery.of(context).size.height / 60,
                                right: MediaQuery.of(context).size.width / 40,
                                child: Transform.rotate(
                                  angle: -25 * 3.1415927 / 180,
                                  child: Image.asset(
                                    "assets/img/battletraining/key.png",
                                    fit: BoxFit.fill,
                                    height:
                                        MediaQuery.of(context).size.height / 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ), // level 3
                Positioned(
                  bottom: MediaQuery.of(context).size.height / 2.3,
                  left: MediaQuery.of(context).size.width / 8,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/img/battletraining/board2.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.height / 70,
                          left: MediaQuery.of(context).size.width / 30,
                          right: MediaQuery.of(context).size.width / 50,
                          bottom: MediaQuery.of(context).size.height / 25,
                          child: Container(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                'Giới Thiệu C++',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              )))
                    ],
                  ),
                ),
                //level 4
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    final scale = _animationController.value * 0.05 + 1.0;
                    return Positioned(
                      bottom: MediaQuery.of(context).size.height / 1.6,
                      left: MediaQuery.of(context).size.width / 6,
                      right: MediaQuery.of(context).size.width / 1.8,
                      child: GestureDetector(
                        onTap: () {},
                        child: Transform.scale(
                          scale: scale,
                          child: Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battletraining/levelbutton.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: MediaQuery.of(context).size.width / 20,
                                child: Image.asset(
                                  "assets/img/battletraining/1star.png",
                                  fit: BoxFit.fill,
                                  height:
                                      MediaQuery.of(context).size.height / 17,
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height / 13,
                                left: MediaQuery.of(context).size.width / 10,
                                child: GlowText(
                                  "1",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                bottom: MediaQuery.of(context).size.height / 60,
                                right: MediaQuery.of(context).size.width / 40,
                                child: Transform.rotate(
                                  angle: -25 * 3.1415927 / 180,
                                  child: Image.asset(
                                    "assets/img/battletraining/key.png",
                                    fit: BoxFit.fill,
                                    height:
                                        MediaQuery.of(context).size.height / 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // level 4
                Positioned(
                  bottom: MediaQuery.of(context).size.height / 1.5,
                  right: MediaQuery.of(context).size.width / 6,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/img/battletraining/board2.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.height / 70,
                          left: MediaQuery.of(context).size.width / 30,
                          right: MediaQuery.of(context).size.width / 50,
                          bottom: MediaQuery.of(context).size.height / 25,
                          child: Container(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                'Giới Thiệu C++',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              )))
                    ],
                  ),
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            "assets/img/battletraining/topicc++.gif"),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ), //level 1
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    final scale = _animationController.value * 0.05 + 1.0;
                    return Positioned(
                      bottom: MediaQuery.of(context).size.height,
                      left: MediaQuery.of(context).size.width / 2.4,
                      right: MediaQuery.of(context).size.width / 3.4,
                      child: GestureDetector(
                        onTap: () {},
                        child: Transform.scale(
                          scale: scale,
                          child: Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battletraining/levelbutton.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: MediaQuery.of(context).size.width / 20,
                                child: Image.asset(
                                  "assets/img/battletraining/1star.png",
                                  fit: BoxFit.fill,
                                  height:
                                      MediaQuery.of(context).size.height / 17,
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height / 13,
                                left: MediaQuery.of(context).size.width / 10,
                                child: GlowText(
                                  "1",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                bottom: MediaQuery.of(context).size.height / 60,
                                right: MediaQuery.of(context).size.width / 40,
                                child: Transform.rotate(
                                  angle: -25 * 3.1415927 / 180,
                                  child: Image.asset(
                                    "assets/img/battletraining/key.png",
                                    fit: BoxFit.fill,
                                    height:
                                        MediaQuery.of(context).size.height / 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ), //level 1
                Positioned(
                  bottom: MediaQuery.of(context).size.height +MediaQuery.of(context).size.height / 25,
                  left: MediaQuery.of(context).size.width / 25,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/img/battletraining/board2.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.height / 70,
                          left: MediaQuery.of(context).size.width / 30,
                          right: MediaQuery.of(context).size.width / 50,
                          bottom: MediaQuery.of(context).size.height / 25,
                          child: Container(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                'Giới Thiệu C++',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              )))
                    ],
                  ),
                ),
                //level 2
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    final scale = _animationController.value * 0.05 + 1.0;
                    return Positioned(
                      bottom:MediaQuery.of(context).size.height+ MediaQuery.of(context).size.height / 4,
                      left: MediaQuery.of(context).size.width / 4.8,
                      right: MediaQuery.of(context).size.width / 2,
                      child: GestureDetector(
                        onTap: () {},
                        child: Transform.scale(
                          scale: scale,
                          child: Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battletraining/levelbutton.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: MediaQuery.of(context).size.width / 20,
                                child: Image.asset(
                                  "assets/img/battletraining/1star.png",
                                  fit: BoxFit.fill,
                                  height:
                                      MediaQuery.of(context).size.height / 17,
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height / 13,
                                left: MediaQuery.of(context).size.width / 10,
                                child: GlowText(
                                  "1",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                bottom: MediaQuery.of(context).size.height / 60,
                                right: MediaQuery.of(context).size.width / 40,
                                child: Transform.rotate(
                                  angle: -25 * 3.1415927 / 180,
                                  child: Image.asset(
                                    "assets/img/battletraining/key.png",
                                    fit: BoxFit.fill,
                                    height:
                                        MediaQuery.of(context).size.height / 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // level 2
                Positioned(
                  bottom: MediaQuery.of(context).size.height+MediaQuery.of(context).size.height / 4,
                  right: MediaQuery.of(context).size.width / 8,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/img/battletraining/board2.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.height / 70,
                          left: MediaQuery.of(context).size.width / 30,
                          right: MediaQuery.of(context).size.width / 50,
                          bottom: MediaQuery.of(context).size.height / 25,
                          child: Container(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                'Giới Thiệu C++',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              )))
                    ],
                  ),
                ),
                //level 3
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    final scale = _animationController.value * 0.05 + 1.0;
                    return Positioned(
                      bottom: MediaQuery.of(context).size.height+MediaQuery.of(context).size.height / 2.5,
                      left: MediaQuery.of(context).size.width / 1.8,
                      right: MediaQuery.of(context).size.width / 6,
                      child: GestureDetector(
                        onTap: () {},
                        child: Transform.scale(
                          scale: scale,
                          child: Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battletraining/levelbutton.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: MediaQuery.of(context).size.width / 20,
                                child: Image.asset(
                                  "assets/img/battletraining/1star.png",
                                  fit: BoxFit.fill,
                                  height:
                                      MediaQuery.of(context).size.height / 17,
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height / 13,
                                left: MediaQuery.of(context).size.width / 10,
                                child: GlowText(
                                  "1",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                bottom: MediaQuery.of(context).size.height / 60,
                                right: MediaQuery.of(context).size.width / 40,
                                child: Transform.rotate(
                                  angle: -25 * 3.1415927 / 180,
                                  child: Image.asset(
                                    "assets/img/battletraining/key.png",
                                    fit: BoxFit.fill,
                                    height:
                                        MediaQuery.of(context).size.height / 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ), // level 3
                Positioned(
                  bottom: MediaQuery.of(context).size.height+MediaQuery.of(context).size.height / 2.3,
                  left: MediaQuery.of(context).size.width / 8,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/img/battletraining/board2.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.height / 70,
                          left: MediaQuery.of(context).size.width / 30,
                          right: MediaQuery.of(context).size.width / 50,
                          bottom: MediaQuery.of(context).size.height / 25,
                          child: Container(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                'Giới Thiệu C++',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              )))
                    ],
                  ),
                ),
                //level 4
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    final scale = _animationController.value * 0.05 + 1.0;
                    return Positioned(
                      bottom: MediaQuery.of(context).size.height+MediaQuery.of(context).size.height / 1.6,
                      left: MediaQuery.of(context).size.width / 6,
                      right: MediaQuery.of(context).size.width / 1.8,
                      child: GestureDetector(
                        onTap: () {},
                        child: Transform.scale(
                          scale: scale,
                          child: Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 5.5,
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/battletraining/levelbutton.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 0,
                                right: MediaQuery.of(context).size.width / 20,
                                child: Image.asset(
                                  "assets/img/battletraining/1star.png",
                                  fit: BoxFit.fill,
                                  height:
                                      MediaQuery.of(context).size.height / 17,
                                ),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height / 13,
                                left: MediaQuery.of(context).size.width / 10,
                                child: GlowText(
                                  "1",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Positioned(
                                bottom: MediaQuery.of(context).size.height / 60,
                                right: MediaQuery.of(context).size.width / 40,
                                child: Transform.rotate(
                                  angle: -25 * 3.1415927 / 180,
                                  child: Image.asset(
                                    "assets/img/battletraining/key.png",
                                    fit: BoxFit.fill,
                                    height:
                                        MediaQuery.of(context).size.height / 17,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                // level 4
                Positioned(
                  bottom: MediaQuery.of(context).size.height+MediaQuery.of(context).size.height / 1.5,
                  right: MediaQuery.of(context).size.width / 6,
                  child: Stack(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 8,
                        width: MediaQuery.of(context).size.width / 3,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                "assets/img/battletraining/board2.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Positioned(
                          top: MediaQuery.of(context).size.height / 70,
                          left: MediaQuery.of(context).size.width / 30,
                          right: MediaQuery.of(context).size.width / 50,
                          bottom: MediaQuery.of(context).size.height / 25,
                          child: Container(
                              alignment: Alignment.center,
                              child: AutoSizeText(
                                'Giới Thiệu C++',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                              )))
                    ],
                  ),
                ),
              ],
            ),
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
    );
  }
}
