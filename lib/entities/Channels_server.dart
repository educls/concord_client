// To parse this JSON data, do
//
//     final channelsServer = channelsServerFromJson(jsonString);

import 'dart:convert';

List<ChannelsServer> channelsServerFromJson(String str) => List<ChannelsServer>.from(json.decode(str).map((x) => ChannelsServer.fromJson(x)));

String channelsServerToJson(List<ChannelsServer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChannelsServer {
    String? id;
    String? name;
    String? serverId;
    int? isVoice;
    String? exp;
    List<UsersConected>? usersConected = [];

    ChannelsServer({
        this.id,
        this.name,
        this.serverId,
        this.isVoice,
        this.exp,
        this.usersConected,
    });

    factory ChannelsServer.fromJson(Map<String, dynamic> json) => ChannelsServer(
        id: json["id"],
        name: json["name"],
        serverId: json["server_id"],
        isVoice: json["is_voice"],
        exp: json["exp"],
        usersConected: json["users_conected"] == null ? [] : List<UsersConected>.from(json["users_conected"]!.map((x) => UsersConected.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "server_id": serverId,
        "is_voice": isVoice,
        "exp": exp,
        "users_conected": usersConected == null ? [] : List<dynamic>.from(usersConected!.map((x) => x.toJson())),
    };
}

class UsersConected {
    String? userId;
    String? username;

    UsersConected({
        this.userId,
        this.username,
    });

    factory UsersConected.fromJson(Map<String, dynamic> json) => UsersConected(
        userId: json["userId"],
        username: json["username"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
    };
}
