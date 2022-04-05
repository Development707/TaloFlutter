// ignore_for_file: constant_identifier_names

import 'package:flutter_mobile_chatapp_v4_2/models/react.dart';
import 'package:flutter_mobile_chatapp_v4_2/models/short_user.dart';

enum MessageType { VOTE, TEXT, HTML, NOTIFY, STICKER, VIDEO, FILE, IMAGE }
enum MessageStatus { ERROR, NOT_VIEW, VIEWED }

class LastMessage {
  final String id;
  final ShortUser user;
  final String content;
  final MessageType type;
  final DateTime createdAt;
  final List<ShortUser>? manipulatedUserIds;
  final List<ShortUser>? tags;
  final List<ShortUser>? deletedUserIds;
  final List<React>? reacts;
  final MessageStatus messageStatus;

  LastMessage({
    required this.id,
    required this.user,
    required this.content,
    required this.type,
    required this.createdAt,
    this.manipulatedUserIds,
    this.tags,
    this.deletedUserIds,
    this.reacts,
    this.messageStatus = MessageStatus.VIEWED,
  });

  factory LastMessage.fromJson(Map<String, dynamic>? json) {
    MessageType convertTypeMessage(dynamic status) {
      return MessageType.values.firstWhere(
        (e) => e.toString() == "MessageType." + status,
      );
    }

    return LastMessage(
      id: json!["id"],
      user: ShortUser.fromJson(json["user"]),
      content: json["content"],
      type: convertTypeMessage(json["type"]),
      createdAt: DateTime.parse(json["createdAt"]),
      deletedUserIds: ShortUser.fromJsonArray(json["deletedUserIds"]),
      manipulatedUserIds: ShortUser.fromJsonArray(json["manipulatedUserIds"]),
      reacts: React.fromJsonArray(json["reacts"]),
      tags: ShortUser.fromJsonArray(json["tags"]),
    );
  }

  static List<LastMessage> fromJsonArray(List<dynamic> jsonArray) =>
      List<LastMessage>.from(jsonArray.map((lm) => LastMessage.fromJson(lm)));
}
