import 'package:flutter/material.dart';
import 'package:nuol_research/class/myAlertDialog.dart';
import 'package:nuol_research/class/myConnectivity.dart';
import 'package:nuol_research/class/myTextField.dart';
import 'package:nuol_research/class/myButton.dart';
import 'package:nuol_research/class/myToast.dart';
import 'package:nuol_research/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:nuol_research/views/management/uploadProfile.dart';

// ignore: must_be_immutable
class ConfirmSignup extends StatefulWidget {
  ConfirmSignup(
    this.registId,
    this.username,
    this.email,
    this.password,
  );
  String registId, username, email, password;
  @override
  _ConfirmSignupState createState() => _ConfirmSignupState();
}

class _ConfirmSignupState extends State<ConfirmSignup> {
  FocusNode focusNode;
  TextEditingController confirmNumberController = TextEditingController();
  Color confirmNumberTextColor = Colors.black;
  int sendMailCount = 0;

  Future<void> confirmRegister(
    String _registId,
    _username,
    _email,
    _password,
    _confNum,
  ) async {
    try {
      final url = 'http://192.168.43.191:9000/member/confirm_register';
      Map body = {
        'regist_id': _registId,
        'username': _username,
        'email': _email,
        'password': _password,
        'conf_num': _confNum
      };
      var res = await http.post(
        Uri.parse(url),
        body: body,
      );
      var data = await json.decode(res.body);
      if (data != null) {
        if (data.toString() == '{message: confirm number failed}') {
          setState(() {
            confirmNumberController.text = 'ລະຫັດທີ່ທ່ານປ້ອນບໍ່ຖືກຕ້ອງ';
            confirmNumberTextColor = Colors.red;
          });
        } else {
          await storage.write(key: "jwt", value: data['email']);
          Navigator.of(context).pop();
          MaterialPageRoute route = MaterialPageRoute(
            builder: (value) => UploadProfile(data['email']),
          );
          Navigator.push(context, route);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> sendMailAgain(String _registId, _email) async {
    final url = 'http://192.168.43.191:9000/member/send_mail_again';

    Map body = {'regist_id': _registId, 'email': _email};
    await http.put(
      Uri.parse(url),
      body: body,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      'ກະລຸນາປ້ອນລະຫັດຢືນຢັນທີ່ທ່ານໄດ້ຮັບຈາກອີເມລໃສ່ທີ່ນີ້',
                      style: TextStyle(fontFamily: 'NotoSans', fontSize: 18),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 13, right: 13),
              child: MyTextField(
                controller: confirmNumberController,
                textColor: confirmNumberTextColor,
                onChanged: (value) {
                  setState(() {
                    sendMailCount = 0;
                  });
                  if (confirmNumberTextColor == Colors.red) {
                    setState(() {
                      confirmNumberController.clear();
                      confirmNumberTextColor = Colors.black;
                    });
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            MyButton(
              title: 'ຢຶນຢັນລະຫັດ',
              fontSize: 20,
              fontWeight: FontWeight.normal,
              titleColor: Colors.white,
              buttonColor: Colors.blue,
              height: 65,
              onPressed: () {
                FocusScope.of(context).unfocus();
                if (confirmNumberController.text == null ||
                    confirmNumberController.text.isEmpty) {
                  setState(() {
                    confirmNumberController.text = 'ກະລຸນາປ້ອນລະຫັດກ່ອນ';
                    confirmNumberTextColor = Colors.red;
                  });
                } else {
                  confirmRegister(
                    widget.registId,
                    widget.username,
                    widget.email,
                    widget.password,
                    confirmNumberController.text,
                  );
                }
              },
            ),
            SizedBox(height: 20),
            MyButton(
              title: 'ສົ່ງລະຫັດອີກຄັ້ງ',
              fontSize: 20,
              fontWeight: FontWeight.normal,
              titleColor: Colors.white,
              buttonColor: Colors.orange,
              height: 65,
              onPressed: () async {
                FocusScope.of(context).unfocus();
                if (sendMailCount > 2) {
                  myDisplayDialog(
                    context,
                    'ການແຈ້ງເຕືອນ',
                    'ກະລຸນາກວດເບີ່ງວ່າອີເມລຂອງທ່ານຖືກຕ້ອງແລ້ວບໍ?',
                  );
                } else {
                  await CheckInternet.checkInternet();
                  if (CheckInternet.connectivityState == true) {
                    setState(() {
                      sendMailCount = sendMailCount + 1;
                    });
                    sendMailAgain(widget.registId, widget.email);
                  } else {
                    myToast('ກະລຸນາກວດເບີ່ງການເຊື່ອມຕໍ່ອິນເຕີເນັດກ່ອນ');
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
