import 'package:flutter/material.dart';
import 'package:noul_research/class/myTextField.dart';
import 'package:noul_research/class/myButton.dart';
import 'package:noul_research/class/myAppBar.dart';
import 'package:noul_research/views/register/signinWithNewPass.dart';

class ResetPassword extends StatefulWidget {
  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final txtEmail = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(title: 'ລືມລະຫັດຜ່ານ', fontSize: 20).myAppBar(),
      body: Center(
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
                        'ກະລຸນາປ້ອນອີເມລທີ່ທ່ານໃຊ້ໃນການລົງທະບຽນ ແລ້ວພວກເຮົາຈະສົ່ງລະຫັດຜ່ານໃໝ່ໄປທີ່ອີເມລດັ່ງກ່າວ',
                        style: TextStyle(fontFamily: 'NotoSans', fontSize: 18),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
            ),
            SizedBox(height: 20),
            MyEmailText(
              title: 'ອີເມລ',
              controller: txtEmail,
              iconColor: Colors.grey[500],
            ),
            SizedBox(height: 20),
            MyButton(
              title: 'ຢຶນຢັນອີເມລ',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              titleColor: Colors.white,
              buttonColor: Colors.green[600],
              height: 65,
              width: (MediaQuery.of(context).size.width) / 2 - 20,
              onPressed: () {},
            ),
            SizedBox(height: 15),
            Row(
              children: [
                MyButton(
                  title: 'ສົ່ງລະຫັດອີກຄັ້ງ',
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  titleColor: Colors.white,
                  buttonColor: Colors.orange,
                  height: 65,
                  width: (MediaQuery.of(context).size.width) / 2 - 20,
                  onPressed: () {},
                ),
                MyButton(
                  title: 'ໄດ້ຮັບລະຫັດແລ້ວ',
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                  titleColor: Colors.white,
                  buttonColor: Colors.blue,
                  height: 65,
                  width: (MediaQuery.of(context).size.width) / 2 - 20,
                  onPressed: () {
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (value) => SignInWithNewPass(),
                    );
                    Navigator.push(context, route);
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
