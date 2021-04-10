import 'package:flutter/material.dart';
import 'package:noul_research/class/myTextField.dart';
import 'package:noul_research/class/myButton.dart';
import 'package:noul_research/class/myAppBar.dart';

class Setting extends StatefulWidget {
  static var view = 10, like = 10, download = 10;
  static var txtView = TextEditingController(text: view.toString());
  static var txtLike = TextEditingController(text: like.toString());
  static var txtDownload = TextEditingController(text: download.toString());
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
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
                        'ໃນການຕັ້ງຄ່ານີ້ຜູ້ໃຊ້ຈະເຫັນຈຳນວນບົດຕາມຕາມຕົວເລກທີ່ໄດ້ຕັ້ງໄວ້',
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
                    title: 'ອ່ານບົດຕາມຍອດ view top:',
                    width: 4 * (MediaQuery.of(context).size.width) / 6,
                  ),
                  SizedBox(width: 2),
                  MyTextField(
                    controller: Setting.txtView,
                    width: (MediaQuery.of(context).size.width) / 6,
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyLabelText(
                    title: 'ອ່ານບົດຕາມຍອດ like top:',
                    width: 4 * (MediaQuery.of(context).size.width) / 6,
                  ),
                  SizedBox(width: 2),
                  MyTextField(
                    controller: Setting.txtLike,
                    width: (MediaQuery.of(context).size.width) / 6,
                  )
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyLabelText(
                    title: 'ອ່ານບົດຕາມຍອດ download top:',
                    width: 4 * (MediaQuery.of(context).size.width) / 6,
                  ),
                  SizedBox(width: 2),
                  MyTextField(
                    controller: Setting.txtDownload,
                    width: (MediaQuery.of(context).size.width) / 6,
                  )
                ],
              ),
              SizedBox(height: 30),
              MyButton(
                title: 'ບັນທຶກການຕັ້ງຄ່າ',
                fontSize: 30,
                titleColor: Colors.white,
                buttonColor: Colors.orange,
                height: 65,
                width: (MediaQuery.of(context).size.width) - 12,
                onPressed: () {
                  setState(() {
                    Setting.view = int.parse(Setting.txtView.text);
                    Setting.like = int.parse(Setting.txtLike.text);
                    Setting.download = int.parse(Setting.txtDownload.text);
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
