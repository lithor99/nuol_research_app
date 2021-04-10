import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  MyListTile({this.title, this.icon, this.iconColor, this.onTap});
  final String title;
  final IconData icon;
  final Color iconColor;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(
        title,
        style: TextStyle(fontFamily: 'NotoSans', fontSize: 18),
      ),
      onTap: onTap,
    );
  }
}
