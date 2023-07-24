import 'package:flutter/material.dart';

import '../spine_flutter.dart';

class Robot extends StatefulWidget {
  @override
  _RobotState createState() => _RobotState();
}

class _RobotState extends State<Robot> {
  @override
  void initState() {
    loadingCharacter();
    super.initState();
  }

  late String animation;
  late SkeletonAnimation skeleton;
  bool isLoadingCharacter = false;
  loadingCharacter() async {
    print("object");
    animation = "animation";
    isLoadingCharacter = false;
    setState(() {});
    skeleton = await SkeletonAnimation.createWithFiles("robot",
        pathBase: "assets/img/character/");
    skeleton.state.setAnimation(0, animation, true);
    isLoadingCharacter = true;
    if (mounted) {
      setState(() {});
      print("object");
    }
  }

  Widget _buidRobot() {
    return SkeletonRenderObjectWidget(
      skeleton: skeleton,
      alignment: Alignment.center,
      fit: BoxFit.fitWidth,
      playState: PlayState.playing,
      debugRendering: false,
      triangleRendering: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
            width: MediaQuery.of(context).size.width / 5,
            height: MediaQuery.of(context).size.height / 6,
            child: isLoadingCharacter ? _buidRobot() : Container()),
      ),
    );
  }
}
