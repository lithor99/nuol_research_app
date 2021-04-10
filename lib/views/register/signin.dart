import 'package:flutter/material.dart';
import 'package:noul_research/class/myTextField.dart';
import 'package:noul_research/class/myLogo.dart';
import 'package:noul_research/class/myButton.dart';
import 'package:noul_research/views/home.dart';
import 'package:noul_research/views/management/resetPassword.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Future<Null> setPreferances() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString('email', 'lee');
  //   // MaterialPageRoute route = MaterialPageRoute(builder: (context) => myRoute);
  //   // Navigator.pushAndRemoveUntil(context, route, (route) => false);
  // }

  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  bool isLoading = true;
  bool blPassword = true;

  Future<Null> signIn(String email, String password) async {
    final url = 'http://192.168.43.191:3000/member/login';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map body = {'email': email, 'password': password};
    var jsonResponse;
    var res = await http.post(Uri.parse(url), body: body);
    try {
      if (res.statusCode == 200) {
        jsonResponse = json.decode(res.body);
        print('response status: ${res.statusCode}');
        print('response status: ${res.body}');
        if (jsonResponse != null) {
          setState(() {
            isLoading = false;
          });
          preferences.setString('token', jsonResponse['token']);
          MaterialPageRoute route = MaterialPageRoute(
            builder: (value) => Home(),
          );
          Navigator.push(context, route);
        }
      }
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(0),
        child: ListView(
          children: [
            MyLogo(
              height: MediaQuery.of(context).size.height / 3,
              imgUrl: 'images/NUOL.png',
              leftRadius: 80,
              rightRadius: 80,
              color: Colors.cyan[500],
            ),
            SizedBox(height: 30),
            MyEmailText(
              title: 'ອີເມລ',
              controller: txtEmail,
              iconColor: Colors.grey[500],
            ),
            SizedBox(height: 8),
            MyPasswordText(
              title: 'ລະຫັດຜ່ານ',
              controller: txtPassword,
              obscureText: blPassword,
              iconColor: Colors.grey[500],
              onChanged: () {},
              onTapped: () {
                setState(() {
                  blPassword = !blPassword;
                });
              },
            ),
            SizedBox(height: 30),
            MyButton(
                title: 'ເຂົ້າສູ່ລະບົບ',
                fontSize: 30,
                fontWeight: FontWeight.bold,
                titleColor: Colors.white,
                buttonColor: Colors.blue,
                height: 65,
                width: (MediaQuery.of(context).size.width) - 12,
                onPressed: txtEmail.text == '' || txtPassword.text == ''
                    ? null
                    : () {
                        MaterialPageRoute route = MaterialPageRoute(
                          builder: (value) => Home(),
                        );
                        Navigator.push(context, route);
                      }
                // : () {
                //     setState(() {
                //       isLoading = true;
                //     });
                //     signIn(txtEmail.text, txtPassword.text);
                //   },
                ),
            SizedBox(height: 15),
            Center(
              child: InkWell(
                child: Text(
                  'ລືມລະຫັດຜ່ານ',
                  style: TextStyle(
                    fontFamily: 'NotoSans',
                    fontSize: 16,
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () async {
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (value) => ResetPassword(),
                  );
                  Navigator.push(context, route);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
