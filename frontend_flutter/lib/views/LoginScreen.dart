import 'dart:convert';

import "package:flutter/material.dart";
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:frontend_flutter/services/UserService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../components/DialogMessage.dart';
import "../constants.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> set_token(String value) async {
    token = value;
    final SharedPreferences cookie = await SharedPreferences.getInstance();
    cookie.setString('token', value);
  }

  Future<void> set_uid(String value) async {
    uid = value;
    final SharedPreferences cookie = await SharedPreferences.getInstance();
    cookie.setString('uid', value);
  }

  bool passwordVisible = true;
  final formGlobalKey = GlobalKey<FormState>();
  bool isloading = false;
  TextEditingController EmailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String validateEmail = "";
  String validatePassWord = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
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
                              image: AssetImage("assets/img/home/logo.png"),
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
                                          controller: EmailController,
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromARGB(
                                                  255, 154, 122, 6)),
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Email",
                                              hintStyle: TextStyle(
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
                                        InkWell(
                                          onTap: () {
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //       builder: (context) =>
                                            //           ForgetPassWordFillEmailScreen(),
                                            //     ));
                                          },
                                          child: Text(
                                            "Quên mật khẩu?",
                                            style: TextStyle(
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
                                  InkWell(
                                    onTap: () async {
                                      FocusScope.of(context)
                                          .requestFocus(new FocusNode());
                                      if (formGlobalKey.currentState!
                                          .validate()) {
                                        if (validateEmail == "" &&
                                            validatePassWord == "") {
                                          setState(() {
                                            isloading = true;
                                          });
                                          http.Response responseuser =
                                              await UserService().login(
                                                  EmailController.text,
                                                  passwordController.text);
                                          setState(() {
                                            isloading = false;
                                          });
                                          if (responseuser.statusCode == 401) {
                                            DialogMessage(context,
                                                "Email hoặc mật khẩu không đúng!");
                                          } else if (responseuser.statusCode ==
                                              200) {
                                            String token = jsonDecode(
                                                responseuser.body)['token'];
                                            String id = jsonDecode(
                                                responseuser.body)['id'];
                                            setState(() {
                                              isloading = true;
                                            });
                                            //   UserProfile userProfile =
                                            //       await UserProfileController()
                                            //           .checkUser(token);
                                            //   setState(() {
                                            //     isloading = false;
                                            //   });
                                            //   if (userProfile.gender == "") {
                                            //     Navigator.pushNamed(
                                            //       context,
                                            //       '/PickCharacter',
                                            //       arguments: {
                                            //         'token': token,
                                            //         "uid": userProfile.uid,
                                            //       },
                                            //     );
                                            //   } else if (userProfile.name == "") {
                                            //     Navigator.pushNamed(
                                            //       context,
                                            //       '/SetName',
                                            //       arguments: {
                                            //         'token': token,
                                            //         "uid": userProfile.uid
                                            //       },
                                            //     );
                                            //   } else {
                                            //     set_token(token);
                                            //     set_uid(userProfile.uid);
                                            //     Navigator.pushNamed(
                                            //       context,
                                            //       '/Home',
                                            //       arguments: {
                                            //         'token': token,
                                            //         "uid": userProfile.uid
                                            //       },
                                            //     );
                                            //   }
                                            // } else {
                                            //   DialogMessage(context,
                                            //       "Lỗi bất định vui lòng thử lại sau!");
                                            // }
                                          }
                                        }
                                      }

                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //       builder: (context) =>
                                      //           PickCharacterScreen(),
                                      //     ));
                                    },
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
                              width: 250,
                              height: 90,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage("assets/img/home/login.png"),
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
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Navigator.pop(context);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => RegisterScreen(),
                              //     ));
                            },
                            child: Text(
                              "Đăng Ký Ngay!",
                              style: TextStyle(
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
      ),
    );
  }
}
