import 'package:flutter/material.dart';
import 'package:nuol_research/class/myListTile.dart';
import 'package:nuol_research/class/myAppBar.dart';
import 'package:nuol_research/views/management/editPassword.dart';
import 'package:nuol_research/views/management/editProfile.dart';
import 'package:nuol_research/views/management/editUsername.dart';

// ignore: must_be_immutable
class EditUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(title: 'ແກ້ໄຂຂໍ້ມູນຜູ້ໃຊ', fontSize: 20).myAppBar(),
      body: Padding(
        padding: EdgeInsets.all(0),
        child: ListView(
          children: [
            MyListTile(
              title: 'ປ່ຽນຮູບໜ້າປົກ',
              icon: Icons.account_circle_outlined,
              iconColor: Colors.blue,
              onTap: () async {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => EditProfile(),
                );
                Navigator.push(context, route);
              },
            ),
            MyListTile(
              title: 'ປ່ຽນຊື່ຜູ້ໃຊ້',
              icon: Icons.brightness_auto_outlined,
              iconColor: Colors.blue,
              onTap: () async {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => EditUsername(),
                );
                Navigator.push(context, route);
              },
            ),
            MyListTile(
              title: 'ປ່ຽນລະຫັດຜ່ານ',
              icon: Icons.vpn_key_rounded,
              iconColor: Colors.blue,
              onTap: () async {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => EditPassword(),
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
