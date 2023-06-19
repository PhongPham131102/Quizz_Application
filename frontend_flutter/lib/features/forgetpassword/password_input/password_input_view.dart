import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:frontend_flutter/features/forgetpassword/password_input/password_input_contract.dart';
import 'package:frontend_flutter/features/forgetpassword/password_input/password_input_presenter.dart';

import '../../../components/Button.dart';
import '../../../components/DialogMessage.dart';
import '../../../components/Robot.dart';

// ignore: must_be_immutable
class PasswordInput extends StatefulWidget {
  String email;
  PasswordInput({super.key, required this.email});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput>
    implements PasswordInputContract {
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cFPasswordController = TextEditingController();
  String validatePassWord = "";
  bool isloading = false;
  String validateCfPassWord = "";
  bool passwordVisible = true;
  bool cFPasswordVisible = true;
  late PasswordInputPresenter _presenter;
  _PasswordInputState() {
    _presenter = PasswordInputPresenter(this);
  }
  @override
  void setcFPasswordVisible(bool _cFPasswordVisible) {
    cFPasswordVisible = _cFPasswordVisible;
    setState(() {});
  }

  @override
  void setisloading(bool _isloading) {
    isloading = _isloading;
    setState(() {});
  }

  @override
  void setpasswordVisible(bool _passwordVisible) {
    passwordVisible = _passwordVisible;
    setState(() {});
  }

  @override
  void setvalidateCfPassWord(String _validateCfPassWord) {
    validateCfPassWord = _validateCfPassWord;
    setState(() {});
  }

  @override
  void setvalidatePassWord(String _validatePassWord) {
    validatePassWord = _validatePassWord;
    setState(() {});
  }

  @override
  void showDialogMessage(String message, bool isPop) {
    if (isPop) {
      Navigator.pop(context);
    }
    DialogMessage(context, message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/img/home/bg.png",
                  ),
                  fit: BoxFit.fill)),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: 40,
                          ),
                          padding: EdgeInsets.only(left: 50, right: 50),
                          width: 320,
                          height: 300,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage("assets/img/home/frame.png"),
                                fit: BoxFit.fill),
                          ),
                          child: Form(
                            key: formGlobalKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
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
                                              padding: EdgeInsets.only(top: 10),
                                              icon: Icon(
                                                passwordVisible
                                                    ? Icons.visibility_off
                                                    : Icons.visibility,
                                                color: Colors.grey,
                                                size: 20,
                                              ),
                                              onPressed: () => _presenter
                                                  .togglePasswordVisibility(
                                                      passwordVisible),
                                            ),
                                            hintText: "Mật Khẩu",
                                            hintStyle: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: Color.fromARGB(
                                                    255, 154, 122, 6))),
                                        validator: (value) => _presenter
                                            .checkPasswordValidity(value!),
                                      ),
                                    ),
                                    validatePassWord != ""
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              validatePassWord,
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        : Container(
                                            width: 0,
                                            height: 0,
                                          ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(bottom: 10),
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
                                          controller: cFPasswordController,
                                          obscureText: cFPasswordVisible,
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
                                                  cFPasswordVisible
                                                      ? Icons.visibility_off
                                                      : Icons.visibility,
                                                  color: Colors.grey,
                                                  size: 20,
                                                ),
                                                onPressed: () => _presenter
                                                    .toggleCfPasswordVisibility(
                                                        cFPasswordVisible),
                                              ),
                                              hintText: "Nhập Lại Mật Khẩu",
                                              hintStyle: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: Color.fromARGB(
                                                      255, 154, 122, 6))),
                                          validator: (value) => _presenter
                                              .checkCfPasswordValidity(value!,
                                                  passwordController.text)),
                                    ),
                                    validateCfPassWord != ""
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              validateCfPassWord,
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        : Container(
                                            width: 0,
                                            height: 0,
                                          ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ButtonCustom(
                                      onTap: () {
                                        if (formGlobalKey.currentState!
                                            .validate()) {
                                          _presenter.handleChangePassWord(
                                              validatePassWord,
                                              validateCfPassWord,
                                              this.widget.email,
                                              passwordController.text.trim());
                                        }
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
                        ),
                        Positioned(
                          left: 10,
                          right: 10,
                          child: Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height/8,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/img/home/forgetpassword.gif"),
                                  fit: BoxFit.fill),
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      height: isKeyboardVisible ? 220 : 0,
                    )
                  ],
                ),
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
        );
      }),
    );
  }
}
