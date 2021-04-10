import 'package:flutter/material.dart';

class MyLogo extends StatelessWidget {
  MyLogo({
    this.imgUrl,
    this.height,
    this.leftRadius,
    this.rightRadius,
    this.color,
  });
  final String imgUrl;
  final double height, leftRadius, rightRadius;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: color,
        image: DecorationImage(
          image: AssetImage(imgUrl),
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(leftRadius),
          bottomRight: Radius.circular(rightRadius),
        ),
      ),
    );
  }
}
