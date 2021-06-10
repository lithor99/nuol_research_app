import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nuol_research/class/myAlertDialog.dart';
import 'package:nuol_research/class/myButton.dart';
import 'package:nuol_research/class/myConnectivity.dart';
import 'package:nuol_research/class/myToast.dart';
import 'package:nuol_research/views/home.dart';
import 'package:http/http.dart' as http;

class UploadProfile extends StatefulWidget {
  final String email;
  UploadProfile(this.email);
  @override
  _UploadProfileState createState() => _UploadProfileState();
}

class _UploadProfileState extends State<UploadProfile> {
  FirebaseStorage storage = FirebaseStorage.instance;
  File imageFile;
  String imageUrl;
  bool isUploading = false;
  final imagePicker = ImagePicker();

  Future<void> imageFromCamera() async {
    try {
      PickedFile imageCamera =
          await imagePicker.getImage(source: ImageSource.camera);
      setState(() {
        imageFile = File(imageCamera.path);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> imageFromGallery() async {
    try {
      PickedFile imageGallery =
          await imagePicker.getImage(source: ImageSource.gallery);
      setState(() {
        imageFile = File(imageGallery.path);
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> saveImageUrl(String profile) async {
    try {
      final url = 'http://192.168.43.191:9000/member/upload_profile';
      Map body = {'email': widget.email, 'profile': profile};
      await http.put(Uri.parse(url), body: body);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> uploadFile() async {
    try {
      await CheckInternet.checkInternet();
      if (CheckInternet.connectivityState == true) {
        setState(() {
          isUploading = true;
        });
        Reference reference = storage
            .ref()
            .child('profiles/${widget.email}_${DateTime.now().toString()}');
        UploadTask uploadTask = reference.putFile(imageFile);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        imageUrl = await taskSnapshot.ref.getDownloadURL();
        await saveImageUrl(imageUrl);
        setState(() {
          isUploading = false;
        });
        await myToast('ການລົງທະບຽນສຳເລັດແລ້ວ');
        Navigator.of(context).pop();
        MaterialPageRoute route = MaterialPageRoute(
          builder: (value) => Home(widget.email),
        );
        Navigator.push(context, route);
      } else {
        myToast('ກະລຸນາກວດເບີ່ງການເຊື່ອມຕໍ່ອິນເຕີເນັດກ່ອນ');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // @override
  // void initState() async {
  //   super.initState();
  //   await Firebase.initializeApp();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Center(
          child: isUploading
              ? SpinKitFadingCircle(color: Colors.blue, size: 100)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CircleAvatar(
                      radius: 180,
                      backgroundImage: imageFile == null
                          ? AssetImage('images/account1.jpg')
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
                            onPressed: () {
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
                            }),
                        SizedBox(height: 20),
                        MyButton(
                          title: 'ບັນທຶກ',
                          titleColor: Colors.white,
                          height: 60,
                          width: (MediaQuery.of(context).size.width) / 2,
                          buttonColor: Colors.green[800],
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          onPressed: imageFile == null
                              ? null
                              : () async {
                                  await uploadFile();
                                },
                        ),
                        SizedBox(height: 20),
                        MyButton(
                          title: 'ຂ້າມໄປກ່ອນ',
                          titleColor: Colors.white,
                          height: 60,
                          width: (MediaQuery.of(context).size.width) / 2,
                          buttonColor: Colors.orange[800],
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          onPressed: () async {
                            await CheckInternet.checkInternet();
                            if (CheckInternet.connectivityState == true) {
                              MaterialPageRoute route = MaterialPageRoute(
                                builder: (value) => Home(widget.email),
                              );
                              Navigator.push(context, route);
                            } else {
                              myToast(
                                'ກະລຸນາກວດເບີ່ງການເຊື່ອມຕໍ່ອິນເຕີເນັດກ່ອນ',
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
