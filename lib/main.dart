import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:nuol_research/views/home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nuol_research/views/register/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();
SharedPreferences preferences;
var email;
final String serverName = 'http://192.168.43.191:9000';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FlutterDownloader.initialize(debug: true);
  preferences = await SharedPreferences.getInstance();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  Future<String> get checkLogin async {
    email = await storage.read(key: "email");
    print('main email:' + email.toString());
    if (email == null) return null;
    return email;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NUOLResearch',
      home: FutureBuilder(
          future: checkLogin,
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              // var data = snapshot.data;
              // print('main data:' + data.toString());
              // var jwt = data.split(".");
              // if (jwt.length != 3) {
              //   return Welcome();
              // } else {
              //   var payload = json.decode(
              //     ascii.decode(base64.decode(base64.normalize(jwt[1]))),
              //   );
              //   print('main payload:::' + payload.toString());
              //   if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
              //       .isAfter(DateTime.now())) {
              //     return Home(payload['data']['email'].toString());
              //   } else {
              //     return Welcome();
              //   }
              // }
              // if (data) {
              //   return Home(data.toString());
              // } else {
              //   return Welcome();
              // }
              return Welcome();
            } else {
              print('main data:' + snapshot.data.toString());
              return Home(snapshot.data.toString());
            }
          }),
    );
  }
}
