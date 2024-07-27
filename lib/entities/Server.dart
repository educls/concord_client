import 'dart:convert';

Server serverFromJson(String str) => Server.fromJson(json.decode(str));

String serverToJson(Server data) => json.encode(data.toJson());

class Server {
    String? id;
    String? name;
    String? photo;
    String? ownerId;

    Server({
        this.id,
        this.name,
        this.photo,
        this.ownerId,
    });

    factory Server.fromJson(Map<String, dynamic> json) => Server(
        id: json["id"],
        name: json["name"],
        photo: json["photo"],
        ownerId: json["owner_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "photo": photo,
        "owner_id": ownerId,
    };
}
