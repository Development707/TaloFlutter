// ignore_for_file: constant_identifier_names

import 'package:flutter_mobile_chatapp_v4_2/models/react.dart';
import 'package:flutter_mobile_chatapp_v4_2/models/short_user.dart';

import '../services/json_service.dart';

enum MessageType { VOTE, TEXT, HTML, NOTIFY, STICKER, VIDEO, FILE, IMAGE }
enum MessageStatus { ERROR, NOT_VIEW, VIEWED }

class LastMessage {
  final String id;
  final ShortUser user;
  final String content;
  final MessageType type;
  final DateTime createdAt;
  final List<ShortUser> handledUserIds;
  final List<String> tags;
  final List<String> deletedUserIds;
  final List<React> reacts;
  final MessageStatus messageStatus;
  final String question;
  final List<Option> options;

  LastMessage({
    required this.id,
    required this.user,
    required this.content,
    required this.type,
    required this.createdAt,
    required this.handledUserIds,
    required this.tags,
    required this.deletedUserIds,
    required this.reacts,
    this.messageStatus = MessageStatus.VIEWED,
    required this.question,
    required this.options,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json,
      {MessageStatus status = MessageStatus.VIEWED}) {
    MessageType convertTypeMessage(dynamic type) {
      return MessageType.values.firstWhere(
        (e) => e.toString() == "MessageType." + type,
      );
    }

    return LastMessage(
      handledUserIds: ShortUser.fromJsonArray(json["handledUserIds"]),
      content: json["content"],
      tags: jsonArrayToList(json["tags"]),
      type: convertTypeMessage(json["type"]),
      deletedUserIds: jsonArrayToList(json["deletedUserIds"]),
      reacts: [],
      createdAt: DateTime.parse(json["createdAt"]),
      id: json["id"],
      user: ShortUser.fromJson(json["user"]),
      question: json["question"] ?? "",
      options: Option.fromJsonArray(json["options"] ?? []),
      messageStatus: status,
    );
  }

  static List<LastMessage> fromJsonArray(List<dynamic> jsonArray) =>
      List<LastMessage>.from(jsonArray.map((lm) => LastMessage.fromJson(lm)));
}

class Option {
  final String name;
  final List<ShortUser> userIds;

  Option({
    required this.name,
    required this.userIds,
  });

  factory Option.fromJson(Map<String, dynamic>? json) {
    return Option(
      name: json!["name"],
      userIds: ShortUser.fromJsonArray(json["userIds"]),
    );
  }

  static List<Option> fromJsonArray(List<dynamic> jsonArray) =>
      List<Option>.from(jsonArray.map((op) => Option.fromJson(op)));
}
