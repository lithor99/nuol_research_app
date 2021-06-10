// import 'dart:convert';

// List<ViewBook> viewBookFromJson(String str) =>
//     List<ViewBook>.from(json.decode(str).map((x) => ViewBook.fromJson(x)));

// String viewBookToJson(List<ViewBook> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class ViewBook {
//   ViewBook({
//     this.bookId,
//     this.bookName,
//     this.bookGroup,
//     this.yearPrint,
//     this.totalView,
//     this.totalLoad,
//     this.likes,
//   });

//   String bookId;
//   String bookName;
//   String bookGroup;
//   String yearPrint;
//   int totalView;
//   int totalLoad;
//   int likes;

//   factory ViewBook.fromJson(Map<String, dynamic> json) => ViewBook(
//         bookId: json["book_id"] == null ? null : json["book_id"],
//         bookName: json["book_name"] == null ? null : json["book_name"],
//         bookGroup: json["book_group"] == null ? null : json["book_group"],
//         yearPrint: json["year_print"] == null ? null : json["year_print"],
//         totalView: json["total_view"] == null ? null : json["total_view"],
//         totalLoad: json["total_load"] == null ? null : json["total_load"],
//         likes: json["likes"] == null ? null : json["likes"],
//       );

//   Map<String, dynamic> toJson() => {
//         "book_id": bookId == null ? null : bookId,
//         "book_name": bookName == null ? null : bookName,
//         "book_group": bookGroup == null ? null : bookGroup,
//         "year_print": yearPrint == null ? null : yearPrint,
//         "total_view": totalView == null ? null : totalView,
//         "total_load": totalLoad == null ? null : totalLoad,
//         "likes": likes == null ? null : likes,
//       };
// }

import 'dart:convert';

ViewBook viewBookFromJson(String str) => ViewBook.fromJson(json.decode(str));

String viewBookToJson(ViewBook data) => json.encode(data.toJson());

class ViewBook {
  ViewBook({
    this.bookId,
    this.bookName,
    this.bookGroup,
    this.yearPrint,
    this.totalView,
    this.totalLoad,
    this.likes,
  });

  String bookId;
  String bookName;
  String bookGroup;
  String yearPrint;
  int totalView;
  int totalLoad;
  int likes;

  factory ViewBook.fromJson(Map<String, dynamic> json) => ViewBook(
        bookId: json["book_id"] == null ? null : json["book_id"],
        bookName: json["book_name"] == null ? null : json["book_name"],
        bookGroup: json["book_group"] == null ? null : json["book_group"],
        yearPrint: json["year_print"] == null ? null : json["year_print"],
        totalView: json["total_view"] == null ? null : json["total_view"],
        totalLoad: json["total_load"] == null ? null : json["total_load"],
        likes: json["likes"] == null ? null : json["likes"],
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId == null ? null : bookId,
        "book_name": bookName == null ? null : bookName,
        "book_group": bookGroup == null ? null : bookGroup,
        "year_print": yearPrint == null ? null : yearPrint,
        "total_view": totalView == null ? null : totalView,
        "total_load": totalLoad == null ? null : totalLoad,
        "likes": likes == null ? null : likes,
      };
}
