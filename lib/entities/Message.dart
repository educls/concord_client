// To parse this JSON data, do
//
//     final messageWebSocket = messageWebSocketFromJson(jsonString);

import 'dart:convert';

MessageWebSocket messageWebSocketFromJson(String str) => MessageWebSocket.fromJson(json.decode(str));

String messageWebSocketToJson(MessageWebSocket data) => json.encode(data.toJson());

class MessageWebSocket {
    String? event;
    String? text;
    String? sender;
    String? receiver;
    String? timestamp;

    MessageWebSocket({
        this.event,
        this.text,
        this.sender,
        this.receiver,
        this.timestamp,
    });

    factory MessageWebSocket.fromJson(Map<String, dynamic> json) => MessageWebSocket(
        event: json["event"],
        text: json["text"],
        sender: json["sender"],
        receiver: json["receiver"],
        timestamp: json["timestamp"],
    );

    Map<String, dynamic> toJson() => {
        "event": event,
        "text": text,
        "sender": sender,
        "receiver": receiver,
        "timestamp": timestamp,
    };
}
