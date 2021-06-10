import 'package:flutter/material.dart';

class MyAlertDialog {
  MyAlertDialog({this.title, this.content, this.onCancel, this.onOkay});
  final String title, content;
  final Function onCancel, onOkay;
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
              // color: Colors.blue[100],
              onPressed: onCancel,
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
              // color: Colors.blue[100],
              onPressed: onOkay,
            ),
          ],
        );
      },
    );
  }
}

void myDisplayDialog(context, title, content) => showDialog(
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
            // color: Colors.orange[100],
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );

class ChooseFileDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.camera_alt_outlined,
                    size: 80,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.image_outlined,
                    size: 80,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }
}

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
          // backgroundColor: Colors.cyan,
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
            FlatButton(
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
