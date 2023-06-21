import 'package:flutter/material.dart';
import 'dart:math';

class FlowerFreeMove extends StatefulWidget {
  final double maxWidth;
  final double maxHeight;

  FlowerFreeMove({super.key, required this.maxWidth, required this.maxHeight});

  @override
  State<FlowerFreeMove> createState() => _FlowerFreeMoveState();
}

class _FlowerFreeMoveState extends State<FlowerFreeMove>
    with SingleTickerProviderStateMixin {
  late double x;
  late double y;
  double containerSize = 20;
  double speedX = 1;
  double speedY = 1;
  double initialX = 0.0;
  double initialY = 0.0;
  late AnimationController _rotationController;
  late Animation<double> _rotationAnimation;
  late String flowerImage;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();

    initializePosition();
    initializeFlowerImage();

    startMoving();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  void initializePosition() {
    Random random = Random();
    x = random.nextDouble() * (widget.maxWidth - containerSize);
    y = random.nextDouble() * (widget.maxHeight - containerSize);
    containerSize = random.nextDouble() * (35 - 20) + 20;
    initialX = x;
    initialY = y;
  }

  void initializeFlowerImage() {
    Random random = Random();
    int randomNumber = random.nextInt(2);
    flowerImage = randomNumber == 0 ? "redflower.png" : "pinkflower.png";
  }

  void startMoving() {
    if (!mounted) {
      return;
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        x += speedX;
        y += speedY;

        if (x <= 0 || x + containerSize >= widget.maxWidth) {
          speedX *= -1;
        }
        if (y <= 0 || y + containerSize >= widget.maxHeight) {
          speedY *= -1;
        }
      });
      startMoving();
    });
  }

  @override
  Widget build(BuildContext context) {
    _rotationAnimation =
        Tween(begin: 0.0, end: 360.0).animate(_rotationController);

    return AnimatedPositioned(
      duration: Duration(milliseconds: 16),
      curve: Curves.linear,
      left: x,
      top: y,
      child: AnimatedBuilder(
        animation: _rotationAnimation,
        child: Container(
          width: containerSize,
          height: containerSize,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/img/battle/$flowerImage",
              ),
            ),
          ),
        ),
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotationAnimation.value * (pi / 180.0),
            child: child,
          );
        },
      ),
    );
  }
}
