import 'package:flutter/material.dart';

class MyLogo extends StatelessWidget {
  MyLogo({
    this.imgUrl,
    this.height,
    this.leftRadius,
    this.rightRadius,
    this.beginColor,
    this.endColor,
  });
  final String imgUrl;
  final double height, leftRadius, rightRadius;
  final Color beginColor, endColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imgUrl),
        ),
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [beginColor, endColor],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(leftRadius),
          bottomRight: Radius.circular(rightRadius),
        ),
      ),
    );
  }
}
