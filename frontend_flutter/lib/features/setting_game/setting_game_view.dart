import 'package:flutter/material.dart';
import 'package:frontend_flutter/constants.dart';
import 'package:frontend_flutter/features/feedback/feedback_view.dart';
import 'package:frontend_flutter/features/login/login_view.dart';
import 'package:frontend_flutter/features/setting_game/setting_game_contract.dart';
import 'package:frontend_flutter/features/setting_game/setting_game_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingGameView extends StatefulWidget {
  const SettingGameView({super.key});

  @override
  State<SettingGameView> createState() => _SettingGameViewState();
}

class _SettingGameViewState extends State<SettingGameView>
    implements SettingGameContract { 
      // ignore: unused_field
  late SettingGamePresenter _presenter;
  _SettingGameViewState() {
    _presenter = SettingGamePresenter(this);
  }
  bool isSwitched = false;

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Center(
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
              ),
              Positioned(
                bottom: 0,
                top: MediaQuery.of(context).size.height / 15,
                left: MediaQuery.of(context).size.width / 25,
                right: MediaQuery.of(context).size.width / 25,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/img/setting/frame.png"),
                          fit: BoxFit.fill)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        width: MediaQuery.of(context).size.width / 1.5,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        height: MediaQuery.of(context).size.width / 7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: Image.asset(
                                    "assets/img/setting/speakericon.png",
                                    fit: BoxFit.fill,
                                    width:
                                        MediaQuery.of(context).size.width / 7,
                                    height:
                                        MediaQuery.of(context).size.width / 7,
                                  ),
                                ),
                                Text(
                                  "Âm thanh",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ],
                            ),
                            Switch(
                              value: isSwitched,
                              onChanged: (value) {
                                setState(() {
                                  isSwitched = value;
                                });
                              },
                              activeColor: Colors.white,
                              activeTrackColor: Colors.brown,
                              inactiveThumbColor: Colors.grey,
                              inactiveTrackColor: Colors.grey[300],
                              thumbColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Color.fromARGB(255, 198, 64, 15);
                                }
                                return Colors.grey;
                              }),
                              overlayColor: MaterialStateProperty.all<Color>(
                                  Colors.transparent),
                              splashRadius: 16.0,
                            )
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // showDialog(
                          //   context: context,
                          //   builder: (context) => PersonalInformationScreen(),
                          // );
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          width: MediaQuery.of(context).size.width / 1.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: MediaQuery.of(context).size.width / 7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: Image.asset(
                                      "assets/img/setting/inforicon.png",
                                      fit: BoxFit.fill,
                                      width:
                                          MediaQuery.of(context).size.width / 7,
                                      height:
                                          MediaQuery.of(context).size.width / 7,
                                    ),
                                  ),
                                  Text(
                                    "Thông tin cá nhân",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => FeedBackView());
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 1.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          height: MediaQuery.of(context).size.width / 7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(right: 20),
                                    child: Image.asset(
                                      "assets/img/setting/feedbackicon.png",
                                      fit: BoxFit.fill,
                                      width:
                                          MediaQuery.of(context).size.width / 7,
                                      height:
                                          MediaQuery.of(context).size.width / 7,
                                    ),
                                  ),
                                  Text(
                                    "Góp ý",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString('token', '');
                                prefs.setString('uid', '');
                              token="";
                              uid="";
                              Navigator.pop(context);
                              Navigator.push(context,MaterialPageRoute(builder: (context) => Login(),));
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: MediaQuery.of(context).size.width / 3.5,
                                height: MediaQuery.of(context).size.height / 20,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  image: AssetImage(
                                      "assets/img/maingame/button.png"),
                                  fit: BoxFit.fill,
                                )),
                                child: Text(
                                  "Đăng Xuất",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width / 10,
                right: MediaQuery.of(context).size.width / 10,
                top: 0,
                bottom: MediaQuery.of(context).size.height / 2.7,
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
