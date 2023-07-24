import 'package:flutter/material.dart';
import 'package:frontend_flutter/features/register_login/register_login_contract.dart';
import 'package:frontend_flutter/features/register_login/register_login_presenter.dart';

import '../../components/Button.dart';

class RegisterLogin extends StatefulWidget {
  const RegisterLogin({super.key});

  @override
  State<RegisterLogin> createState() => _RegisterLoginState();
}

class _RegisterLoginState extends State<RegisterLogin>
    with TickerProviderStateMixin
    implements RegisterLoginContract {
  // ignore: unused_field
  late RegisterLoginPresenter _presenter;
  _RegisterLoginState() {
    _presenter = new RegisterLoginPresenter(this);
  }
  late AnimationController _RegisterButtonController;
  late Animation<double> _RegisterButtonAnimation;
  late Animation<double> _RegisterOpacityAnimation;
  late AnimationController _LoginButtonController;
  late Animation<double> _LoginButtonAnimation;
  late AnimationController _LogoController;
  late Animation<double> _LogoAnimation;
  @override
  void initState() {
    CreateAnimationController();
    super.initState();
    _LoginButtonController.forward();
  }

  CreateAnimationController() {
    _RegisterButtonController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );
    _RegisterOpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _RegisterButtonController,
        curve: Curves.bounceOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {}
      });
    _RegisterButtonAnimation = Tween(begin: 250.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _RegisterButtonController,
        curve: Curves.bounceOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _LogoController.forward();
        }
      });
    _LoginButtonController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _LoginButtonAnimation = Tween(begin: 300.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _LoginButtonController,
        curve: Curves.bounceOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _RegisterButtonController.forward();
        }
      });
    _LogoController = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _LogoAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _LogoController,
        curve: Curves.easeInOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {}
      });
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
            AnimatedBuilder(
                animation: _LogoController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _LogoAnimation.value,
                    child: Container(
                      margin: EdgeInsets.only(top: 80),
                      width: 280,
                      height: 120,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/img/home/logo.gif"),
                              fit: BoxFit.fill)),
                    ),
                  );
                }),
            Container(
              margin: EdgeInsets.only(bottom: 140),
              child: Column(
                children: [
                  AnimatedBuilder(
                      animation: _RegisterButtonController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _RegisterButtonAnimation.value),
                          child: Opacity(
                            opacity: _RegisterOpacityAnimation.value,
                            child: ButtonCustom(
                              onTap: () {
                                Navigator.pushReplacementNamed(
                                    context, '/Register');
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) => Register()));
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
                                  "Đăng Ký",
                                  style: TextStyle(
                                    fontFamily: 'Mitr',
                                    fontSize: 20,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                  AnimatedBuilder(
                      animation: _LoginButtonController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _LoginButtonAnimation.value),
                          child: ButtonCustom(
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/Login');
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => Login()));
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
                                  fontFamily: 'Mitr',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
