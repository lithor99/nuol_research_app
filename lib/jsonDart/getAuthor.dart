import 'dart:convert';

GetAuthor getAuthorFromJson(String str) => GetAuthor.fromJson(json.decode(str));

String getMemberToJson(GetAuthor data) => json.encode(data.toJson());

class GetAuthor {
  GetAuthor({
    this.author,
  });

  String author;

  factory GetAuthor.fromJson(Map<String, dynamic> json) => GetAuthor(
        author: json["author"] == null ? null : json["author"],
      );

  Map<String, dynamic> toJson() => {
        "author": author == null ? null : author,
      };
}
