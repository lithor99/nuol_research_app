import 'package:flutter/material.dart';
import 'package:noul_research/class/myTextField.dart';
import 'package:noul_research/class/myButton.dart';
import 'package:noul_research/class/myAppBar.dart';
import 'package:noul_research/views/home.dart';

class SignInWithNewPass extends StatefulWidget {
  @override
  _SignInWithNewPassState createState() => _SignInWithNewPassState();
}

class _SignInWithNewPassState extends State<SignInWithNewPass> {
  final txtPassword = TextEditingController();
  bool blPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(title: 'ລືມລະຫັດຜ່ານ', fontSize: 20).myAppBar(),
      body: Center(
        child: ListView(
          children: [
            SizedBox(height: 20),
            MyPasswordText(
              title: 'ປ້ອນລະຫັດຜ່ານທີ່ທ່ານໄດ້ຮັບ',
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
              onPressed: () async {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => Home(),
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
