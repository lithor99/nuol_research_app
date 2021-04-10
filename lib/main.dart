import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:noul_research/views/home.dart';
import 'package:noul_research/views/welcome.dart';
import 'package:noul_research/views/register/signin.dart';
import 'package:noul_research/views/register/signup.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;
  final List<Widget> selectPage = [
    // Welcome(),
    SignIn(),
    SignUp(),
  ];
  // String email;
  @override
  void initState() {
    super.initState();
    Home();
  }

  // Future<Null> homePage() async {
  //   try {
  //     SharedPreferences preferences = await SharedPreferences.getInstance();
  //     String email = preferences.getString('email');
  //     if (email != '' && email.isNotEmpty) {
  //       MaterialPageRoute route = MaterialPageRoute(
  //         builder: (value) => Home(),
  //       );
  //       Navigator.push(context, route);
  //     }
  //   } catch (e) {}
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'nuolResearch',
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(5),
          // child: widgetPage.elementAt(_index),
          child: selectPage[index],
        ),
        bottomNavigationBar: ConvexAppBar(
          items: [
            // TabItem(icon: Icons.pan_tool_rounded, title: 'ແນະນຳ'),
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
          backgroundColor: Colors.cyan[200],
          activeColor: Colors.blue[800],
          height: 50,
        ),
      ),
    );
  }
}
