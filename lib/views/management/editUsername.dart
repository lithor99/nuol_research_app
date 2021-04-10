import 'package:flutter/material.dart';
import 'package:noul_research/class/myTextField.dart';
import 'package:noul_research/class/myButton.dart';
import 'package:noul_research/class/myAppBar.dart';

class EditUsername extends StatefulWidget {
  @override
  _EditUsernameState createState() => _EditUsernameState();
}

class _EditUsernameState extends State<EditUsername> {
  final txtUsername = TextEditingController();
  final txtEmail = TextEditingController();
  final txtPassword = TextEditingController();
  bool blPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(title: 'ປ່ຽນຊື່ຜູ້ໃຊ້', fontSize: 20).myAppBar(),
      body: Container(
        padding: EdgeInsets.all(0),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                  height: 100,
                  color: Colors.cyan[100],
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ຂໍ້ແນະນຳ',
                        style: TextStyle(fontFamily: 'NotoSans', fontSize: 22),
                      ),
                      Text(
                        'ໃນການປ່ຽນຊື່ຜູ້ໃຊ້ນີ້ຈຳເປັນຕ້ອງໄດ້ຢັ້ງຢືນດ້ວຍອີເມລ ແລະ ລະຫັດຜ່ານ',
                        style: TextStyle(fontFamily: 'NotoSans', fontSize: 18),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 20),
            MyUsernameText(
              title: 'ຊື່ຜູ້ໃຊ້ໃໝ່',
              controller: txtUsername,
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
            SizedBox(height: 8),
            MyEmailText(
              title: 'ອີເມລ',
              controller: txtEmail,
              iconColor: Colors.grey[500],
            ),
            SizedBox(height: 30),
            MyButton(
              title: 'ຢືນຢັນ',
              fontSize: 30,
              titleColor: Colors.white,
              buttonColor: Colors.orange,
              height: 65,
              width: (MediaQuery.of(context).size.width) - 12,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
