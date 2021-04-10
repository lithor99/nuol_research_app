import 'package:flutter/material.dart';
import 'package:noul_research/class/myTextField.dart';
import 'package:noul_research/class/myLogo.dart';
import 'package:noul_research/class/myButton.dart';
import 'package:noul_research/views/register/confirmSignin.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final txtEmail = TextEditingController();
  final txtUsername = TextEditingController();
  final txtPassword = TextEditingController();
  final txtConfirmPassword = TextEditingController();
  bool blPassword = true;
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
              color: Colors.cyan,
            ),
            SizedBox(height: 30),
            MyUsernameText(
              title: 'ຊື່ຜູ້ໃຊ້',
              controller: txtUsername,
              iconColor: Colors.grey[500],
            ),
            SizedBox(height: 8),
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
              title: 'ລົງທະບຽນ',
              fontSize: 30,
              fontWeight: FontWeight.bold,
              titleColor: Colors.white,
              buttonColor: Colors.blue,
              height: 65,
              width: (MediaQuery.of(context).size.width) - 12,
              onPressed: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => ConfirmSignin(),
                );
                Navigator.push(context, route);
              },
            ),
          ],
        ),
      ),
    );
  }
}
