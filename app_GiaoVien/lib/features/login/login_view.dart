// ignore_for_file: unused_field
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/ButtonCustom.dart';
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
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Lỗi"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
      appBar: AppBar(
        title: const Text(
          "Trắc Nghiệm Lập Trình",
          style: TextStyle(
            fontFamily: 'Mitr',
            fontWeight: FontWeight.w400,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 79, 148, 1),
      ),
      backgroundColor: Color.fromARGB(255, 255, 252, 252),
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(bottom: 20, top: 20),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Đăng Nhập",
                                style: TextStyle(
                                  fontFamily: 'Mitr',
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ]),
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
                              width: MediaQuery.of(context).size.width,
                              child: Form(
                                key: formGlobalKey,
                                child: Column(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: TextFormField(
                                            controller: emailController,
                                            style: TextStyle(
                                                fontFamily: 'Mitr',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: "Email",
                                                hintStyle: TextStyle(
                                                    fontFamily: 'Mitr',
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0))),
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
                                                          FontWeight.w500),
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
                                          padding: const EdgeInsets.all(10),
                                          child: TextFormField(
                                            controller: passwordController,
                                            obscureText: passwordVisible,
                                            style: TextStyle(
                                                fontFamily: 'Mitr',
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)),
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(),
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
                                                    fontWeight: FontWeight.w400,
                                                    color: Color.fromARGB(
                                                        255, 0, 0, 0))),
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
                                                          FontWeight.w500),
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
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.2,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                15,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: const Color.fromARGB(
                                                      255, 166, 166, 166),
                                                  blurRadius: 7,
                                                  spreadRadius: 1,
                                                  offset: Offset(2, 2))
                                            ],
                                            color: Colors.green,
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        child: Text(
                                          "Đăng Nhập",
                                          style: TextStyle(
                                            fontFamily: 'Mitr',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
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
                        child: CircularProgressIndicator(),
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
