import 'dart:io';
import 'package:flutter/material.dart';
import 'package:noul_research/views/books/bookAsBookmark.dart';
import 'package:noul_research/views/management/editUser.dart';
import 'package:noul_research/class/myCard.dart';
import 'package:noul_research/views/books/bookAsAll.dart';
import 'package:noul_research/views/books/bookAsView.dart';
import 'package:noul_research/views/books/bookAsLike.dart';
import 'package:noul_research/views/books/bookAsDownload.dart';
import 'package:noul_research/class/myListTile.dart';
import 'package:noul_research/views/setting/setting.dart';
import 'package:noul_research/class/myAlertDialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Future checkFirstSeen() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   bool _seen = (preferences.getBool('seen') ?? false);
  //   if (_seen) {
  //     Navigator.of(context)
  //         .pushReplacement(new MaterialPageRoute(builder: (context) => Home()));
  //   } else {
  //     preferences.setBool('seen', true);
  //     Navigator.of(context).pushReplacement(
  //         new MaterialPageRoute(builder: (context) => SignIn()));
  //   }
  // }

  Future<Null> signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
    exit(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ໜ້າຫຼັກ',
          style: TextStyle(fontFamily: 'NotoSans', fontSize: 20),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 5),
              height: 140,
              color: Colors.lightBlue,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.lightBlue,
                    backgroundImage: AssetImage('images/account2.jpg'),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ຊື່ຜູ້ໃຊ້',
                        style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'leethorxiongpor1999.gmail.com',
                        style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            MyListTile(
              title: 'ແກ້ໄຂຂໍ້ມູນຜູ້ໃຊ້',
              icon: Icons.account_circle_outlined,
              iconColor: Colors.blue,
              onTap: () async {
                Navigator.of(context).pop();
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => EditUser(),
                );
                Navigator.push(context, route);
              },
            ),
            MyListTile(
              title: 'ຕັ້ງຄ່າ',
              icon: Icons.settings,
              iconColor: Colors.blue,
              onTap: () async {
                Navigator.of(context).pop();
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => Setting(),
                );
                Navigator.push(context, route);
              },
            ),
            MyListTile(
              title: 'ກ່ຽວກັບແອັບ',
              icon: Icons.info_outline,
              iconColor: Colors.blue,
              onTap: () async {
                Navigator.of(context).pop();
              },
            ),
            MyListTile(
              title: 'ກ່ຽວກັບຫ້ອງການຄົ້ນຄວ້າ',
              icon: Icons.museum_outlined,
              iconColor: Colors.blue,
              onTap: () async {
                Navigator.of(context).pop();
              },
            ),
            MyListTile(
              title: 'ອອກຈາກລະບົບ',
              icon: Icons.logout,
              iconColor: Colors.red,
              onTap: () async {
                Navigator.of(context).pop();
                MyAlertDialog(
                  title: 'ທ່ານກຳລັງຈະອອກຈາກລະບົບ!',
                  content:
                      'ໃນການອອກຈາກລະບົບນີ້ຫາກທ່ານຕ້ອງການເຂົ້າໃຊ້ງານອີກທ່ານຕ້ອງໄດ້ປ້ອນອີເມລ ແລະ ລະຫັດຜ່ານເພື່ອເຂົ້າສູ່ລະບົບ',
                  onCancelPress: () async {
                    Navigator.of(context).pop();
                  },
                  onOkayPress: () async {
                    signOut();
                  },
                ).showDialogBox(context);
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: GridView.count(
          crossAxisCount: 2,
          children: [
            MyHomeCard(
              title: 'ອ່ານບົດຄົ້ນຄວ້າທັງໝົດ',
              icon: Icons.apps,
              iconColor: Colors.blue[800],
              onTapped: () async {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => BookAsAll(),
                );
                Navigator.push(context, route);
              },
            ),
            MyHomeCard(
              title: 'ອ່ານບົດຕາມຍອດ view',
              icon: Icons.remove_red_eye_outlined,
              iconColor: Colors.blue[800],
              onTapped: () async {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => BookAsView(),
                );
                Navigator.push(context, route);
              },
            ),
            MyHomeCard(
              title: 'ອ່ານບົດຕາມຍອດ like',
              icon: Icons.thumb_up_alt_outlined,
              iconColor: Colors.blue[800],
              onTapped: () async {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => BookAsLike(),
                );
                Navigator.push(context, route);
              },
            ),
            MyHomeCard(
              title: 'ອ່ານບົດຕາມຍອດ download',
              icon: Icons.arrow_circle_down,
              iconColor: Colors.blue[800],
              onTapped: () async {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => BookAsDownload(),
                );
                Navigator.push(context, route);
              },
            ),
            MyHomeCard(
              title: 'ອ່ານບົດທີ່ບັນທຶກໄວ້',
              icon: Icons.star_outline,
              iconColor: Colors.blue[800],
              onTapped: () async {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => BookAsBookmark(),
                );
                Navigator.push(context, route);
              },
            ),
            MyHomeCard(
              title: 'ຕັ້ງຄ່າ',
              icon: Icons.settings,
              iconColor: Colors.blue[800],
              onTapped: () async {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => Setting(),
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
