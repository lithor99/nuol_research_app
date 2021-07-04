import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuol_research/class/myAlertDialog.dart';
import 'package:nuol_research/class/myAppBar.dart';
import 'package:nuol_research/class/myButton.dart';
import 'package:nuol_research/class/myConnectivity.dart';
import 'package:nuol_research/class/myToast.dart';
import 'package:nuol_research/class/viewProfile.dart';
import 'package:nuol_research/views/home.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  FirebaseStorage storage = FirebaseStorage.instance;
  File imageFile;
  String imageUrl;
  bool isChanging = false;
  bool clearProfile = false;
  final imagePicker = ImagePicker();

  Future<void> imageFromCamera() async {
    PickedFile imageCamera =
        await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      imageFile = File(imageCamera.path);
      imageUrl = 'no profile';
    });
  }

  Future<void> imageFromGallery() async {
    PickedFile imageGallery =
        await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(imageGallery.path);
      imageUrl = 'no profile';
    });
  }

  Future<void> clearImage() async {
    setState(() {
      imageFile = null;
      imageUrl = 'no profile';
      clearProfile = true;
    });
  }

  Future<void> saveImageUrl(String email, profile) async {
    final url = serverName + '/member/upload_profile';
    Map body = {'email': email, 'profile': profile};
    await http.put(Uri.parse(url), body: body);
  }

  Future<void> uploadImage() async {
    try {
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        setState(() {
          isChanging = true;
        });
        if (imageFile == null) {
          await saveImageUrl(Home.data['email'].toString(), imageUrl);
          await Home.getMemberData(Home.data['email'].toString());
          setState(() {
            isChanging = false;
            imageFile = null;
            imageUrl = imageUrl = Home.data['profile'];
          });
        } else {
          Reference reference = storage.ref().child(
              'profiles/${Home.data['email'].toString()}_${DateTime.now().toString()}');
          UploadTask uploadTask = reference.putFile(imageFile);
          TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
          imageUrl = await taskSnapshot.ref.getDownloadURL();
          await saveImageUrl(Home.data['email'].toString(), imageUrl);
          await Home.getMemberData(Home.data['email'].toString());
          setState(() {
            isChanging = false;
            imageFile = null;
            imageUrl = Home.data['profile'];
          });
          myToast(
            'ປ່ຽນຮູບໜ້າປົກສຳເລັດແລ້ວ',
            Colors.black,
            Toast.LENGTH_SHORT,
          );
        }
      } else {
        myToast(
          'ກະລຸນາກວດເບີ່ງການເຊື່ອມຕໍ່ອິນເຕີເນັດກ່ອນ',
          Colors.black,
          Toast.LENGTH_SHORT,
        );
      }
    } catch (e) {
      print('edit profile error:' + e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    if (Home.data == null) {
      setState(() {
        imageUrl = 'no profile';
      });
    } else {
      setState(() {
        imageUrl = Home.data['profile'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(title: 'ປ່ຽນຮູບໜ້າປົກ', fontSize: 20).myAppBar(),
      body: Padding(
        padding: EdgeInsets.only(left: 5, top: 10, right: 5, bottom: 10),
        child: Center(
          child: isChanging
              ? SpinKitFadingCircle(color: Colors.blue, size: 80)
              : ListView(
                  children: [
                    InkWell(
                        child: Home.data == null
                            ? CircleAvatar(
                                radius:
                                    2 * (MediaQuery.of(context).size.width) / 5,
                                backgroundColor: Colors.blue[100],
                                child: Text(
                                  'ບໍ່ມີຮູບພາບ',
                                  style: TextStyle(
                                    fontFamily: 'NotoSans',
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            : imageUrl == 'no profile' && imageFile == null
                                ? CircleAvatar(
                                    radius: 2 *
                                        (MediaQuery.of(context).size.width) /
                                        5,
                                    backgroundColor: Colors.blue[100],
                                    child: Text(
                                      'ບໍ່ມີຮູບພາບ',
                                      style: TextStyle(
                                        fontFamily: 'NotoSans',
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 2 *
                                        (MediaQuery.of(context).size.width) /
                                        5,
                                    backgroundColor: Colors.blue[100],
                                    backgroundImage: imageFile == null
                                        ? NetworkImage(imageUrl)
                                        : FileImage(imageFile),
                                  ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (value) => ViewProfile(),
                            ),
                          );
                        }),
                    IconButton(
                      onPressed: imageFile == null && imageUrl == 'no profile'
                          ? null
                          : () async {
                              await clearImage();
                            },
                      icon: Icon(
                        Icons.delete,
                        size: 40,
                      ),
                      color: Colors.red,
                      splashColor: Colors.yellow,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 15),
                        MyButton(
                          title: 'ເລືອກຮູບພາບ',
                          titleColor: Colors.white,
                          height: 60,
                          width: (MediaQuery.of(context).size.width) / 2,
                          buttonColor: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          onPressed: Home.data == null
                              ? null
                              : () async {
                                  ChooseImageDialog(
                                    onCameraPressed: () {
                                      Navigator.of(context).pop();
                                      imageFromCamera();
                                    },
                                    onGalleryPressed: () {
                                      Navigator.of(context).pop();
                                      imageFromGallery();
                                    },
                                  ).chooseFileDialog(context);
                                },
                        ),
                        // MyButton(
                        //   title: 'ລຶບຮູບພາບ',
                        //   titleColor: Colors.white,
                        //   height: 60,
                        //   width: (MediaQuery.of(context).size.width) / 2,
                        //   buttonColor: Colors.orange[800],
                        //   fontSize: 20,
                        //   fontWeight: FontWeight.normal,
                        //   onPressed:
                        //       imageFile == null && imageUrl == 'no profile'
                        //           ? null
                        //           : () async {
                        //               await clearImage();
                        //             },
                        // ),
                        SizedBox(height: 20),
                        MyButton(
                          title: 'ບັນທຶກ',
                          titleColor: Colors.white,
                          height: 60,
                          width: (MediaQuery.of(context).size.width) / 2,
                          buttonColor: Colors.green[800],
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          onPressed:
                              imageFile == null && imageUrl == 'no profile'
                                  ? clearProfile
                                      ? () async {
                                          await uploadImage();
                                        }
                                      : null
                                  : imageFile == null
                                      ? null
                                      : () async {
                                          await uploadImage();
                                        },
                        ),
                        // SizedBox(height: 20),
                        // InkWell(
                        //   child: Text(
                        //     'ລຶບຮູບພາບ',
                        //     style: TextStyle(
                        //       fontFamily: 'NotoSans',
                        //       fontSize: 18,
                        //       color:
                        //           imageFile == null && imageUrl == 'no profile'
                        //               ? Colors.grey
                        //               : Colors.red,
                        //       decoration: TextDecoration.underline,
                        //     ),
                        //   ),
                        //   onTap: imageFile == null && imageUrl == 'no profile'
                        //       ? null
                        //       : () async {
                        //           await clearImage();
                        //         },
                        // ),
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
