import 'package:flutter/material.dart';
import 'package:nuol_research/class/downloadFile.dart';
import 'package:nuol_research/class/myAppBar.dart';
import 'package:nuol_research/class/myCard.dart';
import 'package:nuol_research/class/myAlertDialog.dart';
import 'package:nuol_research/class/viewBookFile.dart';
import 'package:nuol_research/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:permission_handler/permission_handler.dart';

class BookAsLike extends StatefulWidget {
  final String memberId;
  BookAsLike(this.memberId);
  @override
  _BookAsLikeState createState() => _BookAsLikeState();
}

class _BookAsLikeState extends State<BookAsLike> {
  String bookUrl;
  List<String> searchs = [];
  List<String> bookIds = [];
  List<String> bookNames = [];
  List<String> bookGroups = [];
  List<String> yearPrints = [];
  List<String> likes = [];
  List<String> bookmarks = [];
  List<List<String>> authors = [];
  List<int> totalViews = [], totalLikes = [], totalDownloads = [];
  List<bool> isLikes = [];
  List<bool> isBookmarks = [];

  Future<void> getBookAsLike() async {
    try {
      // preferences = await SharedPreferences.getInstance();
      final url = serverName + '/book/view_as_like';
      Map body = {'top': preferences.getString('topLike')};
      var res = await http.post(
        Uri.parse(url),
        body: body,
      );
      var data = json.decode(res.body);
      if (data != '{error}') {
        bookIds = [];
        bookNames = [];
        bookGroups = [];
        authors = [];
        yearPrints = [];
        totalViews = [];
        totalLikes = [];
        totalDownloads = [];
        likes = [];
        isLikes = [];
        bookmarks = [];
        isBookmarks = [];
        await getLike();
        await getBookmark();
        for (int i = 0; i < int.parse(data.length.toString()); i++) {
          bookIds.add(data[i]['book_id'].toString());
          bookNames.add(data[i]['book_name'].toString());
          bookGroups.add(data[i]['book_group'].toString());
          yearPrints.add(data[i]['year_print'].toString());
          totalViews.add(int.parse(data[i]['total_view'].toString()));
          totalLikes.add(int.parse(data[i]['total_like'].toString()));
          totalDownloads.add(int.parse(data[i]['total_load'].toString()));
          await getAuthor(bookIds[i], i);
          await showLike(bookIds[i], i);
          await showBookmork(bookIds[i], i);
        }
        print('data:' + data.toString());
      }
    } catch (e) {
      print('book error:' + e.toString());
    }
  }

  Future<void> getAuthor(String bookId, int index) async {
    try {
      final url = serverName + '/book/get_author';
      Map body = {'book_id': bookId};
      var res = await http.post(Uri.parse(url), body: body);
      var data = json.decode(res.body);
      if (data != '{error}') {
        authors.add([]);
        for (int x = 0; x < int.parse(data.length.toString()); x++) {
          authors[index].add(data[x]['author'].toString());
        }
        print('author:' + authors.toString());
      }
    } catch (e) {
      print('author error:' + e.toString());
    }
  }

  Future<void> like(String bookId) async {
    try {
      final url = serverName + '/book/like';
      Map body = {'member_id': widget.memberId, 'book_id': bookId};
      await http.post(Uri.parse(url), body: body);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> dislike(String bookId) async {
    try {
      final url = serverName + '/book/dislike';
      Map body = {'member_id': widget.memberId, 'book_id': bookId};
      await http.post(Uri.parse(url), body: body);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getLike() async {
    try {
      final url = serverName + '/book/get_like';
      Map body = {'member_id': widget.memberId};
      var res = await http.post(Uri.parse(url), body: body);
      var data = json.decode(res.body);
      if (data != '{error}') {
        for (int x = 0; x < data.length; x++) {
          likes.add(data[x]['book_id'].toString());
        }
      }
    } catch (e) {
      print('get like error:' + e.toString());
    }
  }

  Future<void> showLike(String bookId, int index) async {
    try {
      isLikes.insert(index, false);
      for (int x = 0; x < likes.length; x++) {
        if (bookIds[index] == likes[x]) {
          isLikes.removeAt(index);
          isLikes.insert(index, true);
          break;
        }
      }
    } catch (e) {
      print('show like error:' + e.toString());
    }
  }

  Future<void> bookmark(String bookId) async {
    try {
      final url = serverName + '/book/bookmark';
      Map body = {'member_id': widget.memberId, 'book_id': bookId};
      await http.post(Uri.parse(url), body: body);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> unbookmark(String bookId) async {
    try {
      final url = serverName + '/book/unbookmark';
      Map body = {'member_id': widget.memberId, 'book_id': bookId};
      await http.post(Uri.parse(url), body: body);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> getBookmark() async {
    try {
      final url = serverName + '/book/get_bookmark';
      Map body = {'member_id': widget.memberId};
      var res = await http.post(Uri.parse(url), body: body);
      var data = json.decode(res.body);
      if (data != '{error}') {
        for (int x = 0; x < data.length; x++) {
          bookmarks.add(data[x]['book_id'].toString());
        }
      }
      print('bookmarks:' + bookmarks.toString());
    } catch (e) {
      print('get like error:' + e.toString());
    }
  }

  Future<void> showBookmork(String bookId, int index) async {
    try {
      isBookmarks.insert(index, false);
      for (int x = 0; x < bookmarks.length; x++) {
        if (bookIds[index] == bookmarks[x]) {
          isBookmarks.removeAt(index);
          isBookmarks.insert(index, true);
          break;
        }
      }
    } catch (e) {
      print('show like error:' + e.toString());
    }
  }

  Future<void> getBookFile(String bookId) async {
    try {
      final url = serverName + '/book/get_book_file';
      Map body = {'book_id': bookId};
      var res = await http.post(Uri.parse(url), body: body);
      var data = json.decode(res.body);
      bookUrl = null;
      setState(() {
        bookUrl = data['book_file'].toString();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'ບົດທີ່ມີຍອດໄລຄ໌' +
            preferences.getString('topLike') +
            'ອັນດັບທຳອິດ',
        fontSize: 20,
      ).myAppBar(),
      body: Container(
        color: Colors.cyan[500],
        child: Padding(
          padding: EdgeInsets.all(5),
          child: FutureBuilder(
            future: getBookAsLike(),
            builder: (context, snapshot) => bookIds.length <= 0
                ? Center(
                    child: Text(
                      'ບໍ່ມີຂໍ້ມູນ',
                      style: TextStyle(fontFamily: 'NotoSans', fontSize: 20),
                    ),
                  )
                : ListView(
                    children: [
                      for (int i = 0; i < bookIds.length; i++)
                        MyBookCard(
                          bookId: bookIds[i],
                          bookName: bookNames[i],
                          bookGroup: bookGroups[i],
                          author: authors[i],
                          yearPrint: yearPrints[i],
                          totalView: totalViews[i],
                          totalLike: totalLikes[i],
                          totalDownload: totalDownloads[i],
                          likeIcon: isLikes[i]
                              ? Icons.thumb_up_alt_rounded
                              : Icons.thumb_up_outlined,
                          bookmarkIcon: isBookmarks[i]
                              ? Icons.star_outlined
                              : Icons.star_outline,
                          onBookTap: () async {
                            await getBookFile(bookIds[i]);
                            MaterialPageRoute route = MaterialPageRoute(
                              builder: (value) => ViewBookFile(
                                  bookIds[i], bookNames[i], bookUrl),
                            );
                            await Navigator.push(context, route);
                            setState(() {});
                          },
                          onLikePress: () async {
                            if (isLikes[i] == false) {
                              await like(bookIds[i]);
                              setState(() {
                                isLikes[i] = !isLikes[i];
                              });
                            } else {
                              await dislike(bookIds[i]);
                              setState(() {
                                isLikes[i] = !isLikes[i];
                              });
                            }
                          },
                          onDownloadPress: () async {
                            final status = await Permission.storage.request();
                            if (status.isGranted) {
                              MyAlertDialog(
                                title: 'ການດາວໂຫຼດ!',
                                content: 'ທ່ານຕ້ອງການດາວໂຫຼດແທ້ບໍ?',
                                cancelColor: Colors.red,
                                okColor: Colors.blue,
                                onCancel: () async {
                                  Navigator.of(context).pop();
                                },
                                onOkay: () async {
                                  Navigator.of(context).pop();
                                  await getBookFile(bookIds[i]);
                                  await DownloadBookFile.downloadBookFile(
                                    bookIds[i],
                                    bookUrl,
                                    bookNames[i],
                                  );
                                },
                              ).showDialogBox(context);
                            } else {
                              print('no permission');
                            }
                          },
                          onBookmarkPress: () async {
                            if (isBookmarks[i] == false) {
                              await bookmark(bookIds[i]);
                              setState(() {
                                isBookmarks[i] = !isBookmarks[i];
                              });
                            } else {
                              await unbookmark(bookIds[i]);
                              setState(() {
                                isBookmarks[i] = !isBookmarks[i];
                              });
                            }
                          },
                        ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
