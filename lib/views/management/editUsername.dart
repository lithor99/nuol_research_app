import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nuol_research/class/myAlertDialog.dart';
import 'package:nuol_research/class/myConnectivity.dart';
import 'package:nuol_research/class/myTextField.dart';
import 'package:nuol_research/class/myButton.dart';
import 'package:nuol_research/class/myAppBar.dart';
import 'package:http/http.dart' as http;
import 'package:nuol_research/class/myToast.dart';
import 'dart:convert';

import 'package:nuol_research/views/home.dart';

import '../../main.dart';

class EditUsername extends StatefulWidget {
  @override
  _EditUsernameState createState() => _EditUsernameState();
}

class _EditUsernameState extends State<EditUsername> {
  final newUsernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String newUsernameTitle = 'ຊື່ຜູໃຊ້ໃໝ່';
  String emailTitle = 'ອີເມລ';
  String passwordTitle = 'ລະຫັດຜ່ານ';
  Color newUsernameTitleColor = Colors.grey;
  Color emailTitleColor = Colors.grey;
  Color passwordTitleColor = Colors.grey;
  Color newUsernameTextColor = Colors.black;
  Color emailTextColor = Colors.black;
  Color passwordTextColor = Colors.black;
  bool hidePassword = true, isChanging = false;

  Future<void> editUsername(String _newUsername, _email, _password) async {
    try {
      setState(() {
        isChanging = true;
      });
      final url = serverName + '/member/edit/username';
      Map body = {
        'new_username': _newUsername,
        'email': _email,
        'password': _password
      };
      var res = await http.put(Uri.parse(url), body: body);

      var data = await json.decode(res.body);
      if (data != null) {
        if (data.toString() == '{message: password failed}') {
          setState(() {
            passwordController.text = 'ລະຫັດຜ່ານບໍ່ຖືກຕ້ອງ';
            passwordTextColor = Colors.red;
          });
        } else {
          if (data.toString() == '{message: username has updated}') {
            setState(() {
              isChanging = false;
              newUsernameController.clear();
              emailController.clear();
              passwordController.clear();
            });
            myToast(
              'ປ່ຽນຊື່ຜູ້ໃຊ້ສຳເລັດແລ້ວ',
              Colors.black,
              Toast.LENGTH_SHORT,
            );
          } else {
            myDisplayDialog(
              context,
              'ການແຈ້ງເຕືອນ',
              'ການປ່ຽນຊື່ຜູ້ໃຊ້ມີຂໍ້ຜິດພາດ',
              Colors.blue,
            );
          }
        }
      }
    } catch (e) {
      print('edit username error:' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(title: 'ປ່ຽນຊື່ຜູ້ໃຊ້', fontSize: 20).myAppBar(),
      body: Container(
        padding: EdgeInsets.all(5),
        child: isChanging
            ? SpinKitFadingCircle(color: Colors.blue, size: 80)
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
                              'ໃນການປ່ຽນຊື່ຜູ້ໃຊ້ນີ້ຈຳເປັນຕ້ອງໄດ້ຢັ້ງຢືນດ້ວຍອີເມລ ແລະ ລະຫັດຜ່ານ',
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
                  MyUsernameText(
                    title: newUsernameTitle,
                    titleColor: newUsernameTitleColor,
                    controller: newUsernameController,
                    textColor: newUsernameTextColor,
                    iconColor: Colors.grey[500],
                    onChanged: (value) {
                      if (newUsernameTextColor == Colors.red ||
                          newUsernameTitleColor == Colors.red) {
                        setState(() {
                          newUsernameController.clear();
                          newUsernameTextColor = Colors.black;
                          newUsernameTitle = 'ຊື່ຜູ້ໃຊ້ໃໝ່';
                          newUsernameTitleColor = Colors.grey;
                        });
                      }
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
                    title: passwordTitle,
                    titleColor: passwordTitleColor,
                    controller: passwordController,
                    textColor: passwordTextColor,
                    obscureText: hidePassword,
                    iconColor: Colors.grey[500],
                    onChanged: (value) {
                      if (passwordTextColor == Colors.red ||
                          passwordTitleColor == Colors.red) {
                        setState(() {
                          passwordController.clear();
                          passwordTextColor = Colors.black;
                          passwordTitle = 'ລະຫັດຜ່ານ';
                          passwordTitleColor = Colors.grey;
                        });
                      }
                    },
                    onTapped: () {
                      setState(() {
                        hidePassword = !hidePassword;
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
                            if (newUsernameController.text == null ||
                                newUsernameController.text.isEmpty) {
                              setState(() {
                                newUsernameTitle = 'ກະລຸນາປ້ອນຊື່ຜູ້ໃຊ້ກ່ອນ';
                                newUsernameTitleColor = Colors.red;
                              });
                            } else if (emailController.text == null ||
                                emailController.text.isEmpty) {
                              setState(() {
                                emailTitle = 'ກະລຸນາປ້ອນອີເມລກ່ອນ';
                                emailTitleColor = Colors.red;
                              });
                            } else if (passwordController.text == null ||
                                passwordController.text.isEmpty) {
                              setState(() {
                                passwordTitle = 'ກະລຸນາປ້ອນລະຫັດກ່ອນ';
                                passwordTitleColor = Colors.red;
                              });
                            } else {
                              await CheckInternet.checkInternet();
                              if (CheckInternet.connectivityState == true) {
                                if (emailController.text !=
                                    Home.data['email'].toString()) {
                                  setState(() {
                                    emailController.text = 'ອີເມລບໍ່ຖືກຕ້ອງ';
                                    emailTextColor = Colors.red;
                                  });
                                } else {
                                  await editUsername(
                                    newUsernameController.text,
                                    emailController.text,
                                    passwordController.text,
                                  );
                                  Home.getMemberData(
                                    Home.data['email'].toString(),
                                  );
                                }
                              } else {
                                myToast(
                                  'ກະລຸນາກວດເບີ່ງການເຊື່ອມຕໍ່ອິນເຕີເນັດກ່ອນ',
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
