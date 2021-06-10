import 'dart:convert';

GetMember getMemberFromJson(String str) => GetMember.fromJson(json.decode(str));

String getMemberToJson(GetMember data) => json.encode(data.toJson());

class GetMember {
  GetMember({
    this.memberId,
    this.username,
    this.email,
    this.password,
    this.confNum,
    this.registId,
    this.banState,
  });

  String memberId;
  String username;
  String email;
  String password;
  String confNum;
  String registId;
  bool banState;

  factory GetMember.fromJson(Map<String, dynamic> json) => GetMember(
        memberId: json["member_id"] == null ? null : json["member_id"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
        confNum: json["conf_num"] == null ? null : json["conf_num"],
        registId: json["regist_id"] == null ? null : json["regist_id"],
        banState: json["ban_state"] == null ? null : json["ban_state"],
      );

  Map<String, dynamic> toJson() => {
        "member_id": memberId == null ? null : memberId,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
        "conf_num": confNum == null ? null : confNum,
        "regist_id": registId == null ? null : registId,
        "ban_state": banState == null ? null : banState,
      };
}
