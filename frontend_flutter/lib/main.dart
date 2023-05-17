import 'package:flutter/material.dart';
import 'package:frontend_flutter/services/AuthService.dart' as Auth;
import 'package:frontend_flutter/views/HomeScreen.dart';
import 'package:frontend_flutter/views/LoadingScreen.dart';
import 'package:frontend_flutter/views/RegisterLoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int isLoading = 0;
  checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token') ?? '';
    uid = prefs.getString('uid') ?? '';
    if (token!.isNotEmpty) {
      bool checkToken = await Auth.checkToken(token!);
      if (checkToken) {
        setState(() {
          isLoading = 1;
        });
      } else {
        resetTokenAndUid();
      }
    } else {
      resetTokenAndUid();
    }
  }

  resetTokenAndUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', '');
    prefs.setString('uid', '');
    setState(() {
      isLoading = 2;
    });
  }

  @override
  void initState() {
    checkToken();
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
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
          ? HomeScreen()
          : (isLoading == 0 ? const LoadingScreen() : RegisterLoginScreen()),
    );
  }
}
