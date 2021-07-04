import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nuol_research/class/myConnectivity.dart';
import 'package:nuol_research/class/myTextField.dart';
import 'package:nuol_research/class/myButton.dart';
import 'package:nuol_research/class/myAppBar.dart';
import 'package:nuol_research/class/myToast.dart';
import 'package:nuol_research/views/register/confirmPassword.dart';
import 'package:http/http.dart' as http;
import 'package:nuol_research/class/myAlertDialog.dart';

import '../../main.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  FocusNode focusNode;
  final emailController = TextEditingController();
  String emailTitle = 'ອີເມລ';
  Color emailTitleColor = Colors.grey;
  String sendMailButton = 'ສົ່ງລະຫັດ';
  int sendMailCount = 0;

  Future<void> sendConfirmNumber(String _email) async {
    try {
      final url = serverName + '/member/forgot_password';
      Map body = {'email': _email};
      await http.put(
        Uri.parse(url),
        body: body,
      );
    } catch (e) {
      print(e.toString());
    }
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
                      style: TextStyle(
                        fontFamily: 'NotoSans',
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      'ກະລຸນາປ້ອນອີເມລທີ່ທ່ານໃຊ້ໃນການລົງທະບຽນແລ້ວພວກເຮົາຈະສົ່ງລະຫັດຢືນຢັນໄປທີ່ອີເມລດັ່ງກ່າວ',
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
            MyEmailText(
              title: emailTitle,
              titleColor: emailTitleColor,
              controller: emailController,
              iconColor: Colors.grey[500],
              onChanged: (value) {
                setState(() {
                  sendMailButton = 'ສົ່ງລະຫັດ';
                  sendMailCount = 0;
                });
                if (emailTitleColor == Colors.red) {
                  setState(() {
                    emailController.clear();
                    emailTitle = 'ອີເມລ';
                    emailTitleColor = Colors.grey;
                  });
                }
              },
            ),
            SizedBox(height: 20),
            MyButton(
              title: sendMailButton,
              fontSize: 20,
              fontWeight: FontWeight.normal,
              titleColor: Colors.white,
              buttonColor: Colors.blue,
              height: 65,
              onPressed: () async {
                FocusScope.of(context).unfocus();
                if (emailController.text == null ||
                    emailController.text.isEmpty) {
                  setState(() {
                    emailTitle = 'ກະລຸນາປ້ອນອີເມລກ່ອນ';
                    emailTitleColor = Colors.red;
                  });
                } else {
                  if (sendMailCount > 2) {
                    myDisplayDialog(
                      context,
                      'ການແຈ້ງເຕືອນ',
                      'ກະລຸນາກວດເບີ່ງວ່າອີເມລຂອງທ່ານຖືກຕ້ອງແລ້ວບໍ?',
                      Colors.blue,
                    );
                  } else {
                    await CheckInternet.checkInternet();
                    if (CheckInternet.connectivityState == true) {
                      setState(() {
                        sendMailCount = sendMailCount + 1;
                        sendMailButton = 'ສົ່ງລະຫັດອີກຄັ້ງ';
                      });
                      sendConfirmNumber(emailController.text);
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
              },
            ),
            SizedBox(height: 20),
            MyButton(
              title: 'ໄດ້ຮັບລະຫັດແລ້ວ',
              fontSize: 20,
              fontWeight: FontWeight.normal,
              titleColor: Colors.white,
              buttonColor: Colors.orange,
              height: 65,
              onPressed: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => ConfirmPassword(emailController.text),
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
