import 'package:flutter/material.dart';
import 'package:frontend_flutter/sound_manager.dart';

// ignore: must_be_immutable
class ButtonCustom extends StatefulWidget {
  VoidCallback onTap;
  Widget child;
  final bool isButton;
  ButtonCustom(
      {super.key,
      required this.onTap,
      required this.child,
      this.isButton = true});

  @override
  State<ButtonCustom> createState() => _ButtonCustomState();
}

class _ButtonCustomState extends State<ButtonCustom>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isButtonPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.bounceOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    _isButtonPressed = true;
    _animationController.forward();
  }

  void _handleTapCancel() {
    _isButtonPressed = false;
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTap: () {
        if (_isButtonPressed) {
          _isButtonPressed = false;
          if (this.widget.isButton) {
            GlobalSoundManager().playButton("button");
          }
          _animationController.reverse().then((value) {
            this.widget.onTap();
          });
        }
      },
      onTapCancel: _handleTapCancel,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
