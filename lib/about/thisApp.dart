import 'package:flutter/material.dart';
import 'package:nuol_research/class/myLogo.dart';

class AboutThisApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[100],
      body: Container(
        padding: EdgeInsets.all(0),
        child: ListView(
          children: [
            MyLogo(
              height: MediaQuery.of(context).size.height / 3,
              imgUrl: 'images/NUOL.png',
              leftRadius: 80,
              rightRadius: 80,
              beginColor: Colors.cyan[100],
              endColor: Colors.blue,
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ນັກພັດທະນາ:',
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'ແອັບພລີເຄຊັ່ນອ່ານບົດຄົ້ນຄວ້າຂອງມະຫາວິທະຍາໄລແຫ່ງຊາດ ຖືກພັດທະນາຂຶ້ນໃນສົກສຶກສາ 2020-2021 ໂດຍ: ທ້າວ ລີທໍ່ ເຊ່ຍເຢ້ ແລະ ທ້າວ ຄຳຫຼ້າ ຊີຢີຫວ່າງ ເຊິ່ງເປັນນັກສຶກສາຈາກຄະນະວິທະຍາສາດທຳມະຊາດ, ພາກວິຊາວິທະຍາສາດຄອມພິວເຕີ ພາຍໃຕ້ການນຳພາຂອງ ອຈ.ປອ. ໃຈລາສີ ຍໍພັນໄຊ ແລະ ຊ່ວຍນຳພາໂດຍ ອຈ.ປອ. ສົມສັກ ອິນທະສອນ.',
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: 15,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'ການນຳໃຊ້:',
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'ແອັບພລີເຄຊັ່ນນີ້ແມ່ນພັດທະນາຂຶ້ນເພື່ອການເຂົ້າອ່ານ ແລະ ດາວໂຫຼດບົດຄົ້ນຄວ້າວິໄຈຂອງມະຫາວິທະຍາໄລແຫ່ງຊາດ ເຊິ່ງຜູ້ໃຊ້ຈຳເປັນຕ້ອງໄດ້ໃຊ້ອີເມລແທ້ ຫຼື ອີເມລທີ່ມີຕົວຕົນໃນການສະໝັກສະມາຊິກ.',
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: 15,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
