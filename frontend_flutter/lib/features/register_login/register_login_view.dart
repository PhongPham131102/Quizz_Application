import 'package:flutter/material.dart';
import 'package:frontend_flutter/features/login/login_view.dart';
import 'package:frontend_flutter/features/register/register_view.dart';
import 'package:frontend_flutter/features/register_login/register_login_contract.dart';
import 'package:frontend_flutter/features/register_login/register_login_presenter.dart';

class RegisterLogin extends StatefulWidget {
  const RegisterLogin({super.key});

  @override
  State<RegisterLogin> createState() => _RegisterLoginState();
}

class _RegisterLoginState extends State<RegisterLogin>
    implements RegisterLoginContract {
  // ignore: unused_field
  late RegisterLoginPresenter _presenter;
  _RegisterLoginState() {
    _presenter = new RegisterLoginPresenter(this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
              width: 280,
              height: 120,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/img/home/logo.png"),
                      fit: BoxFit.fill)),
            ),
            Container(
                margin: EdgeInsets.only(bottom: 140),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      child: Container(
                        width: 220,
                        height: 65,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/img/home/button.png"),
                              fit: BoxFit.fill),
                        ),
                        child: Text(
                          "Đăng Ký",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Container(
                        width: 220,
                        height: 65,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/img/home/button.png"),
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
                ))
          ],
        ),
      ),
    );
  }
}
