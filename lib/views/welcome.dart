import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  // Future<Null> signOut() async {
  //   // SharedPreferences preferences = await SharedPreferences.getInstance();
  //   // preferences.clear();
  //   exit(0);
  // }
  bool isSearch = true;
  final txtSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          children: [
            Container(
              child: Image.asset('images/nuol1.jpg'),
              // decoration: BoxDecoration(
              //   color: Colors.cyan[500],
              //   image: DecorationImage(
              //     image: AssetImage('images/nuol1.jpg'),
              //   ),
              //   borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(100),
              //   ),
              // ),
              // height: MediaQuery.of(context).size.height / 2,
              // width: MediaQuery.of(context).size.width,
              // // child: Padding(
              // //   padding: EdgeInsets.all(20),
              // // ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 5, right: 5, top: 10),
              child: Text(
                'ຍິນດີຕ້ອນຮັບທຸກທ່ານເຂົ້າສູ່ແອັບພລີເຄຊັນອ່ານບົດຄົ້ນຄວ້າວິທະຍາສາຂອງມະຫາວິທະຍາໄລແຫ່ງຊາດ',
                style: TextStyle(fontFamily: 'NotoSans', fontSize: 20),
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ),
    );
  }
}
