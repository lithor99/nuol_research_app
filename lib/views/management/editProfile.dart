import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuol_research/class/myAlertDialog.dart';
import 'package:nuol_research/class/myAppBar.dart';
import 'package:nuol_research/class/myButton.dart';
import 'package:nuol_research/class/myConnectivity.dart';
import 'package:nuol_research/class/myToast.dart';
import 'package:nuol_research/views/home.dart';
import 'package:http/http.dart' as http;

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
    final url = 'http://192.168.43.191:9000/member/upload_profile';
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
          myToast('ປ່ຽນຮູບໜ້າປົກສຳເລັດແລ້ວ');
        }
      } else {
        myToast('ກະລຸນາກວດເບີ່ງການເຊື່ອມຕໍ່ອິນເຕີເນັດກ່ອນ');
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
          padding: EdgeInsets.all(5),
          child: Center(
            child: isChanging
                ? SpinKitFadingCircle(color: Colors.blue, size: 100)
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CircleAvatar(
                        radius: 180,
                        backgroundImage: Home.data == null
                            ? AssetImage('images/profile1.png')
                            : imageUrl == 'no profile' && imageFile == null
                                ? AssetImage('images/profile1.png')
                                : imageFile == null
                                    ? NetworkImage(imageUrl)
                                    : FileImage(imageFile),
                      ),
                      SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                                : () {
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
                          SizedBox(height: 20),
                          MyButton(
                            title: 'ລຶບຮູບພາບ',
                            titleColor: Colors.white,
                            height: 60,
                            width: (MediaQuery.of(context).size.width) / 2,
                            buttonColor: Colors.orange[800],
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                            onPressed: imageFile == null
                                ? null
                                : () async {
                                    await clearImage();
                                  },
                          ),
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
                        ],
                      )
                    ],
                  ),
          )),
    );
  }
}
