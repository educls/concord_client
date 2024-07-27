import 'dart:convert';

List<UserServer> userServerFromJson(String str) => List<UserServer>.from(json.decode(str).map((x) => UserServer.fromJson(x)));

String userServerToJson(List<UserServer> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserServer {
    String? userId;
    String? photo;
    String? username;
    String? role;

    UserServer({
        this.userId,
         this.photo,
        this.username,
        this.role,
    });

    factory UserServer.fromJson(Map<String, dynamic> json) => UserServer(
        userId: json["user_id"],
        photo: json["photo"],
        username: json["username"],
        role: json["role"],
    );

    Map<String, dynamic> toJson() => {
        "user_id": userId,
        "photo": photo,
        "username": username,
        "role": role,
    };
}
