import 'package:flutter/material.dart';
import 'package:nuol_research/class/myLogo.dart';

class AboutThisOfficial extends StatelessWidget {
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
              endColor: Colors.green,
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ແນະນຳກ່ຽວກັບຫ້ອງການ:',
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    'ຫ້ອງການຄົ້ນຄວ້າວິທະຍາສາດ ແລະ ບໍລິການວິຊາການ (ຂຽນຫຍໍ້ວ່າ ຫຄບ) ເປັນຫ້ອງການໜຶ່ງຂອງມະຫາວິທະຍາໄລແຫ່ງຊາດມີຖານະທຽບເທົ່າຫ້ອງການອື່ນໆທີ່ຂຶ້ນກັບມະຫາວິທະຍາໄລແຫ່ງຊາດ ເຊິ່ງມີພາລະບົດບາດດໍາເນີນການຄົ້ນຄວ້າວິທະຍາສາດ, ດໍາເນີນການສອນ ແລະ ເຝິກອົບຮົມ, ເປັນເສນາທິການໃຫ້ອະທິການບໍດີ ມຊ ໃນວຽກງານຄຸ້ມຄອງການຄົ້ນຄວ້າວິທະຍາສາດ ແລະ ວາລະສານ, ວຽກງານການບໍລິການວິຊາການ, ວຽກງານການຄຸ້ມຄອງຊັບສິນທາງປັນຍາ, ວຽກງານແຜນການ - ການຮ່ວມມືກ່ຽວກັບການຄົ້ນຄວ້າວິທະຍາສາດ ແລະ ບໍລິການວິຊາການ, ຊີ້ນໍາ ແລະ ຄຸ້ມຄອງວຽກງານສູນຄົ້ນຄວ້າກ່ຽວກັບຈີນ, ວຽກງານສູນຄວາມເປັນເລີດທາງດ້ານສິ່ງແວດລ້ອມ ແລະ ສູນຄົ້ນຄວ້າອື່ນໆຂອງມະຫາວິທະຍາໄລແຫ່ງຊາດ, ຫ້ອງການຄົ້ນຄວ້າວິທະຍາສາດ ແລະ ບໍລິການວິຊາການ ປະກອບມີ 4 ພະແນກ ແລະ 2 ສູນຄື: ພະແນກຄຸ້ມຄອງການຄົ້ນຄວ້າວິທະຍາສາດ ແລະ ວາລະສານ, ພະແນກບໍລິການວິຊາການ, ພະແນກແຜນການ ແລະ ການຮ່ວມມື, ພະແນກຄຸ້ມຄອງຊັບສິນທາງປັນຍາ, ສູນຄົ້ນຄວ້າຈີນ ແລະ ສູນດີເລີດທາງດ້ານສິ່ງແວດລ້ອມມະຫາວິທະຍາໄລແຫ່ງຊາດ.',
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                    ),
                    maxLines: 30,
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
