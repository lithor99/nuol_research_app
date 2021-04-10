import 'package:flutter/material.dart';
import 'package:noul_research/class/myAppBar.dart';
import 'package:noul_research/class/myCard.dart';
import 'package:noul_research/class/myAlertDialog.dart';
import 'package:noul_research/views/books/viewBook.dart';
import 'package:noul_research/views/setting/setting.dart';

class BookAsLike extends StatefulWidget {
  @override
  _BookAsLikeState createState() => _BookAsLikeState();
}

class _BookAsLikeState extends State<BookAsLike> {
  List<String> bookName = [
        'ຊື່ບົດຄົ້ນຄວ້າ1',
        'ຊື່ບົດຄົ້ນຄວ້າ2',
        'ຊື່ບົດຄົ້ນຄວ້າ3',
        'ຊື່ບົດຄົ້ນຄວ້າ4',
        'ຊື່ບົດຄົ້ນຄວ້າ5'
      ],
      bookGroup = [
        'ສາຍທຳມະຊາດ',
        'ສາຍສັງຄົມ',
        'ສາຍທຳມະຊາດ',
        'ສາຍທຳມະຊາດ',
        'ສາຍສັງຄົມ'
      ],
      yearPrint = ['2020', '2020', '2021', '2019', '2020'];
  List<List<String>> author = [
    ['1', '2'],
    ['1', '2'],
    ['1'],
    ['1', '2', '3'],
    ['1']
  ];
  List<int> bookId = [1, 2, 3, 4, 5],
      totalView = [1, 2, 3, 4, 5],
      totalLike = [1, 2, 3, 4, 5],
      totalDownload = [1, 2, 3, 4, 5];
  List<bool> isLike = [false, false, false, false, false],
      isBookmark = [false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'ບົດທີ່ມີຍອດ like Top: ' + Setting.like.toString(),
        fontSize: 20,
        onActionPress: () {},
      ).myAppBar(),
      body: Container(
        color: Colors.cyan[500],
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ListView(
            children: [
              for (int i = 0; i < bookId.length; i++)
                MyBookCard(
                  bookId: bookId[i],
                  bookName: bookName[i],
                  bookGroup: bookGroup[i],
                  author: author[i],
                  yearPrint: yearPrint[i],
                  totalView: totalView[i],
                  totalLike: totalLike[i],
                  totalDownload: totalDownload[i],
                  likeIcon: isLike[i]
                      ? Icons.thumb_up_alt_rounded
                      : Icons.thumb_up_outlined,
                  bookmarkIcon:
                      isBookmark[i] ? Icons.star_outlined : Icons.star_outline,
                  onBookTap: () {
                    setState(() {
                      totalView[i] = totalView[i] + 1;
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (value) => ViewPDF(),
                      );
                      Navigator.push(context, route);
                    });
                  },
                  onLikePress: () {
                    setState(() {
                      isLike[i] = !isLike[i];
                      if (isLike[i] == true) {
                        totalLike[i] = totalLike[i] + 1;
                      } else {
                        totalLike[i] = totalLike[i] - 1;
                      }
                    });
                  },
                  onDownloadPress: () {
                    MyAlertDialog(
                      title: 'ການດາວໂຫຼດ!',
                      content: 'ທ່ານຕ້ອງການດາວໂຫຼດແທ້ບໍ?',
                      onCancelPress: () async {
                        Navigator.of(context).pop();
                      },
                      onOkayPress: () async {
                        setState(() {
                          totalDownload[i] = totalDownload[i] + 1;
                          Navigator.of(context).pop();
                        });
                      },
                    ).showDialogBox(context);
                  },
                  onBookmarkPress: () {
                    setState(() {
                      isBookmark[i] = !isBookmark[i];
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
