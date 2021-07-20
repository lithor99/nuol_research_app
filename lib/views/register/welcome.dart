import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:nuol_research/views/register/signin.dart';
import 'package:nuol_research/views/register/signup.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int index = 0;
  final List<Widget> selectPage = [
    SignIn(),
    SignUp(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(0),
        child: selectPage[index],
      ),
      bottomNavigationBar: ConvexAppBar(
        items: [
          TabItem(icon: Icons.exit_to_app_rounded, title: 'ເຂົ້າສູ່ລະບົບ'),
          TabItem(icon: Icons.person_add, title: 'ລົງທະບຽນ'),
        ],
        initialActiveIndex: index,
        onTap: (int value) {
          setState(() {
            index = value;
          });
        },
        color: Colors.blue[800],
        backgroundColor: Colors.cyan[100],
        activeColor: Colors.blue[800],
        height: 50,
      ),
    );
  }
}
