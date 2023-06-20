// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:frontend_flutter/features/forgetpassword/email_input/email_input_view.dart';
import 'package:frontend_flutter/features/home/home_view.dart';
import 'package:frontend_flutter/features/login/login_contract.dart';
import 'package:frontend_flutter/features/login/login_presenter.dart';
import 'package:frontend_flutter/features/pick_character/pick_character_view.dart';
import 'package:frontend_flutter/features/set_name/set_name_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../components/Button.dart';
import '../../components/DialogMessage.dart';
import '../../components/Robot.dart';
import '../../constants.dart';
import '../register/register_view.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> implements LoginContract {
  late LoginPresenter _presenter;
  _LoginState() {
    _presenter = LoginPresenter(this);
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
  void pushInfor(message) {
    DialogMessage(context, message);
  }

  @override
  void login() {
    if (formGlobalKey.currentState!.validate()) {
      if (validateEmail == "" && validatePassWord == "") {
        _presenter.login(emailController.text, passwordController.text);
      }
    }
  }

  @override
  void setIsLoading(bool _isloading) {
    setState(() {
      isloading = _isloading;
    });
  }

  String _token = "";
  @override
  void set_token(String value) {
    _token = value;
  }

  String _uid = "";
  @override
  void set_uid(String value) {
    _uid = value;
  }

  @override
  void pushPickCharacterScreen() {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PickCharacterView(
                  token: _token,
                  uid: _uid,
                )));
  }

  @override
  void pushSetNameScreen() {
    FocusScope.of(context).unfocus();
    print("pushSetNameScreen");
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SetNameView(token: _token, uid: _uid),
        ));
  }

  @override
  void pushHomeScreen() {
    FocusScope.of(context).unfocus();
    print("pushHomeScreen");
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomeView()));
  }

  bool passwordVisible = true;
  final formGlobalKey = GlobalKey<FormState>();
  bool isloading = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String validateEmail = "";
  String validatePassWord = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
          children: [
            IgnorePointer(
              ignoring: isloading,
              child: KeyboardVisibilityBuilder(
                  builder: (context, isKeyboardVisible) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/img/home/bg.png",
                          ),
                          fit: BoxFit.fill)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 80),
                        width: 230,
                        height: 90,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/img/home/logo.gif"),
                                fit: BoxFit.fill)),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: isKeyboardVisible
                                ? MediaQuery.of(context).size.height / 4
                                : 0),
                        child: Stack(
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 40),
                              padding: EdgeInsets.only(top: 70, bottom: 50),
                              constraints: BoxConstraints(
                                minWidth: 320,
                                minHeight: 300,
                              ),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/img/home/frame.png"),
                                    fit: BoxFit.fill),
                              ),
                              child: Form(
                                key: formGlobalKey,
                                child: Column(
                                  children: [
                                    Column(
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
                                          child: TextFormField(
                                            controller: emailController,
                                            style: TextStyle(
                                                fontFamily: 'Mitr',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromARGB(
                                                    255, 154, 122, 6)),
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText: "Email",
                                                hintStyle: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color.fromARGB(
                                                        255, 154, 122, 6))),
                                            validator: (value) {
                                              if (value == "") {
                                                validateEmail =
                                                    "Bạn chưa nhập email";
                                              } else {
                                                validateEmail = "";
                                              }
                                              setState(() {});
                                              return null;
                                            },
                                          ),
                                        ),
                                        validateEmail != ""
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, bottom: 5),
                                                child: Text(
                                                  validateEmail,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
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
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              bottom: 8, left: 12),
                                          width: 220,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                    'assets/img/home/textbutton2.png',
                                                  ),
                                                  fit: BoxFit.fill)),
                                          child: TextFormField(
                                            controller: passwordController,
                                            obscureText: passwordVisible,
                                            style: TextStyle(
                                                fontFamily: 'Mitr',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromARGB(
                                                    255, 154, 122, 6)),
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                suffixIcon: IconButton(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
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
                                                hintText: "Mật Khẩu",
                                                hintStyle: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color.fromARGB(
                                                        255, 154, 122, 6))),
                                            validator: (value) {
                                              if (value == "") {
                                                validatePassWord =
                                                    "Bạn chưa nhập mật khẩu";
                                              } else {
                                                validatePassWord = "";
                                              }

                                              setState(() {});
                                              return null;
                                            },
                                          ),
                                        ),
                                        validatePassWord != ""
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5, bottom: 5),
                                                child: Text(
                                                  validatePassWord,
                                                  style: TextStyle(
                                                      fontFamily: 'Mitr',
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
                                    Container(
                                      width: 220,
                                      padding: EdgeInsets.only(left: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          ButtonCustom(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        EmailImputView(),
                                                  ));
                                            },
                                            child: Text(
                                              "Quên mật khẩu?",
                                              style: TextStyle(
                                                fontFamily: 'Mitr',
                                                color: Color.fromARGB(
                                                    255, 135, 103, 4),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    ButtonCustom(
                                      onTap: () => login(),
                                      child: Container(
                                        width: 220,
                                        height: 65,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/img/home/button.png"),
                                              fit: BoxFit.fill),
                                        ),
                                        child: Text(
                                          "Đăng Nhập",
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 10,
                              right: 10,
                              child: Container(
                                alignment: Alignment.center,
                                height: MediaQuery.of(context).size.height / 8,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          "assets/img/home/login.gif"),
                                      fit: BoxFit.fill),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Bạn chưa có tài khoản ?",
                              style: TextStyle(
                                fontFamily: 'Mitr',
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Register(),
                                    ));
                              },
                              child: Text(
                                "Đăng Ký Ngay!",
                                style: TextStyle(
                                    fontFamily: 'Mitr',
                                    color: Colors.yellow,
                                    fontWeight: FontWeight.w800,
                                    fontStyle: FontStyle.italic),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            isloading
                ? Positioned(
                    child: ButtonCustom(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Center(
                          child: Robot(),
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
