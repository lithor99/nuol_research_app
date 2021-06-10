import 'package:fluttertoast/fluttertoast.dart';

Future<void> myToast(String message) async {
  Fluttertoast.showToast(
    msg: message,
    fontSize: 16,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
  );
}
