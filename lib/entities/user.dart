import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String? id;
    String? photo;
    String? username;
    String? email;
    String? password;
    String? createdAt;

    User({
        this.id,
        this.photo,
        this.username,
        this.email,
        this.password,
        this.createdAt,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        photo: json["photo"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        createdAt: json["created_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "photo": photo,
        "username": username,
        "email": email,
        "password": password,
        "created_at": createdAt,
    };
}
