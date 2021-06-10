import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//----- ບໍ່ໃຫ້ປ້ອນຊ່ອງວ່າງ -----\\
//https://stackoverflow.com/questions/50123742/how-to-use-inputformatter-on-flutter-textfield

class MyUsernameText extends StatelessWidget {
  MyUsernameText({
    this.title,
    this.titleColor,
    this.controller,
    this.textColor,
    this.iconColor,
    this.onChanged,
  });
  final String title;
  final TextEditingController controller;
  final Color titleColor, textColor, iconColor;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller: controller,
        style: TextStyle(
          fontFamily: 'NotoSans',
          fontSize: 20,
          color: textColor,
        ),
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.account_circle,
            color: iconColor,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          filled: true,
          fillColor: Colors.white,
          labelText: title,
          labelStyle: TextStyle(color: titleColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class MyPasswordText extends StatelessWidget {
  MyPasswordText({
    this.title,
    this.titleColor,
    this.controller,
    this.textColor,
    this.iconColor,
    this.obscureText,
    this.onChanged,
    this.onTapped,
  });

  final String title;
  final TextEditingController controller;
  final Color titleColor, textColor, iconColor;
  final bool obscureText;
  final Function onChanged, onTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller: controller,
        // inputFormatters: [BlacklistingTextInputFormatter(RegExp(r'\s'))],
        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
        style: TextStyle(
          fontFamily: 'NotoSans',
          fontSize: 20,
          color: textColor,
        ),
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
          prefixIcon: Icon(
            Icons.vpn_key_rounded,
            color: iconColor,
          ),
          suffixIcon: GestureDetector(
            onTap: onTapped,
            child: Icon(
              obscureText ? Icons.visibility_off : Icons.visibility,
              color: obscureText ? Colors.blue : Colors.red,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          labelText: title,
          labelStyle: TextStyle(color: titleColor),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.grey,
              )),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

class MyEmailText extends StatelessWidget {
  MyEmailText({
    this.title,
    this.titleColor,
    this.controller,
    this.textColor,
    this.iconColor,
    this.onChanged,
  });

  final String title;
  final TextEditingController controller;
  final Color titleColor, textColor, iconColor;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller: controller,
        // inputFormatters: [BlacklistingTextInputFormatter(RegExp(r'\s'))],
        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
        style: TextStyle(
          fontFamily: 'NotoSans',
          fontSize: 20,
          color: textColor,
        ),
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.mail,
            color: iconColor,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          filled: true,
          fillColor: Colors.white,
          labelText: title,
          labelStyle: TextStyle(color: titleColor),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  MyTextField({
    this.controller,
    this.textColor,
    this.width,
    this.onChanged,
  });

  TextEditingController controller;
  Color textColor;
  double width;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextField(
        controller: controller,
        // inputFormatters: [BlacklistingTextInputFormatter(RegExp(r'\s'))],
        inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
        style: TextStyle(
          fontFamily: 'NotoSans',
          fontSize: 18,
        ),
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.green),
          ),
        ),
        textAlign: TextAlign.center,
        onChanged: onChanged,
      ),
    );
  }
}

class MyLabelText extends StatelessWidget {
  MyLabelText({this.title, this.width});
  final String title;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextField(
        enabled: false,
        style: TextStyle(
          fontFamily: 'NotoSans',
          fontSize: 16,
        ),
        textAlign: TextAlign.end,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          filled: true,
          fillColor: Colors.white,
          hintText: title,
          hintStyle: TextStyle(color: Colors.black),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}
