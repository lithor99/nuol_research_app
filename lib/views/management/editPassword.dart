import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nuol_research/class/myConnectivity.dart';
import 'package:nuol_research/class/myTextField.dart';
import 'package:nuol_research/class/myButton.dart';
import 'package:nuol_research/class/myAppBar.dart';
import 'package:nuol_research/class/myAlertDialog.dart';
import 'package:http/http.dart' as http;
import 'package:nuol_research/class/myToast.dart';
import 'dart:convert';

import 'package:nuol_research/views/home.dart';

import '../../main.dart';

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final emailController = TextEditingController();
  String newPasswordTitle = 'ລະຫັດຜ່ານໃໝ່';
  String emailTitle = 'ອີເມລ';
  String oldPasswordTitle = 'ລະຫັດຜ່ານເກົ່າ';
  Color newPasswordTitleColor = Colors.grey;
  Color emailTitleColor = Colors.grey;
  Color oldPasswordTitleColor = Colors.grey;
  Color newPasswordTextColor = Colors.black;
  Color emailTextColor = Colors.black;
  Color oldPasswordTextColor = Colors.black;
  bool hideOldPassword = true, hideNewPassword = true, isChanging = false;

  Future<void> editPassword(String _newPassword, _email, _oldPassword) async {
    try {
      setState(() {
        isChanging = true;
      });
      final url = serverName + '/member/edit/password';
      Map body = {
        'new_password': _newPassword,
        'email': _email,
        'old_password': _oldPassword
      };
      var res = await http.put(Uri.parse(url), body: body);
      var data = await json.decode(res.body);
      if (data != null) {
        if (data.toString() == '{message: password failed}') {
          setState(() {
            oldPasswordController.text = 'ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ';
            oldPasswordTextColor = Colors.red;
          });
        } else {
          if (data.toString() == '{message: password has updated}') {
            setState(() {
              isChanging = false;
              newPasswordController.clear();
              emailController.clear();
              newPasswordController.clear();
              oldPasswordController.clear();
            });
            myToast(
              'ປ່ຽນລະຫັດຜ່ານສຳເລັດແລ້ວ',
              Colors.black,
              Toast.LENGTH_SHORT,
            );
          } else {
            myDisplayDialog(
              context,
              'ການແຈ້ງເຕືອນ',
              'ການປ່ຽນລະຫັດຜ່ານມີຂໍ້ຜິດພາດ',
              Colors.blue,
            );
          }
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(title: 'ປ່ຽນລະຫັດຜ່ານ', fontSize: 20).myAppBar(),
      body: Container(
        padding: EdgeInsets.all(0),
        child: isChanging
            ? Center(
                child: SpinKitFadingCircle(color: Colors.blue, size: 80),
              )
            : ListView(
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
                              style: TextStyle(
                                  fontFamily: 'NotoSans', fontSize: 22),
                            ),
                            Text(
                              'ໃນການປ່ຽນລະຫັດຜ່ານນີ້ຈຳເປັນຕ້ອງໄດ້ຢັ້ງຢືນດ້ວຍອີເມລ ແລະ ລະຫັດຜ່ານເກົ່າ',
                              style: TextStyle(
                                  fontFamily: 'NotoSans', fontSize: 18),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        )),
                  ),
                  SizedBox(height: 20),
                  MyPasswordText(
                    title: newPasswordTitle,
                    titleColor: newPasswordTitleColor,
                    controller: newPasswordController,
                    textColor: newPasswordTextColor,
                    obscureText: hideNewPassword,
                    iconColor: Colors.grey[500],
                    onChanged: (value) {
                      if (newPasswordTextColor == Colors.red ||
                          newPasswordTitleColor == Colors.red) {
                        setState(() {
                          newPasswordController.clear();
                          newPasswordTextColor = Colors.black;
                          newPasswordTitle = 'ລະຫັດຜ່ານໃໝ່';
                          newPasswordTitleColor = Colors.grey;
                        });
                      }
                    },
                    onTapped: () {
                      setState(() {
                        hideNewPassword = !hideNewPassword;
                      });
                    },
                  ),
                  SizedBox(height: 8),
                  MyEmailText(
                    title: emailTitle,
                    titleColor: emailTitleColor,
                    controller: emailController,
                    textColor: emailTextColor,
                    iconColor: Colors.grey[500],
                    onChanged: (value) {
                      if (emailTextColor == Colors.red ||
                          emailTitleColor == Colors.red) {
                        setState(() {
                          emailController.clear();
                          emailTextColor = Colors.black;
                          emailTitle = 'ອີເມລ';
                          emailTitleColor = Colors.grey;
                        });
                      }
                    },
                  ),
                  SizedBox(height: 8),
                  MyPasswordText(
                    title: oldPasswordTitle,
                    titleColor: oldPasswordTitleColor,
                    controller: oldPasswordController,
                    textColor: oldPasswordTextColor,
                    obscureText: hideOldPassword,
                    iconColor: Colors.grey[500],
                    onChanged: (value) {
                      if (oldPasswordTextColor == Colors.red ||
                          oldPasswordTitleColor == Colors.red) {
                        setState(() {
                          oldPasswordController.clear();
                          oldPasswordTextColor = Colors.black;
                          oldPasswordTitle = 'ລະຫັດຜ່ານເກົ່າ';
                          oldPasswordTitleColor = Colors.grey;
                        });
                      }
                    },
                    onTapped: () {
                      setState(() {
                        hideOldPassword = !hideOldPassword;
                      });
                    },
                  ),
                  SizedBox(height: 30),
                  MyButton(
                    title: 'ຢືນຢັນ',
                    fontSize: 30,
                    titleColor: Colors.white,
                    buttonColor: Colors.orange,
                    height: 65,
                    width: (MediaQuery.of(context).size.width) - 12,
                    onPressed: Home.data == null
                        ? null
                        : () async {
                            FocusScope.of(context).unfocus();
                            if (newPasswordController.text == null ||
                                newPasswordController.text.isEmpty) {
                              setState(() {
                                newPasswordTitle = 'ກະລຸນາປ້ອນລະຫັດຜ່ານໃໝ່ກ່ອນ';
                                newPasswordTitleColor = Colors.red;
                              });
                            } else if (emailController.text == null ||
                                emailController.text.isEmpty) {
                              setState(() {
                                emailTitle = 'ກະລຸນາປ້ອນອີເມລກ່ອນ';
                                emailTitleColor = Colors.red;
                              });
                            } else if (oldPasswordController.text == null ||
                                oldPasswordController.text.isEmpty) {
                              setState(() {
                                oldPasswordTitle =
                                    'ກະລຸນາປ້ອນລະຫັດຜ່ານເກົ່າກ່ອນ';
                                oldPasswordTitleColor = Colors.red;
                              });
                            } else {
                              await CheckInternet.checkInternet();
                              if (CheckInternet.connectivityState == true) {
                                if (newPasswordController.text.length < 5) {
                                  setState(() {
                                    newPasswordController.text =
                                        'ລະຫັດຜ່ານຕ້ອງຫຼາຍກວ່າ5ຕົວ';
                                    newPasswordTextColor = Colors.red;
                                  });
                                } else if (emailController.text !=
                                    Home.data['email'].toString()) {
                                  setState(() {
                                    emailController.text = 'ອີເມລບໍ່ຖືກຕ້ອງ';
                                    emailTextColor = Colors.red;
                                  });
                                } else {
                                  await editPassword(
                                    newPasswordController.text,
                                    emailController.text,
                                    oldPasswordController.text,
                                  );
                                  Home.getMemberData(
                                    Home.data['email'].toString(),
                                  );
                                }
                              } else {
                                myToast(
                                  'ກວດສອບການເຊື່ອມຕໍ່ອິນເຕີເນັດກ່ອນ',
                                  Colors.black,
                                  Toast.LENGTH_SHORT,
                                );
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
