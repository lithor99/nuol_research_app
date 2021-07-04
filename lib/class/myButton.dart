import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({
    this.title,
    this.fontSize,
    this.fontWeight,
    this.titleColor,
    this.buttonColor,
    this.height,
    this.width,
    this.onPressed,
  });
  final String title;
  final double fontSize;
  final fontWeight;
  final Color titleColor, buttonColor;
  final double height, width;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      onPrimary: buttonColor,
      primary: buttonColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    );
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: raisedButtonStyle,
        child: Text(
          title,
          style: TextStyle(
            fontFamily: 'NotoSans',
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: titleColor,
          ),
        ),
      ),
      // child: RaisedButton(
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      //   color: buttonColor,
      //   onPressed: onPressed,
      // child: Text(
      //   title,
      //   style: TextStyle(
      //     fontFamily: 'NotoSans',
      //     fontSize: fontSize,
      //     fontWeight: fontWeight,
      //     color: titleColor,
      //   ),
      // ),
      // ),
    );
  }
}
