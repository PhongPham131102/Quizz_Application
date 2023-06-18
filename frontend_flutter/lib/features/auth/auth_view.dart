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

class _AuthViewState extends State<AuthView>
    with TickerProviderStateMixin
    implements AuthContract {
  late AnimationController _animationController;
  late AnimationController _animationRotateController;
  late Animation<double> _animation;
  late AuthPresenter _presenter;
  @override
  void dispose() {
    _animationController.dispose();
    _animationRotateController.dispose();
    super.dispose();
  }

  int isLoading = 0;
  _AuthViewState() {
    _presenter = AuthPresenter(this);
  }
  String textLoading = "Đang tải";
  @override
  void setLoadingBar(double begin, double end, String _textLoading) async {
    textLoading = _textLoading;
    setState(() {});
    await Future.delayed(Duration(seconds: 1), () {
      _animation = Tween<double>(
        begin: begin,
        end: end,
      ).animate(_animationController);
      _animationController.reset();
      _animationController.forward();

      setState(() {});
    }).then((value) {
      if (end == 1) {
        _presenter.checkToken();
      }
    });
  }

  @override
  void initState() {
    _animationRotateController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    _animation = Tween<double>(
      begin: 0,
      end: 0.1,
    ).animate(_animationController);

    _animationController.repeat();
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    _presenter.loadingImage(context, _animationController, _animation);
    super.didChangeDependencies();
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
          : (isLoading == 0
              ? Scaffold(
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
                                  image: AssetImage("assets/img/home/logo.gif"),
                                  fit: BoxFit.fill)),
                        ),
                        Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.1,
                                  height:
                                      MediaQuery.of(context).size.height / 20,
                                ),
                                Positioned(
                                  left: MediaQuery.of(context).size.width / 50,
                                  right: MediaQuery.of(context).size.width / 50,
                                  top: MediaQuery.of(context).size.height / 60,
                                  bottom:
                                      MediaQuery.of(context).size.height / 150,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    height:
                                        MediaQuery.of(context).size.height / 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Color(0xffB86403),
                                    ),
                                    child: AnimatedBuilder(
                                      animation: _animation,
                                      builder: (context, child) {
                                        return Stack(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.2 *
                                                  _animation.value,
                                              height: (MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  30),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        255, 25, 203, 9),
                                                    Color.fromARGB(
                                                        255, 146, 223, 23),
                                                    Color.fromARGB(
                                                        255, 2, 251, 26),
                                                  ],
                                                  stops: [0.0, 0.5, 1.0],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                AnimatedBuilder(
                                    animation: _animation,
                                    builder: (context, child) {
                                      return Positioned(
                                          top: 0,
                                          bottom: 0,
                                          right: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.2 -
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1.2 *
                                                  _animation.value,
                                          child: RotationTransition(
                                            turns: Tween(
                                                    begin: -0.025, end: 0.025)
                                                .animate(
                                                    _animationRotateController),
                                            child: Image.asset(
                                              "assets/img/home/avtloading.png",
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  10,
                                              fit: BoxFit.fill,
                                            ),
                                          ));
                                    })
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 10,
                                  left: 30,
                                  right: 30,
                                  bottom:
                                      MediaQuery.of(context).size.height / 35),
                              child: Row(
                                children: [
                                  Text('$textLoading',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Color(0xffFEDB10),
                                          fontSize: 15,
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w800)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              : RegisterLogin()),
    );
  }
}

// class GlowingLoadingBar extends StatefulWidget {
//   @override
//   _GlowingLoadingBarState createState() => _GlowingLoadingBarState();
// }

// class _GlowingLoadingBarState extends State<GlowingLoadingBar>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;
//   late Animation<double> _animation;

//   int loadingImage = 0;
//   double progress = 0.0;

//   @override
//   void initState() {
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 5),
//     );

//     _animation = Tween<double>(
//       begin: _calculateProgress(loadingImage),
//       end: _calculateProgress(loadingImage + 1),
//     ).animate(_animationController);

//     _animationController.repeat();

//     _startLoadingAnimation();

//     super.initState();
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _startLoadingAnimation() {
//     if (loadingImage < 5) {
//       Future.delayed(Duration(seconds: 1), () {
//         setState(() {
//           loadingImage++;
//           _animation = Tween<double>(
//             begin: _calculateProgress(loadingImage),
//             end: _calculateProgress(loadingImage + 1),
//           ).animate(_animationController);
//           _animationController.reset();
//           _animationController.forward();
//           _startLoadingAnimation();
//         });
//       });
//     }
//   }

//   double _calculateProgress(int loadingImage) {
//     return loadingImage * 0.2;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 200,
//       height: 20,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(10),
//         color: Colors.grey[300],
//       ),
//       child: AnimatedBuilder(
//         animation: _animation,
//         builder: (context, child) {
//           return Stack(
//             children: [
//               Container(
//                 height: 20,
//                 width: 200 * _animation.value,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   gradient: LinearGradient(
//                     colors: [
//                       Color.fromARGB(255, 25, 203, 9),
//                       Color.fromARGB(255, 146, 223, 23),
//                       Color.fromARGB(255, 2, 251, 26),
//                     ],
//                     stops: [0.0, 0.5, 1.0],
//                     begin: Alignment.centerLeft,
//                     end: Alignment.centerRight,
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
