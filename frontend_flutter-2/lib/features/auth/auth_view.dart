// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend_flutter/features/home/home_view.dart';

import '../register_login/register_login_view.dart';
import 'auth_contract.dart';
import 'auth_presenter.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> implements AuthContract {
  late AuthPresenter _presenter;
  int isLoading = 0;
  _AuthViewState() {
    _presenter = AuthPresenter(this);
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    _presenter.checkToken();
  }

  @override
  void setIsLoading(int _isLoading) {
    setState(() {
      isLoading = _isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // routes: {
      //   "/Home": (context) => HomeScreen(),
      //   '/SetName': (context) => SetNameCharacterScreen(),
      //   '/PickCharacter': (context) => PickCharacterScreen(),
      // },
      debugShowCheckedModeBanner: false, //  xoá chữ "Debug"
      home: isLoading == 1
          ? HomeView()
          : (isLoading == 0 ? const Loading() : RegisterLogin()),
    );
  }
}
class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
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
                      image: AssetImage("assets/img/home/logo.png"), fit: BoxFit.fill)),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Image.asset("assets/img/home/loading.png"))
          ],
        ),
      ),
    );
  }
}