// ignore_for_file: no_leading_underscores_for_local_identifiers, unused_field
import 'package:flutter/material.dart';
import '../home/home_view.dart';
import '../login/login_view.dart';
import 'auth_contract.dart';
import 'auth_presenter.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView>
    implements AuthContract {
  late AuthPresenter _presenter;
  @override
  void dispose() {
    super.dispose();
  }

  int isLoading = 0;
  _AuthViewState() {
    _presenter = AuthPresenter(this);
  }

  @override
  void initState() { _presenter.checkToken();
    super.initState();
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
      debugShowCheckedModeBanner: false, //  xoá chữ "Debug"
      home: isLoading == 1
          ? HomeView()
          : (isLoading == 0
              ? Scaffold(
                  body: Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: CircularProgressIndicator(),
                    )
                  ),
                )
              : LoginView()),
    );
  }
}