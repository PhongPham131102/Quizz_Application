import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:frontend_flutter/features/change_password/change_password_contract.dart';
import 'package:frontend_flutter/features/change_password/change_password_presenter.dart';

import '../../components/Button.dart';
import '../../components/DialogMessage.dart';
import '../../components/RobotLoading.dart';

class ChangePassWordView extends StatefulWidget {
  const ChangePassWordView({super.key});

  @override
  State<ChangePassWordView> createState() => _ChangePassWordViewState();
}

class _ChangePassWordViewState extends State<ChangePassWordView>
    implements ChangePassWordContract {
  // ignore: unused_field
  late ChangePassWordPresenter _presenter;
  _ChangePassWordViewState() {
    _presenter = ChangePassWordPresenter(this);
  }
  TextEditingController passwordOldController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cFPasswordController = TextEditingController();
  bool passwordOldVisible = true;
  bool passwordVisible = true;
  String validateCurrentPassword = "";
  String validatePassword = "";
  String validateConfirmPassword = "";
  bool cFPasswordVisible = true;
  bool isloading = false;
  @override
  Setisloading(bool _isloading) {
    setState(() {
      isloading = _isloading;
    });
  }

  @override
  SetvalidateConfirmPassword(String _validateConfirmPassword) {
    validateConfirmPassword = _validateConfirmPassword;
    setState(() {});
  }

  @override
  SetvalidateCurrentPassword(String _validateCurrentPassword) {
    validateCurrentPassword = _validateCurrentPassword;
    setState(() {});
  }

  @override
  SetvalidatePassword(String _validatePassword) {
    validatePassword = _validatePassword;
    setState(() {});
  }

  @override
  ShowDialogMessageSuccess() {
    Navigator.pop(context);
    DialogMessage(context, "Thay đổi mật khẩu thành công!");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            IgnorePointer(
              ignoring: isloading,
              child: KeyboardVisibilityBuilder(
                  builder: (context, isKeyboardVisible) {
                return Padding(
                  padding: EdgeInsets.only(bottom: isKeyboardVisible ? 200 : 0),
                  child: Center(
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
                                left: MediaQuery.of(context).size.width / 7,
                                right: MediaQuery.of(context).size.width / 7),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/img/home/frame1.png"),
                                    fit: BoxFit.fill)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Mật khẩu hiện tại:",
                                          style: TextStyle(fontFamily: 'Mitr',
                                              color: Color.fromARGB(
                                                  255, 122, 97, 5),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800),
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
                                              controller: passwordOldController,
                                              obscureText: passwordOldVisible,
                                              style: TextStyle(fontFamily: 'Mitr',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromARGB(
                                                      255, 154, 122, 6)),
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  suffixIcon: IconButton(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    icon: Icon(
                                                      passwordOldVisible
                                                          ? Icons.visibility_off
                                                          : Icons.visibility,
                                                      color: Colors.grey,
                                                      size: 20,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        passwordOldVisible =
                                                            !passwordOldVisible;
                                                      });
                                                    },
                                                  ),
                                                  hintStyle: TextStyle(fontFamily: 'Mitr',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color.fromARGB(
                                                          255, 154, 122, 6))),
                                            ),
                                          ),
                                          validateCurrentPassword != ""
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Text(
                                                    validateCurrentPassword,
                                                    style: TextStyle(fontFamily: 'Mitr',
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
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Mật khẩu mới:",
                                          style: TextStyle(fontFamily: 'Mitr',
                                              color: Color.fromARGB(
                                                  255, 122, 97, 5),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800),
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
                                              controller: passwordController,
                                              obscureText: passwordVisible,
                                              style: TextStyle(fontFamily: 'Mitr',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromARGB(
                                                      255, 154, 122, 6)),
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  suffixIcon: IconButton(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    icon: Icon(
                                                      passwordVisible
                                                          ? Icons.visibility_off
                                                          : Icons.visibility,
                                                      color: Colors.grey,
                                                      size: 20,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        passwordVisible =
                                                            !passwordVisible;
                                                      });
                                                    },
                                                  ),
                                                  hintStyle: TextStyle(fontFamily: 'Mitr',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color.fromARGB(
                                                          255, 154, 122, 6))),
                                            ),
                                          ),
                                          validatePassword != ""
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Text(
                                                    validatePassword,
                                                    style: TextStyle(fontFamily: 'Mitr',
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
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Nhập lại mật khẩu:",
                                          style: TextStyle(fontFamily: 'Mitr',
                                              color: Color.fromARGB(
                                                  255, 122, 97, 5),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800),
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
                                              controller: cFPasswordController,
                                              obscureText: cFPasswordVisible,
                                              style: TextStyle(fontFamily: 'Mitr',
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromARGB(
                                                      255, 154, 122, 6)),
                                              decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  suffixIcon: IconButton(
                                                    padding: EdgeInsets.only(
                                                        top: 10),
                                                    icon: Icon(
                                                      cFPasswordVisible
                                                          ? Icons.visibility_off
                                                          : Icons.visibility,
                                                      color: Colors.grey,
                                                      size: 20,
                                                    ),
                                                    onPressed: () {
                                                      setState(() {
                                                        cFPasswordVisible =
                                                            !cFPasswordVisible;
                                                      });
                                                    },
                                                  ),
                                                  hintStyle: TextStyle(fontFamily: 'Mitr',
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: Color.fromARGB(
                                                          255, 154, 122, 6))),
                                            ),
                                          ),
                                          validateConfirmPassword != ""
                                              ? Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Text(
                                                    validateConfirmPassword,
                                                    style: TextStyle(fontFamily: 'Mitr',
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
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ButtonCustom(
                                      onTap: () async {
                                        _presenter.ValidateAndChangePassWord(
                                            passwordOldController.text,
                                            passwordController.text,
                                            cFPasswordController.text);
                                      },
                                      child: Container(
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
                                          "Đổi mật khẩu",
                                          style: TextStyle(fontFamily: 'Mitr',
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
                                        "assets/img/home/changepassword.gif"),
                                    fit: BoxFit.fill)),
                          ),
                        ),
                        Positioned(
                            top: MediaQuery.of(context).size.height / 15,
                            right: MediaQuery.of(context).size.width / 25,
                            child: ButtonCustom(
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
                            )),
                      ],
                    ),
                  ),
                );
              }),
            ),
            Center(
              child: isloading ? RobotLoading() : Container(),
            )
          ],
        ));
  }
}
