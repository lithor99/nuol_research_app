import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:localstorage/localstorage.dart';
import 'package:nuol_research/views/home.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:nuol_research/views/register/welcome.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterSecureStorage storage = FlutterSecureStorage();
SharedPreferences preferences;
var jwt;

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
    jwt = await storage.read(key: "jwt");
    if (jwt == null) return "";
    return jwt;
  }

  // checkLogin() async {
  //   preferences = await SharedPreferences.getInstance();
  //   if (preferences.getString('token') == null) {
  //     MaterialPageRoute route = MaterialPageRoute(
  //       builder: (value) => MyApp(),
  //     );
  //     Navigator.push(context, route);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'nuolResearch',
      home: FutureBuilder(
          future: checkLogin,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return CircularProgressIndicator();
            }
            if (snapshot.data != "") {
              var data = snapshot.data;
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
              return Home(data.toString());
            } else {
              return Welcome();
            }
          }),
    );
  }
}
