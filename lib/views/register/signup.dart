import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nuol_research/class/myConnectivity.dart';
import 'package:nuol_research/class/myToast.dart';
import 'package:nuol_research/jsonDart/register.dart';
import 'package:nuol_research/class/myTextField.dart';
import 'package:nuol_research/class/myLogo.dart';
import 'package:nuol_research/class/myButton.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:nuol_research/views/register/confirmSignup.dart';

import '../../main.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Register register;
  FocusNode focusNode;
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String usernameTitle = 'ຊື່ຜູ້ໃຊ້';
  String emailTitle = 'ອີເມລ';
  String passwordTitle = 'ລະຫັດຜ່ານ';
  Color usernameTitleColor = Colors.grey;
  Color emailTitleColor = Colors.grey;
  Color passwordTitleColor = Colors.grey;
  Color usernameTextColor = Colors.black;
  Color emailTextColor = Colors.black;
  Color passwordTextColor = Colors.black;
  bool hidePassword = true;

  Future<void> signUp(String username, email, password) async {
    try {
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        final url = serverName + '/member/register';
        Map body = {
          'username': username,
          'email': email,
          'password': password,
        };
        var res = await http.post(
          Uri.parse(url),
          body: body,
        );
        var data = await json.decode(res.body);
        if (data != null) {
          if (data.toString() == '{message: this email already registered}') {
            setState(() {
              emailController.text = 'ອີເມລນີ້ຖືກລົງທະບຽນແລ້ວ';
              emailTextColor = Colors.red;
            });
          } else {
            register = registerFromJson(res.body);
            MaterialPageRoute route = MaterialPageRoute(
              builder: (value) => ConfirmSignup(
                register.registId,
                register.username,
                register.email,
                register.password,
              ),
            );
            Navigator.push(context, route);
            myToast(
              'ກະລຸນາລໍຖ້າລະບົບກຳລັງສົ່ງລະຫັດໄປຫາອີເມລ',
              Colors.black,
              Toast.LENGTH_LONG,
            );
          }
        } else {
          myToast(
            'ກວດສອບການເຊື່ອມຕໍ່ອິນເຕີເນັດກ່ອນ',
            Colors.black,
            Toast.LENGTH_SHORT,
          );
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.all(0),
        child: ListView(
          children: [
            MyLogo(
              height: MediaQuery.of(context).size.height / 3,
              imgUrl: 'images/NUOL.png',
              leftRadius: 80,
              rightRadius: 80,
              beginColor: Colors.white,
              endColor: Colors.green,
            ),
            SizedBox(height: 30),
            MyUsernameText(
              title: usernameTitle,
              titleColor: usernameTitleColor,
              controller: usernameController,
              textColor: usernameTextColor,
              iconColor: Colors.grey[500],
              onChanged: (value) {
                if (usernameTextColor == Colors.red ||
                    usernameTitleColor == Colors.red) {
                  usernameController.clear();
                  usernameTextColor = Colors.black;
                  usernameTitle = 'ຊື່ຜູ້ໃຊ້';
                  usernameTitleColor = Colors.grey;
                }
              },
            ),
            SizedBox(height: 8),
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
                  passwordController.clear();
                  passwordTextColor = Colors.black;
                  passwordTitle = 'ລະຫັດຜ່ານ';
                  passwordTitleColor = Colors.grey;
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
              title: 'ລົງທະບຽນ',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              titleColor: Colors.white,
              buttonColor: Colors.blue,
              height: 65,
              width: (MediaQuery.of(context).size.width) - 12,
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (usernameController.text == null ||
                    usernameController.text.isEmpty) {
                  setState(() {
                    usernameTitle = 'ກະລຸນາປ້ອນຊື່ຜູ້ໃຊ້ກ່ອນ';
                    usernameTitleColor = Colors.red;
                  });
                } else if (emailController.text == null ||
                    emailController.text.isEmpty) {
                  setState(() {
                    emailTitle = 'ກະລຸນາປ້ອນອີເມລກ່ອນ';
                    emailTitleColor = Colors.red;
                  });
                } else if (passwordController.text == null ||
                    passwordController.text.isEmpty) {
                  setState(() {
                    usernameTitle = 'ກະລຸນາປ້ອນລະຫັດກ່ອນ';
                    passwordTitleColor = Colors.red;
                  });
                } else if (passwordController.text.length < 5) {
                  setState(() {
                    hidePassword = false;
                    passwordController.text = 'ລະຫັດຜ່ານຕ້ອງຫຼາຍກວ່າ5ຕົວ';
                    passwordTextColor = Colors.red;
                  });
                } else {
                  signUp(
                    usernameController.text,
                    emailController.text,
                    passwordController.text,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
