import 'package:flutter/material.dart';

class MyMenuCard extends StatelessWidget {
  MyMenuCard({
    this.title,
    this.icon,
    this.iconColor,
    this.onTapped,
  });
  final String title;
  final IconData icon;
  final Color iconColor;
  final Function onTapped;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.cyan[200],
      child: InkWell(
        splashColor: Colors.yellow[500],
        onTap: onTapped,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: MediaQuery.of(context).size.width / 4 - 20,
              color: iconColor,
            ),
            SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(fontFamily: 'NotoSans', fontSize: 20),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

//BookCard......................................................................
class MyBookCard extends StatefulWidget {
  MyBookCard({
    this.bookId,
    this.bookName,
    this.bookGroup,
    this.yearPrint,
    this.author,
    this.totalView,
    this.totalLike,
    this.totalDownload,
    this.likeIcon,
    this.bookmarkIcon,
    this.onBookTap,
    this.onLikePress,
    this.onDownloadPress,
    this.onBookmarkPress,
  });
  final totalView, totalLike, totalDownload;
  final String bookId, bookName, bookGroup, yearPrint;
  final List<String> author;
  final IconData likeIcon, bookmarkIcon;
  final Function onBookTap, onLikePress, onDownloadPress, onBookmarkPress;
  @override
  _MyBookCardState createState() => _MyBookCardState();
}

class _MyBookCardState extends State<MyBookCard> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 3 * (MediaQuery.of(context).size.width) / 4,
      child: Card(
        color: Colors.cyan[50],
        child: InkWell(
          splashColor: Colors.yellow[500],
          onTap: widget.onBookTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    widget.bookName,
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    widget.bookGroup,
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      fontSize: 16,
                      color: Colors.orange[800],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 5),
                      Text(
                        'ຄົ້ນຄວ້າໂດຍ:',
                        style: TextStyle(
                          fontFamily: 'NotoSans',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var i in widget.author)
                            Text(
                              i.toString(),
                              style: TextStyle(
                                fontFamily: 'NotoSans',
                                fontSize: 14,
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 5),
                  Text(
                    'ປີພິມ:',
                    style: TextStyle(
                      fontFamily: 'NotoSans',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 5),
                  Text(
                    widget.yearPrint,
                    style: TextStyle(fontFamily: 'NotoSans', fontSize: 14),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.remove_red_eye_outlined,
                          color: Colors.grey[500],
                          size: 35,
                        ),
                        onPressed: null,
                      ),
                      Text(
                        widget.totalView.toString(),
                        style: TextStyle(fontFamily: 'NotoSans', fontSize: 10),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            widget.likeIcon,
                            color: Colors.lightBlue,
                            size: 30,
                          ),
                          splashColor: Colors.cyan,
                          onPressed: widget.onLikePress),
                      Text(
                        widget.totalLike.toString(),
                        style: TextStyle(fontFamily: 'NotoSans', fontSize: 10),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.arrow_circle_down,
                            color: Colors.lightBlue,
                            size: 30,
                          ),
                          splashColor: Colors.cyan,
                          onPressed: widget.onDownloadPress),
                      Text(
                        widget.totalDownload.toString(),
                        style: TextStyle(fontFamily: 'NotoSans', fontSize: 10),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          widget.bookmarkIcon,
                          color: Colors.lightBlue,
                          size: 35,
                        ),
                        splashColor: Colors.cyan,
                        onPressed: widget.onBookmarkPress,
                      ),
                      // Text(
                      //   '',
                      //   style: TextStyle(fontFamily: 'NotoSans', fontSize: 10),
                      // ),
                    ],
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
