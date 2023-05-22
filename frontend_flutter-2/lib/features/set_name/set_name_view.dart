import 'package:flutter/material.dart';
import 'package:frontend_flutter/features/auth/auth_view.dart';
import 'package:frontend_flutter/features/home/home_view.dart';
import 'package:frontend_flutter/features/set_name/set_name_contract.dart';
import 'package:frontend_flutter/features/set_name/set_name_presenter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/DialogMessage.dart';
import '../../constants.dart';

class SetNameView extends StatefulWidget {
  String token;
  String uid;
  SetNameView({super.key, required this.token, required this.uid});

  @override
  State<SetNameView> createState() => _SetNameViewState();
}

class _SetNameViewState extends State<SetNameView> implements SetNameContract {
  TextEditingController nameController = TextEditingController();
  String validateName = "";
  bool isloading = false;
  late SetNamePresenter _presenter;
  _SetNameViewState() {
    _presenter = SetNamePresenter(this);
  }
  @override
  void setisloading(bool _isloading) {
    isloading = _isloading;
    setState(() {});
  }

  @override
  void setvalidateName(String _validateName) {
    validateName = _validateName;
    setState(() {});
  }

  @override
  Future<void> settoken(String value) async {
    token = value;
    final SharedPreferences cookie = await SharedPreferences.getInstance();
    cookie.setString('token', value);
  }

  @override
  Future<void> setuid(String value) async {
    uid = value;
    final SharedPreferences cookie = await SharedPreferences.getInstance();
    cookie.setString('uid', value);
  }

  @override
  void showDialog(String message) {
    DialogMessage(context, message);
  }

  @override
  void pushHomeScreen() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            IgnorePointer(
              ignoring: isloading,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(
                          "assets/img/home/bg.png",
                        ),
                        fit: BoxFit.fill)),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 80),
                        width: 230,
                        height: 90,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/img/home/logo.png"),
                                fit: BoxFit.fill)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding:
                                EdgeInsets.only(left: 35, right: 70, top: 40),
                            margin: EdgeInsets.only(top: 50),
                            width: MediaQuery.of(context).size.width - 40,
                            height: MediaQuery.of(context).size.height / 2.7,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/img/home/frame2.png"),
                                    fit: BoxFit.fill)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nhập tên nhân vật:",
                                      style: TextStyle(
                                          color: Color(0xFF502102),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.only(
                                            bottom: 8, left: 12, right: 20),
                                        width: 220,
                                        height: 50,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  'assets/img/home/textbutton2.png',
                                                ),
                                                fit: BoxFit.fill)),
                                        child: TextField(
                                          controller: nameController,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromARGB(
                                                  255, 154, 122, 6)),
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintStyle: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromARGB(
                                                      255, 154, 122, 6))),
                                        ),
                                      ),
                                      validateName != ""
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                left: 5,
                                              ),
                                              child: Text(
                                                validateName,
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          : Container(
                                              width: 0,
                                              height: 0,
                                            ),
                                    ],
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Lưu Ý:",
                                      style: TextStyle(
                                          color: Color(0xFFFF0303),
                                          fontSize: 15,
                                          fontWeight: FontWeight.w900),
                                    ),
                                  ],
                                ),
                                Text(
                                  "Tên nhân vật không quá 15 ký tự",
                                  maxLines: 2,
                                  softWrap: true,
                                  style: TextStyle(
                                      color: Color(0xFF502102),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w900),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () => _presenter.SetName(
                                          this.widget.token,
                                          this.widget.uid,
                                          nameController.text.trim()),
                                      child: Container(
                                        margin: EdgeInsets.only(top: 10),
                                        width: 140,
                                        height: 45,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/img/home/button.png"),
                                              fit: BoxFit.fill),
                                        ),
                                        child: Text(
                                          "Tiếp theo",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ]),
              ),
            ),
            isloading
                ? Positioned(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ));
  }
}
