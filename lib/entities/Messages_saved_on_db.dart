// To parse this JSON data, do
//
//     final messageSavedOnDb = messageSavedOnDbFromJson(jsonString);

import 'dart:convert';

List<MessageSavedOnDb> messageSavedOnDbFromJson(String str) => List<MessageSavedOnDb>.from(json.decode(str).map((x) => MessageSavedOnDb.fromJson(x)));

String messageSavedOnDbToJson(List<MessageSavedOnDb> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MessageSavedOnDb {
    String? id;
    String? content;
    String? userId;
    String? serverId;
    DateTime? createdAt;

    MessageSavedOnDb({
        this.id,
        this.content,
        this.userId,
        this.serverId,
        this.createdAt,
    });

    factory MessageSavedOnDb.fromJson(Map<String, dynamic> json) => MessageSavedOnDb(
        id: json["id"],
        content: json["content"],
        userId: json["user_id"],
        serverId: json["server_id"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "content": content,
        "user_id": userId,
        "server_id": serverId,
        "created_at": createdAt?.toIso8601String(),
    };
}
