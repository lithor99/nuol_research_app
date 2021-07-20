import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nuol_research/about/thisApp.dart';
import 'package:nuol_research/about/thisOfficial.dart';
import 'package:nuol_research/class/downloadFile.dart';
import 'package:nuol_research/class/myConnectivity.dart';
import 'package:nuol_research/class/myToast.dart';
import 'package:nuol_research/class/viewProfile.dart';
import 'package:nuol_research/main.dart';
import 'package:nuol_research/views/books/bookAsBookmark.dart';
import 'package:nuol_research/views/management/editUser.dart';
import 'package:nuol_research/class/myCard.dart';
import 'package:nuol_research/views/books/bookAsAll.dart';
import 'package:nuol_research/views/books/bookAsView.dart';
import 'package:nuol_research/views/books/bookAsLike.dart';
import 'package:nuol_research/views/books/bookAsDownload.dart';
import 'package:nuol_research/class/myListTile.dart';
import 'package:nuol_research/views/setting/setting.dart';
import 'package:nuol_research/class/myAlertDialog.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  final String email;
  Home(this.email);
  // @override
  // Home(this.jwt, this.payload);
  // final String jwt;
  // final Map<String, dynamic> payload;

  // factory Home.fromBase64(String jwt) => Home(
  //       jwt,
  // json.decode(
  //   ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1]))),
  // ),
  //     );
  // static var payload;
  static var data;
  static Future<void> getMemberData(String email) async {
    try {
      final url = 'http://192.168.43.191:9000/member/get_member_data';
      // var headers = {
      //   'Authorization': 'nuol_research',
      // };
      Map body = {
        'email': email,
      };
      var res = await http.post(
        Uri.parse(url),
        // headers: headers,
        body: body,
      );
      data = null;
      data = await json.decode(res.body);
      print('home member data:' + data.toString());
      if (data != null) {
        await storage.delete(key: "email");
        await storage.write(key: "email", value: data['email']);
        // Home.payload = null;
        // Home.payload = await json.decode(
        //   ascii.decode(
        //     base64.decode(base64.normalize(data['token'].split(".")[1])),
        //   ),
        // );
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static Future<void> settingItem() async {
    try {
      if (preferences.getString('topView') == null) {
        preferences.setString('topView', '10');
      }
      if (preferences.getString('topLike') == null) {
        preferences.setString('topLike', '10');
      }
      if (preferences.getString('topDownload') == null) {
        preferences.setString('topDownload', '10');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String username, email, profile;

  Future<void> deleteSettingItem() async {
    try {
      await preferences.remove('topView');
      await preferences.remove('topLike');
      await preferences.remove('topDownload');
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<void> signOut() async {
    await deleteSettingItem();
    await storage.delete(key: "email");
    exit(0);
  }

  @override
  void initState() {
    Home.settingItem();
    IsolateNameServer.registerPortWithName(
      receivePort.sendPort,
      'Donloading File',
    );
    receivePort.listen((message) {
      setState(() {
        progress = message;
      });
    });
    FlutterDownloader.registerCallback(DownloadBookFile.downloadCallback);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ໜ້າຫຼັກ',
          style: TextStyle(fontFamily: 'NotoSans', fontSize: 20),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(left: 5),
              height: 140,
              color: Colors.lightBlue,
              child: FutureBuilder(
                future: Home.getMemberData(widget.email),
                builder: (context, snapshot) => snapshot.connectionState ==
                        ConnectionState.done
                    ? Home.data == null ||
                            Home.data.toString() ==
                                '{message: this user has banned}'
                        ? Row(
                            children: [
                              InkWell(
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundColor: Colors.white,
                                    child: Text(
                                      'ບໍ່ມີຮູບພາບ',
                                      style: TextStyle(
                                        fontFamily: 'NotoSans',
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (value) => ViewProfile(),
                                      ),
                                    );
                                  }),
                              SizedBox(width: 3),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'ຊື່ຜູ້ໃຊ້',
                                    style: TextStyle(
                                      fontFamily: 'NotoSans',
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                  Text(
                                    'ອີເມລ',
                                    style: TextStyle(
                                      fontFamily: 'NotoSans',
                                      fontSize: 11,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        : Row(
                            children: [
                              InkWell(
                                  child: Home.data['profile'] == 'no profile'
                                      ? CircleAvatar(
                                          radius: 40,
                                          backgroundColor: Colors.white,
                                          child: Text(
                                            'ບໍ່ມີຮູບພາບ',
                                            style: TextStyle(
                                              fontFamily: 'NotoSans',
                                              fontSize: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        )
                                      : CircleAvatar(
                                          radius: 40,
                                          backgroundColor: Colors.white,
                                          backgroundImage: NetworkImage(
                                            Home.data['profile'].toString(),
                                          ),
                                        ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (value) => ViewProfile(),
                                      ),
                                    );
                                  }),
                              SizedBox(width: 3),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Home.data['username'].toString(),
                                    style: TextStyle(
                                      fontFamily: 'NotoSans',
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    Home.data['email'].toString(),
                                    style: TextStyle(
                                      fontFamily: 'NotoSans',
                                      fontSize: 11,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                    : Row(
                        children: [
                          InkWell(
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.white,
                                child: Text(
                                  'ບໍ່ມີຮູບພາບ',
                                  style: TextStyle(
                                    fontFamily: 'NotoSans',
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (value) => ViewProfile(),
                                  ),
                                );
                              }),
                          SizedBox(width: 3),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ຊື່ຜູ້ໃຊ້',
                                style: TextStyle(
                                  fontFamily: 'NotoSans',
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.visible,
                              ),
                              Text(
                                'ອີເມລ',
                                style: TextStyle(
                                  fontFamily: 'NotoSans',
                                  fontSize: 11,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
              ),
            ),
            MyListTile(
              title: 'ແກ້ໄຂຂໍ້ມູນຜູ້ໃຊ້',
              icon: Icons.account_circle_outlined,
              iconColor: Colors.blue,
              onTap: () async {
                Navigator.of(context).pop();
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => EditUser(),
                );
                Navigator.push(context, route);
              },
            ),
            MyListTile(
              title: 'ຕັ້ງຄ່າ',
              icon: Icons.settings,
              iconColor: Colors.blue,
              onTap: () async {
                Navigator.of(context).pop();
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => Setting(),
                );
                Navigator.push(context, route);
              },
            ),
            MyListTile(
              title: 'ກ່ຽວກັບແອັບ',
              icon: Icons.info_outline,
              iconColor: Colors.blue,
              onTap: () async {
                Navigator.of(context).pop();
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => AboutThisApp(),
                );
                Navigator.push(context, route);
              },
            ),
            MyListTile(
              title: 'ກ່ຽວກັບຫ້ອງການຄົ້ນຄວ້າ',
              icon: Icons.museum_outlined,
              iconColor: Colors.blue,
              onTap: () async {
                Navigator.of(context).pop();
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (value) => AboutThisOfficial(),
                );
                Navigator.push(context, route);
              },
            ),
            MyListTile(
              title: 'ອອກຈາກລະບົບ',
              icon: Icons.power_settings_new,
              iconColor: Colors.red,
              onTap: () async {
                Navigator.of(context).pop();
                MyAlertDialog(
                    title: 'ທ່ານກຳລັງຈະອອກຈາກລະບົບ!',
                    content:
                        'ໃນການອອກຈາກລະບົບນີ້ຫາກທ່ານຕ້ອງການເຂົ້າໃຊ້ງານລະບົບອີກທ່ານຕ້ອງໄດ້ປ້ອນອີເມລ ແລະ ລະຫັດຜ່ານເພື່ອເຂົ້າສູ່ລະບົບໃໝ່',
                    okColor: Colors.red,
                    cancelColor: Colors.blue,
                    onOkay: () async {
                      signOut();
                    },
                    onCancel: () async {
                      Navigator.of(context).pop();
                    }).showDialogBox(context);
              },
            ),
          ],
        ),
      ),
      body: Container(
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //     begin: Alignment.centerLeft,
        //     end: Alignment.centerRight,
        //     colors: [Colors.blue[200], Colors.blue, Colors.blue[200]],
        //   ),
        // ),
        color: Colors.blue[400],
        child: Padding(
          padding: EdgeInsets.all(5),
          child: FutureBuilder(
            future: Home.getMemberData(widget.email),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.done
                    ? GridView.count(
                        crossAxisCount: 2,
                        children: [
                          MyMenuCard(
                            title: 'ອ່ານບົດຄົ້ນຄວ້າທັງໝົດ',
                            icon: Icons.apps,
                            iconColor: Colors.blue[800],
                            onTapped: () async {
                              await CheckInternet.checkInternet();
                              if (CheckInternet.connectivityState == true) {
                                if (Home.data == null) {
                                  MyAlertDialog(
                                      title: 'ລະບົບບໍ່ຕອບສະໜອງ!',
                                      content: 'ກະລຸນາເຂົ້າສູ່ລະບົບໃໝ່',
                                      okColor: Colors.blue,
                                      cancelColor: Colors.red,
                                      onOkay: () async {
                                        exit(0);
                                      },
                                      onCancel: () async {
                                        Navigator.of(context).pop();
                                      }).showDialogBox(context);
                                } else if (Home.data.toString() ==
                                    '{message: this user has banned}') {
                                  myToast('ບັນຊີນີ້ຖືກຫ້າມບໍ່ໃຫ້ເຂົ້າໃຊ້ລະບົບ',
                                      Colors.red, Toast.LENGTH_SHORT);
                                } else {
                                  MaterialPageRoute route = MaterialPageRoute(
                                    builder: (value) => BookAsAll(
                                      Home.data['member_id'].toString(),
                                    ),
                                  );
                                  Navigator.push(context, route);
                                }
                              } else {
                                myToast(
                                  'ກວດສອບການເຊື່ອມຕໍ່ອິນເຕີເນັດກ່ອນ',
                                  Colors.black,
                                  Toast.LENGTH_SHORT,
                                );
                              }
                            },
                          ),
                          MyMenuCard(
                            title: 'ອ່ານບົດຕາມຍອດ view',
                            icon: Icons.remove_red_eye_outlined,
                            iconColor: Colors.blue[800],
                            onTapped: () async {
                              await CheckInternet.checkInternet();
                              if (CheckInternet.connectivityState == true) {
                                if (Home.data == null) {
                                  MyAlertDialog(
                                      title: 'ລະບົບບໍ່ຕອບສະໜອງ!',
                                      content: 'ກະລຸນາເຂົ້າສູ່ລະບົບໃໝ່',
                                      okColor: Colors.blue,
                                      cancelColor: Colors.red,
                                      onOkay: () async {
                                        exit(0);
                                      },
                                      onCancel: () async {
                                        Navigator.of(context).pop();
                                      }).showDialogBox(context);
                                } else if (Home.data.toString() ==
                                    '{message: this user has banned}') {
                                  myToast(
                                    'ບັນຊີນີ້ຖືກຫ້າມບໍ່ໃຫ້ເຂົ້າໃຊ້ລະບົບ',
                                    Colors.red,
                                    Toast.LENGTH_SHORT,
                                  );
                                } else {
                                  MaterialPageRoute route = MaterialPageRoute(
                                    builder: (value) => BookAsView(
                                      Home.data['member_id'].toString(),
                                    ),
                                  );
                                  Navigator.push(context, route);
                                }
                              } else {
                                myToast(
                                  'ກວດສອບການເຊື່ອມຕໍ່ອິນເຕີເນັດກ່ອນ',
                                  Colors.black,
                                  Toast.LENGTH_SHORT,
                                );
                              }
                            },
                          ),
                          MyMenuCard(
                            title: 'ອ່ານບົດຕາມຍອດ like',
                            icon: Icons.thumb_up_alt_outlined,
                            iconColor: Colors.blue[800],
                            onTapped: () async {
                              await CheckInternet.checkInternet();
                              if (CheckInternet.connectivityState == true) {
                                if (Home.data == null) {
                                  MyAlertDialog(
                                      title: 'ລະບົບບໍ່ຕອບສະໜອງ!',
                                      content: 'ກະລຸນາເຂົ້າສູ່ລະບົບໃໝ່',
                                      okColor: Colors.blue,
                                      cancelColor: Colors.red,
                                      onOkay: () async {
                                        exit(0);
                                      },
                                      onCancel: () async {
                                        Navigator.of(context).pop();
                                      }).showDialogBox(context);
                                } else if (Home.data.toString() ==
                                    '{message: this user has banned}') {
                                  myToast(
                                    'ບັນຊີນີ້ຖືກຫ້າມບໍ່ໃຫ້ເຂົ້າໃຊ້ລະບົບ',
                                    Colors.red,
                                    Toast.LENGTH_SHORT,
                                  );
                                } else {
                                  MaterialPageRoute route = MaterialPageRoute(
                                    builder: (value) => BookAsLike(
                                      Home.data['member_id'].toString(),
                                    ),
                                  );
                                  Navigator.push(context, route);
                                }
                              } else {
                                myToast(
                                  'ກວດສອບການເຊື່ອມຕໍ່ອິນເຕີເນັດກ່ອນ',
                                  Colors.black,
                                  Toast.LENGTH_SHORT,
                                );
                              }
                            },
                          ),
                          MyMenuCard(
                            title: 'ອ່ານບົດຕາມຍອດ download',
                            icon: Icons.arrow_circle_down,
                            iconColor: Colors.blue[800],
                            onTapped: () async {
                              await CheckInternet.checkInternet();
                              if (CheckInternet.connectivityState == true) {
                                if (Home.data == null) {
                                  MyAlertDialog(
                                      title: 'ລະບົບບໍ່ຕອບສະໜອງ!',
                                      content: 'ກະລຸນາເຂົ້າສູ່ລະບົບໃໝ່',
                                      okColor: Colors.blue,
                                      cancelColor: Colors.red,
                                      onOkay: () async {
                                        exit(0);
                                      },
                                      onCancel: () async {
                                        Navigator.of(context).pop();
                                      }).showDialogBox(context);
                                } else if (Home.data.toString() ==
                                    '{message: this user has banned}') {
                                  myToast(
                                    'ບັນຊີນີ້ຖືກຫ້າມບໍ່ໃຫ້ເຂົ້າໃຊ້ລະບົບ',
                                    Colors.red,
                                    Toast.LENGTH_SHORT,
                                  );
                                } else {
                                  MaterialPageRoute route = MaterialPageRoute(
                                    builder: (value) => BookAsDownload(
                                      Home.data['member_id'].toString(),
                                    ),
                                  );
                                  Navigator.push(context, route);
                                }
                              } else {
                                myToast(
                                  'ກວດສອບການເຊື່ອມຕໍ່ອິນເຕີເນັດກ່ອນ',
                                  Colors.black,
                                  Toast.LENGTH_SHORT,
                                );
                              }
                            },
                          ),
                          MyMenuCard(
                            title: 'ອ່ານບົດທີ່ບັນທຶກໄວ້',
                            icon: Icons.star_outline,
                            iconColor: Colors.blue[800],
                            onTapped: () async {
                              await CheckInternet.checkInternet();
                              if (CheckInternet.connectivityState == true) {
                                if (Home.data == null) {
                                  MyAlertDialog(
                                      title: 'ລະບົບບໍ່ຕອບສະໜອງ!',
                                      content: 'ກະລຸນາເຂົ້າສູ່ລະບົບໃໝ່',
                                      okColor: Colors.blue,
                                      cancelColor: Colors.red,
                                      onOkay: () async {
                                        exit(0);
                                      },
                                      onCancel: () async {
                                        Navigator.of(context).pop();
                                      }).showDialogBox(context);
                                } else if (Home.data.toString() ==
                                    '{message: this user has banned}') {
                                  myToast(
                                    'ບັນຊີນີ້ຖືກຫ້າມບໍ່ໃຫ້ເຂົ້າໃຊ້ລະບົບ',
                                    Colors.red,
                                    Toast.LENGTH_SHORT,
                                  );
                                } else {
                                  MaterialPageRoute route = MaterialPageRoute(
                                    builder: (value) => BookAsBookmark(
                                      Home.data['member_id'].toString(),
                                    ),
                                  );
                                  Navigator.push(context, route);
                                }
                              } else {
                                myToast(
                                  'ກວດສອບການເຊື່ອມຕໍ່ອິນເຕີເນັດກ່ອນ',
                                  Colors.black,
                                  Toast.LENGTH_SHORT,
                                );
                              }
                            },
                          ),
                          MyMenuCard(
                            title: 'ຕັ້ງຄ່າ',
                            icon: Icons.settings,
                            iconColor: Colors.blue[800],
                            onTapped: () async {
                              MaterialPageRoute route = MaterialPageRoute(
                                builder: (value) => Setting(),
                              );
                              Navigator.push(context, route);
                            },
                          ),
                        ],
                      )
                    : SpinKitChasingDots(color: Colors.orange[800], size: 300),
          ),
        ),
      ),
    );
  }
}
