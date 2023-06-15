import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';

class RankView extends StatefulWidget {
  const RankView({super.key});

  @override
  State<RankView> createState() => _RankViewState();
}

class _RankViewState extends State<RankView> with TickerProviderStateMixin {
  late AnimationController _animationController1;
  bool _isExpanded1 = false;
  @override
  void initState() {
    _animationController1 = AnimationController(
      vsync: this,
      duration: Duration(
          milliseconds: 2000), // Điều chỉnh thời gian phóng to và thu nhỏ
    );

    _animationController1.addListener(() {
      if (_animationController1.status == AnimationStatus.completed ||
          _animationController1.status == AnimationStatus.dismissed) {
        _toggleSize1();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _toggleSize1();
    });
    super.initState();
  }

  void _toggleSize1() {
    setState(() {
      _isExpanded1 = !_isExpanded1;
      if (_isExpanded1) {
        _animationController1.forward();
      } else {
        _animationController1.reverse();
      }
    });
  }

  @override
  void dispose() {
    _animationController1.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 15),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/img/battle/bg2.jpg"),
                fit: BoxFit.fill)),
        child: Column(
          children: [
            Stack(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 2.05,
                  height: MediaQuery.of(context).size.height / 12,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/battle/review.png"),
                          fit: BoxFit.fill)),
                  child: GlowText(
                    "Đấu Hạng",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: MediaQuery.of(context).size.width / 2.05,
                  height: MediaQuery.of(context).size.height / 12,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/battle/review.png"),
                          fit: BoxFit.fill)),
                  child: GlowText(
                    "Đấu Luyện",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 25,
                  right: MediaQuery.of(context).size.width / 25),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 15,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 25),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: MediaQuery.of(context).size.height / 15,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/img/battle/button.png"),
                                fit: BoxFit.fill)),
                        child: Text(
                          "C++",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 25),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: MediaQuery.of(context).size.height / 15,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/img/battle/button.png"),
                                fit: BoxFit.fill)),
                        child: Text(
                          "SQL",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 25),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: MediaQuery.of(context).size.height / 15,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/img/battle/button.png"),
                                fit: BoxFit.fill)),
                        child: Text(
                          "HTMl",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width / 2.3,
                        height: MediaQuery.of(context).size.height / 15,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/img/battle/button.png"),
                                fit: BoxFit.fill)),
                        child: Text(
                          "CSS",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "trượt sang phải để xem thêm BXH ngôn ngữ khác.",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      fontStyle: FontStyle.italic),
                )
              ],
            ),
            AnimatedBuilder(
                animation: _animationController1,
                builder: (context, child) {
                  final scale = _animationController1.value * 5;
                  return Container(
                    padding: EdgeInsets.only(bottom: scale),
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage("assets/img/battle/boardques.png"),
                            fit: BoxFit.fill)),
                    child: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 3,
                        ),
                        Positioned(
                            top: MediaQuery.of(context).size.height / 30,
                            left: MediaQuery.of(context).size.width / 15,
                            child: Column(
                              children: [
                                Text(
                                  "Chế độ:",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                GlowText(
                                  "Đấu hạng",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 13,
                                      color: Color.fromARGB(255, 243, 240, 38),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        Positioned(
                            top: MediaQuery.of(context).size.height / 30,
                            right: MediaQuery.of(context).size.width / 15,
                            child: Column(
                              children: [
                                Text(
                                  "Ngôn ngữ:",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                GlowText(
                                  "C++",
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 13,
                                      color: Color.fromARGB(255, 243, 240, 38),
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        //1st
                        Positioned(
                          top: MediaQuery.of(context).size.height / 30 + scale,
                          left: MediaQuery.of(context).size.width / 3,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              height: MediaQuery.of(context).size.height / 4.5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/img/home/1stlogo.png',
                                    width:
                                        MediaQuery.of(context).size.width / 10,
                                    height:
                                        MediaQuery.of(context).size.height / 25,
                                    fit: BoxFit.fill,
                                  ),
                                  Stack(
                                    children: [
                                      Positioned(
                                        left: 5,
                                        top: 2,
                                        child: CircleAvatar(
                                          foregroundColor: Colors.red,
                                          backgroundImage: AssetImage(
                                              'assets/img/battle/frameavtwin.png'),
                                          radius: 45,
                                        ),
                                      ),
                                      Image.asset(
                                        'assets/img/home/st1.png',
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.fill,
                                      )
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      'phong',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 9, 15, 198),
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '1010 điểm',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 213, 239, 13),
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        //2rd
                        Positioned(
                          top: MediaQuery.of(context).size.height / 9 + scale,
                          left: MediaQuery.of(context).size.width / 20,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3.5,
                              height: MediaQuery.of(context).size.height / 5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/img/home/3stlogo.png',
                                    width: 25,
                                    height: 20,
                                    fit: BoxFit.fill,
                                  ),
                                  Stack(
                                    children: [
                                      Positioned(
                                        left: 12,
                                        top: 2,
                                        child: CircleAvatar(
                                          foregroundColor: Colors.red,
                                          backgroundImage: AssetImage(
                                              'assets/img/battle/frameavtwin.png'),
                                          radius: 38,
                                        ),
                                      ),
                                      Image.asset(
                                        'assets/img/home/st3.png',
                                        width: 100,
                                        height: 80,
                                        fit: BoxFit.fill,
                                      )
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      'phong phạm',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 9, 15, 198),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '1099 điểm',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 213, 239, 13),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //3nd
                        Positioned(
                          top: MediaQuery.of(context).size.height / 12 + scale,
                          right: MediaQuery.of(context).size.width / 15,
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 110,
                              height: 155,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    'assets/img/home/2stlogo.png',
                                    width: 30,
                                    height: 25,
                                    fit: BoxFit.fill,
                                  ),
                                  Stack(
                                    children: [
                                      Positioned(
                                        left: 12,
                                        top: 2,
                                        child: CircleAvatar(
                                          foregroundColor: Colors.red,
                                          backgroundImage: AssetImage(
                                              'assets/img/battle/frameavtwin.png'),
                                          radius: 38,
                                        ),
                                      ),
                                      Image.asset(
                                        'assets/img/home/st2.png',
                                        width: 100,
                                        height: 80,
                                        fit: BoxFit.fill,
                                      )
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: 80,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Text(
                                      'phong',
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 9, 15, 198),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '999 điểm',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 213, 239, 13),
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                }),
            Container(
              margin: EdgeInsets.all(5),
              padding: EdgeInsets.all(5),
              height: MediaQuery.of(context).size.height / 3.5,
              decoration: BoxDecoration(
                  color: Color.fromARGB(255, 109, 182, 249),
                  borderRadius: BorderRadius.circular(10)),
              child: Container(
                height: MediaQuery.of(context).size.height / 3.4,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 36, 71, 116),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
