import 'package:flutter/material.dart';

class MyUsernameText extends StatelessWidget {
  MyUsernameText({
    this.title,
    this.controller,
    this.iconColor,
  });
  final String title;
  final TextEditingController controller;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller: controller,
        style: TextStyle(fontFamily: 'NotoSans', fontSize: 20),
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
          labelStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}

class MyPasswordText extends StatefulWidget {
  MyPasswordText({
    this.title,
    this.controller,
    this.iconColor,
    this.obscureText,
    this.onChanged,
    this.onTapped,
  });

  final String title;
  final TextEditingController controller;
  final Color iconColor;
  final bool obscureText;
  final Function onChanged, onTapped;
  @override
  _MyPasswordTextState createState() => _MyPasswordTextState();
}

class _MyPasswordTextState extends State<MyPasswordText> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller: widget.controller,
        style: TextStyle(fontFamily: 'NotoSans', fontSize: 20),
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
          prefixIcon: Icon(
            Icons.vpn_key_rounded,
            color: widget.iconColor,
          ),
          suffixIcon: GestureDetector(
            onTap: widget.onTapped,
            child: Icon(
              widget.obscureText ? Icons.visibility_off : Icons.visibility,
              color: widget.obscureText ? Colors.blue : Colors.red,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          labelText: widget.title,
          labelStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                color: Colors.blue,
              )),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}

class MyEmailText extends StatelessWidget {
  MyEmailText({
    this.title,
    this.controller,
    this.iconColor,
  });
  final String title;
  final TextEditingController controller;
  final Color iconColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      child: TextField(
        controller: controller,
        style: TextStyle(fontFamily: 'NotoSans', fontSize: 20),
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
          labelStyle: TextStyle(color: Colors.grey),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
              color: Colors.blue,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  MyTextField({this.controller, this.width});
  TextEditingController controller;
  double width;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: TextField(
        controller: controller,
        style: TextStyle(fontFamily: 'NotoSans', fontSize: 18),
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
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
        textAlign: TextAlign.center,
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
        style: TextStyle(fontFamily: 'NotoSans', fontSize: 16),
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
