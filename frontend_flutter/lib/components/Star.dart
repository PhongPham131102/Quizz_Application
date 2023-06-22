import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Stars extends StatefulWidget {
  int star;
  double height;
  Stars(
      {super.key,
      required this.height,
      required this.star});

  @override
  State<Stars> createState() => _StarsState();
}

class _StarsState extends State<Stars> with TickerProviderStateMixin {
  late AnimationController Star1Controller;
  late Animation<double> Star1ScaleAnimation;
  late Animation<double> Star1OpacityAnimation;
  late AnimationController Star2Controller;
  late Animation<double> Star2ScaleAnimation;
  late Animation<double> Star2OpacityAnimation;
  late AnimationController Star3Controller;
  late Animation<double> Star3ScaleAnimation;
  late Animation<double> Star3OpacityAnimation;
  CreateAnimationController() {
    Star1Controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    Star1ScaleAnimation = Tween(begin: 5.0, end: 1.0).animate(
      CurvedAnimation(
        parent: Star1Controller,
        curve: Curves.bounceOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          ///
        }
      });
    Star1OpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: Star1Controller,
        curve: Curves.bounceOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Star2Controller.forward();
        }
      });
    Star2Controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    Star2ScaleAnimation = Tween(begin: 5.0, end: 1.0).animate(
      CurvedAnimation(
        parent: Star2Controller,
        curve: Curves.bounceOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          ///
        }
      });
    Star2OpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: Star2Controller,
        curve: Curves.bounceOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Star3Controller.forward();
        }
      });
    Star3Controller = AnimationController(
      duration: Duration(milliseconds: 1000),
      vsync: this,
    );
    Star3ScaleAnimation = Tween(begin: 5.0, end: 1.0).animate(
      CurvedAnimation(
        parent: Star3Controller,
        curve: Curves.bounceOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          ///
        }
      });
    Star3OpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: Star3Controller,
        curve: Curves.bounceOut,
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          ///
        }
      });
  }

  @override
  void initState() {
    CreateAnimationController();
    Star1Controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: this.widget.height,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AnimatedBuilder(
                animation: Star1Controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: Star1ScaleAnimation.value,
                    child: Opacity(
                      opacity: Star1OpacityAnimation.value,
                      child: Image.asset(
                        this.widget.star > 0
                            ? "assets/img/battletraining/starwin.gif"
                            : "assets/img/battletraining/starlose.gif",
                        width: this.widget.height/2.3,
                        height: this.widget.height/2.3,
                      ),
                    ),
                  );
                }),
            //star2
            AnimatedBuilder(
                animation: Star2Controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: Star2ScaleAnimation.value,
                    child: Opacity(
                      opacity: Star2OpacityAnimation.value,
                      child: Image.asset(
                        this.widget.star > 1
                            ? "assets/img/battletraining/starwin.gif"
                            : "assets/img/battletraining/starlose.gif",
                        width: this.widget.height/1.1,
                        height: this.widget.height/1.1,
                      ),
                    ),
                  );
                }),
            //star3
            AnimatedBuilder(
                animation: Star3Controller,
                builder: (context, child) {
                  return Transform.scale(
                    scale: Star3ScaleAnimation.value,
                    child: Opacity(
                      opacity: Star3OpacityAnimation.value,
                      child: Image.asset(
                        this.widget.star > 2
                            ? "assets/img/battletraining/starwin.gif"
                            : "assets/img/battletraining/starlose.gif",
                        width: this.widget.height/2.3,
                        height: this.widget.height/2.3,
                      ),
                    ),
                  );
                }),
          ],
        ),
    );
  }
}
