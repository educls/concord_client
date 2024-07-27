// To parse this JSON data, do
//
//     final userServerOnline = userServerOnlineFromJson(jsonString);

import 'dart:convert';

List<UserServerOnline> userServerOnlineFromJson(String str) => List<UserServerOnline>.from(json.decode(str).map((x) => UserServerOnline.fromJson(x)));

String userServerOnlineToJson(List<UserServerOnline> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserServerOnline {
    String? id;
    String? username;
    String? photo;

    UserServerOnline({
        this.id,
        this.username,
        this.photo,
    });

    factory UserServerOnline.fromJson(Map<String, dynamic> json) => UserServerOnline(
        id: json["id"],
        username: json["username"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "photo": photo,
    };
}
