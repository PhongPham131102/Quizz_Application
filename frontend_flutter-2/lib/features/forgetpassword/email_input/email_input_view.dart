import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:frontend_flutter/features/forgetpassword/email_input/email_input_contract.dart';
import 'package:frontend_flutter/features/forgetpassword/email_input/email_input_presenter.dart';
import 'package:frontend_flutter/features/forgetpassword/otp_input/otp_input_view.dart';
import 'package:frontend_flutter/repository/forgetpassword/email_input/get_email_input_contract.dart';

class EmailImputView extends StatefulWidget {
  const EmailImputView({super.key});

  @override
  State<EmailImputView> createState() => _EmailImputViewState();
}

class _EmailImputViewState extends State<EmailImputView>
    implements EmailInputContract {
  late EmailInputPresenter _presenter;
  _EmailImputViewState() {
    _presenter = new EmailInputPresenter(this);
  }
  bool isloading = false;
  TextEditingController emailController = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();
  String emailCheck = "";

  @override
  void setEmailCheck(String message) {
    emailCheck = message;
    setState(() {});
  }

  @override
  void setisLoading(bool _isLoading) {
    isloading = _isLoading;
    setState(() {});
  }

  @override
  void showSnackbar(String message) {
    print(message);
    _showSnackbar(message);
  }

  @override
  void pushOTPInputScreen(String otp) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => OTPInput(
            otp: otp,
            email: emailController.text,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return Stack(
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
                  child: SingleChildScrollView(
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
                                    image:
                                        AssetImage("assets/img/home/frame.png"),
                                    fit: BoxFit.fill),
                              ),
                              child: Form(
                                key: formGlobalKey,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Nhập email:",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 122, 97, 5),
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ],
                                    ),
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
                                        controller: emailController,
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
                                                255, 154, 122, 6),
                                          ),
                                        ),
                                        validator: (value) {
                                          _presenter.checkvalidEmail(value!);
                                        },
                                      ),
                                    ),
                                    emailCheck != ""
                                        ? Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                              emailCheck,
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (formGlobalKey.currentState!
                                                .validate()) {
                                                
                                              _presenter.checkEmail(emailCheck,
                                                  emailController.text);
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
                                      image: AssetImage(
                                          "assets/img/home/forgetpassword.png"),
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
          );
        },
      ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
