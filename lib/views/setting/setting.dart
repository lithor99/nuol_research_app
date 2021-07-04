import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nuol_research/class/myTextField.dart';
import 'package:nuol_research/class/myButton.dart';
import 'package:nuol_research/class/myAppBar.dart';
import 'package:nuol_research/class/myToast.dart';
import 'package:nuol_research/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  TextEditingController txtView;
  TextEditingController txtLike;
  TextEditingController txtDownload;
  Future<void> showTop() async {
    try {
      setState(() {
        txtView = TextEditingController(
            text: preferences.getString('topView') ?? '10');
        txtLike = TextEditingController(
            text: preferences.getString('topLike') ?? '10');
        txtDownload = TextEditingController(
            text: preferences.getString('topDownload') ?? '10');
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  void initState() {
    showTop();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(title: 'ຕັ້ງຄ່າ', fontSize: 20).myAppBar(),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                        'ໃນການຕັ້ງຄ່ານີ້ຜູ້ໃຊ້ຈະເຫັນຈຳນວນບົດຕາມຍອດຕົວເລກທີ່ບັນທຶກໄວ້',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyLabelText(
                    title: 'ຮັບບົດຕາມຍອດການເຂົ້າອ່ານ:',
                    width: 4 * (MediaQuery.of(context).size.width) / 6,
                  ),
                  SizedBox(width: 2),
                  MyTextField(
                    controller: txtView,
                    width: (MediaQuery.of(context).size.width) / 6,
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyLabelText(
                    title: 'ຮັບບົດຕາມຍອດການກົດໄລຄ໌:',
                    width: 4 * (MediaQuery.of(context).size.width) / 6,
                  ),
                  SizedBox(width: 2),
                  MyTextField(
                    controller: txtLike,
                    width: (MediaQuery.of(context).size.width) / 6,
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyLabelText(
                    title: 'ຮັບບົດຕາມຍອດດາວໂຫຼດ:',
                    width: 4 * (MediaQuery.of(context).size.width) / 6,
                  ),
                  SizedBox(width: 2),
                  MyTextField(
                    controller: txtDownload,
                    width: (MediaQuery.of(context).size.width) / 6,
                  )
                ],
              ),
              SizedBox(height: 30),
              MyButton(
                title: 'ບັນທຶກການຕັ້ງຄ່າ',
                fontSize: 30,
                titleColor: Colors.white,
                buttonColor: Colors.blue,
                height: 65,
                width: (MediaQuery.of(context).size.width) - 12,
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  if (txtView.text == null ||
                      txtView.text == '0' ||
                      txtView.text.isEmpty) {
                    setState(() {
                      txtView.text = '10';
                    });
                  }
                  if (txtLike.text == null ||
                      txtLike.text == '0' ||
                      txtLike.text.isEmpty) {
                    setState(() {
                      txtLike.text = '10';
                    });
                  }
                  if (txtDownload.text == null ||
                      txtDownload.text == '0' ||
                      txtDownload.text.isEmpty) {
                    setState(() {
                      txtDownload.text = '10';
                    });
                  }
                  SharedPreferences preferences =
                      await SharedPreferences.getInstance();
                  await preferences.setString('topView', txtView.text);
                  await preferences.setString('topLike', txtLike.text);
                  await preferences.setString('topDownload', txtDownload.text);
                  myToast(
                    'ຕັ້ງຄ່າສຳເລັດແລ້ວ',
                    Colors.black,
                    Toast.LENGTH_SHORT,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
