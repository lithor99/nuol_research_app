import 'dart:convert';

GetLike getLikeFromJson(String str) => GetLike.fromJson(json.decode(str));

String getLikeToJson(GetLike data) => json.encode(data.toJson());

class GetLike {
  GetLike({
    this.bookId,
  });

  String bookId;

  factory GetLike.fromJson(Map<String, dynamic> json) => GetLike(
        bookId: json["book_id"] == null ? null : json["book_id"],
      );

  Map<String, dynamic> toJson() => {
        "book_id": bookId == null ? null : bookId,
      };
}
