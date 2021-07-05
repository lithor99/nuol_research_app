import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nuol_research/class/myConnectivity.dart';
import 'package:nuol_research/class/myTextField.dart';
import 'package:nuol_research/class/myLogo.dart';
import 'package:nuol_research/class/myButton.dart';
import 'package:nuol_research/class/myToast.dart';
import 'package:nuol_research/main.dart';
import 'package:nuol_research/views/home.dart';
import 'package:nuol_research/views/register/forgotPassword.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  FocusNode focusNode;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String emailTitle = 'ອີເມລ';
  String passwordTitle = 'ລະຫັດຜ່ານ';
  Color emailTitleColor = Colors.grey;
  Color passwordTitleColor = Colors.grey;
  Color emailTextColor = Colors.black;
  Color passwordTextColor = Colors.black;
  bool hidePassword = true;

  Future<void> signIn(String email, password) async {
    try {
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        final url = serverName + '/member/login';
        Map body = {'email': email, 'password': password};
        var res = await http.post(Uri.parse(url), body: body);

        var data = await json.decode(res.body);
        if (data != null) {
          if (data.toString() == '{message: email not found}') {
            setState(() {
              emailController.text = 'ບໍ່ພົບອີເມລດັ່ງກ່າວ';
              emailTextColor = Colors.red;
            });
          } else if (data.toString() == '{message: password failed}') {
            setState(() {
              passwordController.text = 'ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ';
              passwordTextColor = Colors.red;
            });
          } else if (data.toString() == '{message: this user has banned}') {
            setState(() {
              emailTextColor = Colors.red;
              passwordTextColor = Colors.red;
            });
            myToast(
              'ບັນຊີນີ້ຖືກຫ້າມບໍ່ໃຫ້ເຂົ້າໃຊ້ລະບົບ',
              Colors.red,
              Toast.LENGTH_SHORT,
            );
          } else {
            await storage.write(key: "jwt", value: data['email']);
            Navigator.of(context).pop();
            MaterialPageRoute route = MaterialPageRoute(
              builder: (value) => Home(data['email']),
            );
            Navigator.push(context, route);
          }
        }
      } else {
        myToast(
          'ກະລຸນາກວດເບີ່ງການເຊື່ອມຕໍ່ອິນເຕີເນັດກ່ອນ',
          Colors.black,
          Toast.LENGTH_SHORT,
        );
      }
    } catch (e) {
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
              beginColor: Colors.white,
              endColor: Colors.blue,
            ),
            SizedBox(height: 30),
            MyEmailText(
              title: emailTitle,
              titleColor: emailTitleColor,
              controller: emailController,
              textColor: emailTextColor,
              iconColor: Colors.grey[500],
              onChanged: (value) {
                if (emailTextColor == Colors.red ||
                    emailTitleColor == Colors.red) {
                  setState(() {
                    emailController.clear();
                    emailTextColor = Colors.black;
                    emailTitle = 'ອີເມລ';
                    emailTitleColor = Colors.grey;
                  });
                }
              },
            ),
            SizedBox(height: 8),
            MyPasswordText(
              title: passwordTitle,
              titleColor: passwordTitleColor,
              controller: passwordController,
              textColor: passwordTextColor,
              obscureText: hidePassword,
              iconColor: Colors.grey[500],
              onChanged: (value) {
                if (passwordTextColor == Colors.red ||
                    passwordTitleColor == Colors.red) {
                  setState(() {
                    passwordController.clear();
                    passwordTextColor = Colors.black;
                    passwordTitle = 'ລະຫັດຜ່ານ';
                    passwordTitleColor = Colors.grey;
                  });
                }
              },
              onTapped: () {
                setState(() {
                  hidePassword = !hidePassword;
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
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (emailController.text == null ||
                    emailController.text.isEmpty) {
                  setState(() {
                    emailTitle = 'ກະລຸນາປ້ອນອີເມລກ່ອນ';
                    emailTitleColor = Colors.red;
                  });
                } else if (passwordController.text == null ||
                    passwordController.text.isEmpty) {
                  setState(() {
                    passwordTitle = 'ກະລຸນາປ້ອນລະຫັດກ່ອນ';
                    passwordTitleColor = Colors.red;
                  });
                } else {
                  signIn(emailController.text, passwordController.text);
                }
              },
            ),
            SizedBox(height: 15),
            Center(
              child: InkWell(
                child: Text(
                  'ລືມລະຫັດຜ່ານ',
                  style: TextStyle(
                    fontFamily: 'NotoSans',
                    fontSize: 18,
                    color: Colors.red,
                    decoration: TextDecoration.underline,
                  ),
                ),
                onTap: () async {
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (value) => ForgotPassword(),
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
