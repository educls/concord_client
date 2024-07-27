// To parse this JSON data, do
//
//     final usersOnChannel = usersOnChannelFromJson(jsonString);

import 'dart:convert';

List<UsersOnChannel> usersOnChannelFromJson(String str) => List<UsersOnChannel>.from(json.decode(str).map((x) => UsersOnChannel.fromJson(x)));

String usersOnChannelToJson(List<UsersOnChannel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UsersOnChannel {
    String? id;
    String? username;

    UsersOnChannel({
        this.id,
        this.username,
    });

    factory UsersOnChannel.fromJson(Map<String, dynamic> json) => UsersOnChannel(
        id: json["id"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
    };
}
