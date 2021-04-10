import 'package:flutter/material.dart';

class MyAlertDialog {
  MyAlertDialog(
      {this.title, this.content, this.onCancelPress, this.onOkayPress});
  final String title, content;
  final Function onCancelPress, onOkayPress;
  void showDialogBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            title,
            style: TextStyle(
              fontFamily: 'NotoSans',
              fontSize: 22,
              color: Colors.red,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            content,
            style: TextStyle(
              fontFamily: 'NotoSans',
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            FlatButton.icon(
              icon: Icon(
                Icons.cancel_outlined,
                color: Colors.red,
              ),
              label: Text(
                'ຍົກເລີກ',
                style: TextStyle(
                  fontFamily: 'NotoSans',
                  fontSize: 18,
                  color: Colors.blue[800],
                ),
              ),
              color: Colors.blue[100],
              onPressed: onCancelPress,
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.green,
              ),
              label: Text(
                'ຕົກລົງ',
                style: TextStyle(
                  fontFamily: 'NotoSans',
                  fontSize: 18,
                  color: Colors.blue[800],
                ),
              ),
              color: Colors.orange[100],
              onPressed: onOkayPress,
            ),
          ],
        );
      },
    );
  }
}

// class MyAlertDialog extends StatefulWidget {
//   MyAlertDialog(
//       {this.title, this.content, this.onCancelPress, this.onOkayPress});
//   final String title, content;
//   final Function onCancelPress, onOkayPress;
//   @override
//   _MyAlertDialogState createState() => _MyAlertDialogState();
// }

// class _MyAlertDialogState extends State<MyAlertDialog> {
//   void showDialogBox(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             widget.title,
//             style: TextStyle(fontFamily: 'NotoSans', fontSize: 22),
//           ),
//           content: Text(
//             widget.content,
//             style: TextStyle(fontFamily: 'NotoSans', fontSize: 18),
//           ),
//           actions: [
//             FlatButton.icon(
//               icon: Icon(
//                 Icons.cancel_outlined,
//                 color: Colors.red,
//               ),
//               label: Text(
//                 'ຍົກເລີກ',
//                 style: TextStyle(
//                   fontFamily: 'NotoSans',
//                   fontSize: 18,
//                   color: Colors.blue[800],
//                 ),
//               ),
//               color: Colors.blue[100],
//               onPressed: widget.onCancelPress,
//             ),
//             FlatButton.icon(
//               icon: Icon(
//                 Icons.check_circle_outline_rounded,
//                 color: Colors.green,
//               ),
//               label: Text(
//                 'ຕົກລົງ',
//                 style: TextStyle(
//                   fontFamily: 'NotoSans',
//                   fontSize: 18,
//                   color: Colors.blue[800],
//                 ),
//               ),
//               color: Colors.orange[100],
//               onPressed: widget.onOkayPress,
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

// class MyAlertDialog extends StatelessWidget {
//   void showDialogBox() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text(
//             'widget.title',
//             style: TextStyle(fontFamily: 'NotoSans', fontSize: 22),
//           ),
//           content: Text(
//             'widget.content',
//             style: TextStyle(fontFamily: 'NotoSans', fontSize: 18),
//           ),
//           actions: [
//             FlatButton.icon(
//               icon: Icon(
//                 Icons.cancel_outlined,
//                 color: Colors.red,
//               ),
//               label: Text(
//                 'ຍົກເລີກ',
//                 style: TextStyle(
//                   fontFamily: 'NotoSans',
//                   fontSize: 18,
//                   color: Colors.blue[800],
//                 ),
//               ),
//               color: Colors.blue[100],
//               onPressed: (){},
//             ),
//             FlatButton.icon(
//               icon: Icon(
//                 Icons.check_circle_outline_rounded,
//                 color: Colors.green,
//               ),
//               label: Text(
//                 'ຕົກລົງ',
//                 style: TextStyle(
//                   fontFamily: 'NotoSans',
//                   fontSize: 18,
//                   color: Colors.blue[800],
//                 ),
//               ),
//               color: Colors.orange[100],
//               onPressed: (){},
//             ),
//           ],
//         );
//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }
