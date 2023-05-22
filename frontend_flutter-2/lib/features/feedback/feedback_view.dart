import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:frontend_flutter/features/feedback/feedback_contract.dart';
import 'package:frontend_flutter/features/feedback/feedback_presenter.dart';

class FeedBackView extends StatefulWidget {
  const FeedBackView({super.key});

  @override
  State<FeedBackView> createState() => _FeedBackViewState();
}

class _FeedBackViewState extends State<FeedBackView>
    implements FeedBackContract {
  late FeedBackPresenter _presenter;
  _FeedBackViewState() {
    _presenter = FeedBackPresenter(this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: isKeyboardVisible?MainAxisAlignment.start:MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 1.5,
                      ),
                      Positioned(
                        bottom: 0,
                        top: MediaQuery.of(context).size.height / 15,
                        left: MediaQuery.of(context).size.width / 25,
                        right: MediaQuery.of(context).size.width / 25,
                        child: Container(
                          padding: EdgeInsets.only(
                              top: 30,
                              left: MediaQuery.of(context).size.width / 7,
                              right: MediaQuery.of(context).size.width / 7),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage("assets/img/home/frame1.png"),
                                  fit: BoxFit.fill)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Nhập nội dung góp ý bên dưới nhé.",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.black),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin:
                                        EdgeInsets.only(bottom: 10, top: 10),
                                    padding:
                                        EdgeInsets.only(left: 12, right: 20),
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    height: MediaQuery.of(context).size.height /
                                        2.6,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: TextField(
                                      maxLines: null,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            "Nhập góp ý của bạn ở đây...",
                                        hintStyle: TextStyle(
                                          color:
                                              Color.fromARGB(255, 122, 97, 5),
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 122, 97, 5),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          width: 120,
                                          height: 30,
                                          alignment: Alignment.center,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                    "assets/img/home/button.png"),
                                                fit: BoxFit.fill),
                                          ),
                                          child: Text(
                                            "Gửi",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: MediaQuery.of(context).size.width / 10,
                        right: MediaQuery.of(context).size.width / 10,
                        top: 0,
                        bottom: MediaQuery.of(context).size.height / 1.9,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/img/home/feedback.png"),
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
                                        "assets/img/home/closebutton.png"),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
