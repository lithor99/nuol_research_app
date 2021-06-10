import 'dart:convert';

Register registerFromJson(String str) => Register.fromJson(json.decode(str));

String registerToJson(Register data) => json.encode(data.toJson());

class Register {
  Register({
    this.registId,
    this.username,
    this.email,
    this.password,
  });

  String registId;
  String username;
  String email;
  String password;

  factory Register.fromJson(Map<String, dynamic> json) => Register(
        registId: json["regist_id"] == null ? null : json["regist_id"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        password: json["password"] == null ? null : json["password"],
      );

  Map<String, dynamic> toJson() => {
        "regist_id": registId == null ? null : registId,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "password": password == null ? null : password,
      };
}
