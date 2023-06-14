import 'package:flutter/material.dart';
import 'package:frontend_flutter/features/personal_profile/personal_profile_contract.dart';
import 'package:intl/intl.dart';
import '../../models/Profile.dart';
import '../../spine_flutter.dart';

class PersonalProfileView extends StatefulWidget {
  Profile profile;
  bool you;
  PersonalProfileView({super.key, required this.profile, required this.you});

  @override
  State<PersonalProfileView> createState() => _PersonalProfileViewState();
}

class _PersonalProfileViewState extends State<PersonalProfileView>
    implements PersonalProfileContract {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width / 1.2,
            height: MediaQuery.of(context).size.height / 1.2,
            decoration: BoxDecoration(
                color: Color(0xFFDA7931),
                borderRadius: BorderRadius.circular(5)),
            child: Container(
              width: MediaQuery.of(context).size.width / 1.25,
              height: MediaQuery.of(context).size.height / 1.22,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/home/bgpersonalpage.png"),
                      alignment: Alignment.topCenter,
                      fit: BoxFit.fitWidth),
                  color: Color.fromARGB(255, 238, 222, 209),
                  borderRadius: BorderRadius.circular(5)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            alignment: Alignment.center,
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                color: Color(0xFFDA7931),
                                borderRadius: BorderRadius.circular(5)),
                            child: Container(
                              padding: EdgeInsets.all(10),
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/home/bgpersonalpage.png"),
                                      alignment: Alignment.topCenter,
                                      fit: BoxFit.fitWidth),
                                  color: Color.fromARGB(255, 241, 197, 161),
                                  borderRadius: BorderRadius.circular(5)),
                              child: CustomPaint(
                                painter: XMarkPainter(),
                              ),
                            ),
                          ),
                        ),
                      )
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
                                    color: Color.fromARGB(255, 238, 222, 209),
                                    borderRadius: BorderRadius.circular(5)),
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
                                    color: Color.fromARGB(255, 238, 222, 209),
                                    borderRadius: BorderRadius.circular(5)),
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
                                    color: Color.fromARGB(255, 238, 222, 209),
                                    borderRadius: BorderRadius.circular(5)),
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
                                    color: Color.fromARGB(255, 238, 222, 209),
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )),
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