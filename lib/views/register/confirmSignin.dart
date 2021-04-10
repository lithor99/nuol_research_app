import 'package:flutter/material.dart';
import 'package:noul_research/class/myTextField.dart';
import 'package:noul_research/class/myLogo.dart';
import 'package:noul_research/class/myButton.dart';
import 'package:noul_research/views/home.dart';
import 'package:noul_research/views/management/resetPassword.dart';

class ConfirmSignin extends StatefulWidget {
  @override
  _ConfirmSigninState createState() => _ConfirmSigninState();
}

class _ConfirmSigninState extends State<ConfirmSignin> {
  TextEditingController txtConfirmPass = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ຂໍ້ແນະນຳ',
              style: TextStyle(fontFamily: 'NotoSans', fontSize: 22),
            ),
            Text(
              'ກະລຸນາປ້ອນລະຫັດທີ່ທ່ານໄດ້ຮັບຈາກອີເມລໃສ່ທີ່ນີ້',
              style: TextStyle(fontFamily: 'NotoSans', fontSize: 18),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            MyTextField(
              controller: txtConfirmPass,
              width: MediaQuery.of(context).size.width - 60,
            ),
            SizedBox(height: 10),
            MyButton(
              title: 'ຢຶນຢັນລະຫັດຜ່ານ',
              fontSize: 20,
              fontWeight: FontWeight.normal,
              titleColor: Colors.white,
              buttonColor: Colors.orange,
              height: 65,
              width: (MediaQuery.of(context).size.width) - 60,
              onPressed: () {
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
