import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<void> myToast(String message, Color toastColor, final showLength) async {
  Fluttertoast.showToast(
    msg: message,
    fontSize: 16,
    textColor: Colors.white,
    toastLength: showLength,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: toastColor,
  );
}
