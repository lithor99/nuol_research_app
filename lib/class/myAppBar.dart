import 'package:flutter/material.dart';

class MyAppBar {
  MyAppBar({
    this.title,
    this.controller,
    this.fontSize,
    this.isSearch,
    this.onSearchPress,
    this.onCancelPress,
    this.onBackPress,
    this.onActionPress,
  });
  final String title;
  final TextEditingController controller;
  final double fontSize;
  final bool isSearch;
  final Function onSearchPress, onCancelPress, onBackPress, onActionPress;
  AppBar myAppBar() {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontFamily: 'NotoSans', fontSize: fontSize),
      ),
      centerTitle: true,
    );
  }

  AppBar myAppBarSearch(BuildContext context) {
    return AppBar(
      title: isSearch
          ? TextField(
              controller: controller,
              cursorColor: Colors.black,
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'NotoSans',
                fontSize: 20,
              ),
              autofocus: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintStyle: TextStyle(color: Colors.white),
                hintText: 'ຄົ້ນຫາຂໍ້ມູນ...',
                border: InputBorder.none,
              ),
            )
          : Text(
              title,
              style: TextStyle(fontFamily: 'NotoSans', fontSize: fontSize),
            ),
      centerTitle: true,
      actions: [
        isSearch
            ? IconButton(
                icon: Icon(Icons.cancel),
                onPressed: onCancelPress,
              )
            : IconButton(
                icon: Icon(Icons.search),
                onPressed: onSearchPress,
              )
      ],
      leading: isSearch
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: onBackPress,
            )
          : null,
    );
  }
}
