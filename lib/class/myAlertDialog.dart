import 'package:flutter/material.dart';

class MyAlertDialog {
  MyAlertDialog({
    this.title,
    this.content,
    this.onCancel,
    this.onOkay,
    this.cancelColor,
    this.okColor,
  });
  final String title, content;
  final Function onCancel, onOkay;
  final Color cancelColor, okColor;
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
            TextButton(
              child: Text(
                'ຍົກເລີກ',
                style: TextStyle(
                  fontFamily: 'NotoSans',
                  fontSize: 18,
                  color: cancelColor,
                ),
              ),
              onPressed: onCancel,
            ),
            TextButton(
              child: Text(
                'ຕົກລົງ',
                style: TextStyle(
                  fontFamily: 'NotoSans',
                  fontSize: 18,
                  color: okColor,
                ),
              ),
              onPressed: onOkay,
            ),
          ],
        );
      },
    );
  }
}

void myDisplayDialog(context, title, titleColor, content) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'NotoSans',
            fontSize: 22,
            color: Colors.red,
          ),
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
          TextButton(
            child: Text(
              'ຕົກລົງ',
              style: TextStyle(
                fontFamily: 'NotoSans',
                fontSize: 18,
                color: titleColor,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );

// class ChooseFileDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             content: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   icon: Icon(
//                     Icons.camera_alt_outlined,
//                     size: 80,
//                     color: Colors.blue,
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//                 IconButton(
//                   icon: Icon(
//                     Icons.image_outlined,
//                     size: 80,
//                     color: Colors.blue,
//                   ),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }

class ChooseImageDialog {
  Function onCameraPressed;
  Function onGalleryPressed;
  ChooseImageDialog({
    this.onCameraPressed,
    this.onGalleryPressed,
  });
  void chooseFileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '',
            textAlign: TextAlign.center,
          ),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Icon(
                  Icons.photo_camera,
                  size: 80,
                  color: Colors.blue,
                ),
                onTap: onCameraPressed,
              ),
              InkWell(
                child: Icon(
                  Icons.photo,
                  size: 80,
                  color: Colors.blue,
                ),
                onTap: onGalleryPressed,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'ຍົກເລີກ',
                style: TextStyle(color: Colors.red),
              ),
            )
          ],
        );
      },
    );
  }
}
