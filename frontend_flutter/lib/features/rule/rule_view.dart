import 'package:flutter/material.dart';

import '../../constants.dart';

class RuleView extends StatefulWidget {
  const RuleView({super.key});

  @override
  State<RuleView> createState() => _RuleViewState();
}

class _RuleViewState extends State<RuleView> {
  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Center(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
              Positioned(
                bottom: 0,
                top: MediaQuery.of(context).size.height / 15,
                left: MediaQuery.of(context).size.width / 25,
                right: MediaQuery.of(context).size.width / 25,
                child: Container(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 10,
                      top: MediaQuery.of(context).size.width / 6,
                       bottom: MediaQuery.of(context).size.width / 6,
                      right: MediaQuery.of(context).size.width / 10),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/home/frame1.png"),
                          fit: BoxFit.fill)),
                  child: ListView(
                    children: [
                      const Text(
                        '1.Mức Hạng:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        'trò chơi có tổng 5 mức hạng :',
                        style: TextStyle(
                          color: Color.fromARGB(255, 80, 33, 2),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        '+ Intern (số sao từ 0 đến 5)',
                        style: TextStyle(
                          color: Color.fromARGB(255, 80, 33, 2),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.2,
                                height: MediaQuery.of(context).size.height / 20,
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height / 150,
                                bottom:
                                    MediaQuery.of(context).size.height / 150,
                                right: 0,
                                left: MediaQuery.of(context).size.width / 20,
                                child: Container(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                15,
                                        right:
                                            MediaQuery.of(context).size.width /
                                                40),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 68, 148, 165),
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "${getStarLevel(0)[0].toUpperCase()}${getStarLevel(0).substring(1)}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
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
                                    "assets/img/home/${getStarLevel(0)}.png",
                                    width:
                                        MediaQuery.of(context).size.width / 8,
                                    fit: BoxFit.fill,
                                  ))
                            ],
                          ),
                        ],
                      ),
                      const Text(
                        '+ Fresher (số sao từ 6 đến 10)',
                        style: TextStyle(
                          color: Color.fromARGB(255, 80, 33, 2),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.2,
                                height: MediaQuery.of(context).size.height / 20,
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height / 150,
                                bottom:
                                    MediaQuery.of(context).size.height / 150,
                                right: 0,
                                left: MediaQuery.of(context).size.width / 20,
                                child: Container(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                15,
                                        right:
                                            MediaQuery.of(context).size.width /
                                                40),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 68, 148, 165),
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "${getStarLevel(5)[0].toUpperCase()}${getStarLevel(5).substring(1)}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
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
                                    "assets/img/home/${getStarLevel(5)}.png",
                                    width:
                                        MediaQuery.of(context).size.width / 8,
                                    fit: BoxFit.fill,
                                  ))
                            ],
                          ),
                        ],
                      ),
                      const Text(
                        '+ Junior (số sao từ 11 đến 15)',
                        style: TextStyle(
                          color: Color.fromARGB(255, 80, 33, 2),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.2,
                                height: MediaQuery.of(context).size.height / 20,
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height / 150,
                                bottom:
                                    MediaQuery.of(context).size.height / 150,
                                right: 0,
                                left: MediaQuery.of(context).size.width / 20,
                                child: Container(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                15,
                                        right:
                                            MediaQuery.of(context).size.width /
                                                40),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 68, 148, 165),
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "${getStarLevel(13)[0].toUpperCase()}${getStarLevel(13).substring(1)}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
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
                                    "assets/img/home/${getStarLevel(13)}.png",
                                    width:
                                        MediaQuery.of(context).size.width / 8,
                                    fit: BoxFit.fill,
                                  ))
                            ],
                          ),
                        ],
                      ),
                      const Text(
                        '+ Mid-Level (số sao từ 16 đến 20)',
                        style: TextStyle(
                          color: Color.fromARGB(255, 80, 33, 2),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.2,
                                height: MediaQuery.of(context).size.height / 20,
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height / 150,
                                bottom:
                                    MediaQuery.of(context).size.height / 150,
                                right: 0,
                                left: MediaQuery.of(context).size.width / 20,
                                child: Container(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                15,
                                        right:
                                            MediaQuery.of(context).size.width /
                                                40),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 68, 148, 165),
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "${getStarLevel(18)[0].toUpperCase()}${getStarLevel(18).substring(1)}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
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
                                    "assets/img/home/${getStarLevel(18)}.png",
                                    width:
                                        MediaQuery.of(context).size.width / 8,
                                    fit: BoxFit.fill,
                                  ))
                            ],
                          ),
                        ],
                      ),
                      const Text(
                        '+ Senior (số sao từ 21 trở lên)',
                        style: TextStyle(
                          color: Color.fromARGB(255, 80, 33, 2),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width / 3.2,
                                height: MediaQuery.of(context).size.height / 20,
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height / 150,
                                bottom:
                                    MediaQuery.of(context).size.height / 150,
                                right: 0,
                                left: MediaQuery.of(context).size.width / 20,
                                child: Container(
                                    padding: EdgeInsets.only(
                                        left:
                                            MediaQuery.of(context).size.width /
                                                15,
                                        right:
                                            MediaQuery.of(context).size.width /
                                                40),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 68, 148, 165),
                                      borderRadius: BorderRadius.circular(40.0),
                                    ),
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        "${getStarLevel(21)[0].toUpperCase()}${getStarLevel(21).substring(1)}",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
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
                                    "assets/img/home/${getStarLevel(21)}.png",
                                    width:
                                        MediaQuery.of(context).size.width / 8,
                                    fit: BoxFit.fill,
                                  ))
                            ],
                          ),
                        ],
                      ),
                      const Text(
                        '2.Chế độ 1VS1:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        '- Chọn ngôn ngữ chủ đề',
                        style: TextStyle(
                          color: Color.fromARGB(255, 80, 33, 2),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        '- Tìm thấy đối thủ và sẵn sàng',
                        style: TextStyle(
                          color: Color.fromARGB(255, 80, 33, 2),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        '- Giao diện trả lời đối kháng xuất hiện',
                        style: TextStyle(
                          color: Color.fromARGB(255, 80, 33, 2),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        '- Trả lời đúng và nhanh nhất để nhận điểm thưởng tối đa',
                        style: TextStyle(
                          color: Color.fromARGB(255, 80, 33, 2),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        '- x2 điểm câu trả lời ở câu hỏi cuối cùng',
                        style: TextStyle(
                          color: Color.fromARGB(255, 80, 33, 2),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        '- Chiến thắng để nhận thêm 1 sao hoặc trừ đi 1 sao nếu thua',
                        style: TextStyle(
                          color: Color.fromARGB(255, 80, 33, 2),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        '2.Chế độ đấu luyện:',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const Text(
                        '- Chọn ngôi nhà chứa chủ đề ngôn ngữ',
                        style: TextStyle(
                          color: Color.fromARGB(255, 80, 33, 2),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),const Text(
                        '- Chọn cấp độ đã được mở khóa',
                        style: TextStyle(
                          color: Color.fromARGB(255, 80, 33, 2),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),const Text(
                        '- giao diện trả lời xuất hiện hãy trả lời đúng các câu hỏi để nhận được số điểm tối đa',
                        style: TextStyle(
                          color: Color.fromARGB(255, 80, 33, 2),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),const Text(
                        '- Có thể sử dụng 4 chức năng của trò chơi đổi lại sẽ mất 1 lượng vàng nhất định',
                        style: TextStyle(
                          color: Color.fromARGB(255, 80, 33, 2),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),const Text(
                        '- Đúng nhiều câu hỏi nhất để nhận số điểm tối đa cùng vàng và kinh nghiệm đồng thời nếu đạt số sao >=2 sẽ mở khóa level tiếp theo',
                        style: TextStyle(
                          color: Color.fromARGB(255, 80, 33, 2),
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 6.5,
                right: MediaQuery.of(context).size.width / 6.5,
                top: MediaQuery.of(context).size.height / 30,
                bottom: MediaQuery.of(context).size.height / 1.23,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/setting/setting.png"),
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
                              image: AssetImage(
                                  "assets/img/setting/closebutton.png"),
                              fit: BoxFit.fill)),
                    ),
                  ))
            ],
          ),
        ));
  }
}
