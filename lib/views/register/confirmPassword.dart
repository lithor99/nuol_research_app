import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nuol_research/class/myConnectivity.dart';
import 'package:nuol_research/class/myToast.dart';
import 'package:nuol_research/main.dart';
import 'package:nuol_research/class/myTextField.dart';
import 'package:nuol_research/class/myButton.dart';
import 'package:nuol_research/class/myAppBar.dart';
import 'package:http/http.dart' as http;
import 'package:nuol_research/class/myAlertDialog.dart';
import 'package:nuol_research/views/register/forgotPassword.dart';
import 'package:nuol_research/views/register/signin.dart';

// ignore: must_be_immutable
class ConfirmPassword extends StatefulWidget {
  ConfirmPassword(this.email);
  String email;
  @override
  _ConfirmPasswordState createState() => _ConfirmPasswordState();
}

class _ConfirmPasswordState extends State<ConfirmPassword> {
  FocusNode focusNode;
  final confirmNumberController = TextEditingController();
  Color confirmNumberTextColor = Colors.black;
  String sendMailButton = 'ຢືນຢັນລະຫັດຜ່ານ';
  int sendMailCount = 0;

  Future<void> sendPassword(String _email, _confNum) async {
    final url = serverName + '/member/confirm_email';

    Map body = {'email': _email, 'conf_num': _confNum};
    await http.put(
      Uri.parse(url),
      body: body,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(title: 'ກູ້ຄືນລະຫັດຜ່ານ', fontSize: 20).myAppBar(),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                height: 150,
                color: Colors.cyan[100],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'ຂໍ້ແນະນຳ',
                      style: TextStyle(fontFamily: 'NotoSans', fontSize: 22),
                    ),
                    Text(
                      'ກະລຸນາຢືນຢັນດ້ວຍການປ້ອນລະຫັດທີ່ທ່ານໄດ້ຮັບຈາກອີເມລແລ້ວພວກເຮົາຈະສົ່ງລະຫັດຜ່ານຂອງທ່ານໄປທີ່ອີເມລດັ່ງກ່າວ',
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
                width: MediaQuery.of(context).size.width - 60,
                onChanged: (value) {
                  setState(() {
                    sendMailCount = 0;
                    sendMailButton = 'ຢືນຢັນລະຫັດຜ່ານ';
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
              title: sendMailButton,
              fontSize: 20,
              fontWeight: FontWeight.normal,
              titleColor: Colors.white,
              buttonColor: Colors.orange,
              height: 65,
              width: MediaQuery.of(context).size.width - 60,
              onPressed: () async {
                FocusScope.of(context).unfocus();
                if (confirmNumberController.text == '') {
                  setState(() {
                    confirmNumberTextColor = Colors.red;
                    confirmNumberController.text = 'ກະລຸນາປ້ອນລະຫັດກ່ອນ';
                  });
                } else {
                  if (sendMailCount > 2) {
                    myDisplayDialog(
                      context,
                      'ການແຈ້ງເຕືອນ',
                      'ກະລຸນາກວດເບີ່ງວ່າອີເມລທີ່ທ່ານປ້ອນກ່ອນໜ້ານີ້ຖືກຕ້ອງແລ້ວບໍ?',
                      Colors.blue,
                    );
                  } else {
                    if (sendMailCount > 2) {
                      myDisplayDialog(
                        context,
                        'ການແຈ້ງເຕືອນ',
                        'ກະລຸນາກວດເບີ່ງວ່າອີເມລທີ່ທ່ານປ້ອນກ່ອນໜ້ານີ້ຖືກຕ້ອງແລ້ວບໍ?',
                        Colors.blue,
                      );
                    } else {
                      await CheckInternet.checkInternet();
                      if (CheckInternet.connectivityState == true) {
                        setState(() {
                          sendMailCount = sendMailCount + 1;
                          sendMailButton = 'ຍັງບໍ່ທັນໄດ້ຮັບລະຫັດ';
                        });
                        sendPassword(
                          widget.email,
                          confirmNumberController.text,
                        );
                        myToast(
                          'ກະລຸນາລໍຖ້າລະບົບກຳລັງສົ່ງລະຫັດໄປຫາອີເມລ',
                          Colors.black,
                          Toast.LENGTH_LONG,
                        );
                      } else {
                        myToast(
                          'ກະລຸນາກວດເບີ່ງການເຊື່ອມຕໍ່ອິນເຕີເນັດກ່ອນ',
                          Colors.black,
                          Toast.LENGTH_SHORT,
                        );
                      }
                    }
                  }
                }
              },
            ),
            SizedBox(height: 20),
            MyButton(
              title: 'ໄດ້ຮັບລະຫັດແລ້ວ',
              fontSize: 20,
              fontWeight: FontWeight.normal,
              titleColor: Colors.white,
              buttonColor: Colors.blue,
              height: 65,
              width: MediaQuery.of(context).size.width - 60,
              onPressed: () {
                Navigator.of(context).pop(
                  MaterialPageRoute(builder: (value) => ForgotPassword()),
                );
                Navigator.of(context).pop(
                  MaterialPageRoute(builder: (value) => SignIn()),
                );
                Navigator.of(context).pop();
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => MyApp(),
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
