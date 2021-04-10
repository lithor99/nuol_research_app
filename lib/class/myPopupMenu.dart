import 'package:flutter/material.dart';

class MyPopupMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      onSelected: null,
      itemBuilder: (BuildContext context) => [
        PopupMenuItem(
          child: Text('data'),
        ),
      ],
    );
  }
}
