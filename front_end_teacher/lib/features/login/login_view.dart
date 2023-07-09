// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/ButtonCustom.dart';
import '../../components/DialogMessage.dart';
import '../../components/RobotLoading.dart';
import '../../constants.dart';
import '../home/home_view.dart';
import 'login_contract.dart';
import 'login_presenter.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> implements LoginContract {
  late LoginPresenter _presenter;
  _LoginViewState() {
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

  @override
  void pushHomeScreen() {
    FocusScope.of(context).unfocus();
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
                            "assets/img/bg.png",
                          ),
                          fit: BoxFit.fill)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: 80,
                            bottom: isKeyboardVisible
                                ? 0
                                : MediaQuery.of(context).size.height / 10),
                        width: 230,
                        height: 90,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/img/logo.gif"),
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
                                    image: AssetImage("assets/img/frame.png"),
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
                                                    'assets/img/textbutton2.png',
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
                                                    'assets/img/textbutton2.png',
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
                                    ButtonCustom(
                                      onTap: () => login(),
                                      child: Container(
                                        width: 220,
                                        height: 65,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "assets/img/button.png"),
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
                                      image: AssetImage("assets/img/login.gif"),
                                      fit: BoxFit.fill),
                                ),
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
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                        child: RobotLoading(),
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
