import 'package:flutter/material.dart';
import 'package:nuol_research/class/downloadFile.dart';
import 'package:nuol_research/class/myAppBar.dart';
import 'package:nuol_research/class/myCard.dart';
import 'package:nuol_research/class/myAlertDialog.dart';
import 'package:nuol_research/class/viewBookFile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BookAsAll extends StatefulWidget {
  BookAsAll(this.memberId);
  final String memberId;
  @override
  _BookAsAllState createState() => _BookAsAllState();
}

class _BookAsAllState extends State<BookAsAll> {
  bool isSearch = false;
  bool hasSearchingText = false;
  TextEditingController searchController = TextEditingController();
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

  Future<void> getBookAsAll() async {
    try {
      final url = 'http://192.168.43.191:9000/book/view_as_all';
      var res = await http.post(Uri.parse(url));
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
      }
    } catch (e) {
      print('book error:' + e.toString());
    }
  }

  Future<void> getBookAsSearch() async {
    try {
      final url = 'http://192.168.43.191:9000/book/view_as_search';
      Map body = {'search': searchController.text};
      var res = await http.post(Uri.parse(url), body: body);
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
      }
    } catch (e) {
      print('book error:' + e.toString());
    }
  }

  Future<void> onSearching() {
    try {
      if (searchController.text == null || searchController.text.isEmpty) {
        setState(() {
          hasSearchingText = false;
        });
      } else {
        setState(() async {
          hasSearchingText = true;
        });
      }
    } catch (e) {
      print('seaching error:' + e.toString());
    }
    return null;
  }

  Future<void> getAuthor(String bookId, int index) async {
    try {
      final url = 'http://192.168.43.191:9000/book/get_author';
      Map body = {'book_id': bookId};
      var res = await http.post(Uri.parse(url), body: body);
      var data = json.decode(res.body);

      if (data != '{error}') {
        authors.add([]);
        for (int x = 0; x < int.parse(data.length.toString()); x++) {
          authors[index].add(data[x]['author'].toString());
        }
      }
    } catch (e) {
      print('author error:' + e.toString());
    }
  }

  Future<void> like(String bookId) async {
    try {
      final url = 'http://192.168.43.191:9000/book/like';
      Map body = {'member_id': widget.memberId, 'book_id': bookId};
      await http.post(Uri.parse(url), body: body);
    } catch (e) {
      print('like error:' + e.toString());
    }
  }

  Future<void> dislike(String bookId) async {
    try {
      final url = 'http://192.168.43.191:9000/book/dislike';
      Map body = {'member_id': widget.memberId, 'book_id': bookId};
      await http.post(Uri.parse(url), body: body);
    } catch (e) {
      print('dislike error:' + e.toString());
    }
  }

  Future<void> getLike() async {
    try {
      final url = 'http://192.168.43.191:9000/book/get_like';
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
      final url = 'http://192.168.43.191:9000/book/bookmark';
      Map body = {'member_id': widget.memberId, 'book_id': bookId};
      await http.post(Uri.parse(url), body: body);
    } catch (e) {
      print('bookmark error:' + e.toString());
    }
  }

  Future<void> unbookmark(String bookId) async {
    try {
      final url = 'http://192.168.43.191:9000/book/unbookmark';
      Map body = {'member_id': widget.memberId, 'book_id': bookId};
      await http.post(Uri.parse(url), body: body);
    } catch (e) {
      print('unbookmark error:' + e.toString());
    }
  }

  Future<void> getBookmark() async {
    try {
      final url = 'http://192.168.43.191:9000/book/get_bookmark';
      Map body = {'member_id': widget.memberId};
      var res = await http.post(Uri.parse(url), body: body);
      var data = json.decode(res.body);

      if (data != '{error}') {
        for (int x = 0; x < data.length; x++) {
          bookmarks.add(data[x]['book_id'].toString());
        }
      }
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
      final url = 'http://192.168.43.191:9000/book/get_book_file';
      Map body = {'book_id': bookId};
      var res = await http.post(Uri.parse(url), body: body);
      var data = json.decode(res.body);
      if (data != '{error}') {
        setState(() {
          bookUrl = data['book_file'].toString();
        });
      }
    } catch (e) {
      print('view book file error:' + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'ບົດຄົ້ນຄວ້າທັງໝົດ',
        fontSize: 20,
        controller: searchController,
        isSearch: isSearch,
        onSearchState: () {
          setState(() {
            isSearch = true;
          });
        },
        onClear: () {
          setState(() {
            searchController.clear();
            isSearch = true;
            hasSearchingText = false;
          });
        },
        onSearchData: () {
          FocusScope.of(context).unfocus();
          if (searchController.text == null || searchController.text.isEmpty) {
            setState(() {
              hasSearchingText = false;
            });
          } else {
            setState(() {
              hasSearchingText = true;
            });
          }
        },
        onSubmitted: (value) {
          FocusScope.of(context).unfocus();
          if (searchController.text == null || searchController.text.isEmpty) {
            setState(() {
              hasSearchingText = false;
            });
          } else {
            setState(() {
              hasSearchingText = true;
            });
          }
        },
        onCancel: () {
          setState(() {
            searchController.clear();
            isSearch = false;
            hasSearchingText = false;
          });
        },
      ).myAppBarSearch(context),
      body: Container(
        color: Colors.cyan[500],
        child: Padding(
          padding: EdgeInsets.all(5),
          child: FutureBuilder(
            future: hasSearchingText ? getBookAsSearch() : getBookAsAll(),
            builder: (context, snapshot) => ListView(
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
                        builder: (value) =>
                            ViewBookFile(bookIds[i], bookNames[i], bookUrl),
                      );
                      Navigator.push(context, route);
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
                      MyAlertDialog(
                        title: 'ການດາວໂຫຼດ!',
                        content: 'ທ່ານຕ້ອງການດາວໂຫຼດແທ້ບໍ?',
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
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text(
                          //       'ດາວໂຫຼດໄຟລ໌ສຳເລັດແລ້ວ',
                          //       textAlign: TextAlign.center,
                          //     ),
                          //     duration: const Duration(seconds: 1),
                          //   ),
                          // );
                        },
                      ).showDialogBox(context);
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
