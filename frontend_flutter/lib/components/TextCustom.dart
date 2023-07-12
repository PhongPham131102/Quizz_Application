import 'package:flutter/material.dart';

class CustomText extends StatefulWidget {
  final String text;
  final TextStyle style;
  final double strokeWidth;
  final Color color;
  final int? maxLines;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  const CustomText(this.text,
      {required this.style,
      this.strokeWidth = 1.5,
      this.color = Colors.black,
      this.maxLines,
      this.overflow,this.textAlign});

  @override
  State<CustomText> createState() => _CustomTextState();
}

class _CustomTextState extends State<CustomText> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text(
          this.widget.text,
          maxLines: this.widget.maxLines,
          overflow: this.widget.overflow,
          textAlign: this.widget.textAlign,
          style: this.widget.style.copyWith(
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = this.widget.strokeWidth
                  ..color = this.widget.color,
              ),
        ),
        Text(
          this.widget.text,
          maxLines: this.widget.maxLines,
          overflow: this.widget.overflow,textAlign: this.widget.textAlign,
          style: this.widget.style,
        ),
      ],
    );
  }
}
