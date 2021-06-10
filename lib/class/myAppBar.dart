import 'package:flutter/material.dart';

class MyAppBar {
  MyAppBar({
    this.title,
    this.controller,
    this.fontSize,
    this.isSearch,
    this.onSearchState,
    this.onClear,
    this.onCancel,
    this.onSubmitted,
    this.onSearchData,
  });
  final String title;
  final TextEditingController controller;
  final double fontSize;
  final bool isSearch;
  final Function onSearchState, onClear, onCancel, onSubmitted, onSearchData;
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
                hintStyle: TextStyle(color: Colors.white70, fontSize: 14),
                hintText: 'ຄົ້ນຫາຕາມຊື່ບົດ, ສາຍການຄົ້ນຄວ້າ ແລະ ປີພີມ',
                border: InputBorder.none,
              ),
              onSubmitted: onSubmitted,
            )
          : Text(
              title,
              style: TextStyle(fontFamily: 'NotoSans', fontSize: fontSize),
            ),
      centerTitle: true,
      actions: isSearch
          ? [
              IconButton(
                // icon: Icon(Icons.arrow_forward_rounded),
                icon: Icon(Icons.close, color: Colors.orange[800]),
                onPressed: onClear,
              ),
              IconButton(
                // icon: Icon(Icons.arrow_forward_rounded),
                icon: Icon(Icons.search),
                onPressed: onSearchData,
              )
            ]
          : [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: onSearchState,
              )
            ],
      leading: isSearch
          ? IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: onCancel,
            )
          : null,
    );
  }
}
