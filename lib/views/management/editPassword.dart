import 'package:flutter/material.dart';
import 'package:noul_research/class/myTextField.dart';
import 'package:noul_research/class/myButton.dart';
import 'package:noul_research/class/myAppBar.dart';

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final txtOldPassword = TextEditingController();
  final txtNewPassword = TextEditingController();
  final txtEmail = TextEditingController();
  bool blOldPassword = true, blNewPassword = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(title: 'ປ່ຽນລະຫັດຜ່ານ', fontSize: 20).myAppBar(),
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
                        'ໃນການປ່ຽນລະຫັດຜ່ານນີ້ຈຳເປັນຕ້ອງໄດ້ຢັ້ງຢືນດ້ວຍອີເມລ ແລະ ລະຫັດຜ່ານເກົ່າ',
                        style: TextStyle(fontFamily: 'NotoSans', fontSize: 18),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 20),
            MyPasswordText(
              title: 'ລະຫັດຜ່ານໃໝ່',
              controller: txtNewPassword,
              obscureText: blNewPassword,
              iconColor: Colors.grey[500],
              onChanged: () {},
              onTapped: () {
                setState(() {
                  blNewPassword = !blNewPassword;
                });
              },
            ),
            SizedBox(height: 8),
            MyPasswordText(
              title: 'ລະຫັດຜ່ານເກົ່າ',
              controller: txtOldPassword,
              obscureText: blOldPassword,
              iconColor: Colors.grey[500],
              onChanged: () {},
              onTapped: () {
                setState(() {
                  blOldPassword = !blOldPassword;
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
