import 'package:flutter_mobile_chatapp_v4_2/models/avatar.dart';
import 'package:flutter_mobile_chatapp_v4_2/models/short_user.dart';

import 'last_message.dart';

class Conversation {
  final String id;
  final String name;
  final String type;
  final Avatar avatar;
  final String leaderId;
  final List<ShortUser> members;
  final int totalMembers;
  final int numberUnread;
  final bool isNotify;
  final bool isJoinFromLink;
  LastMessage? lastMessage;
  final List<String> managerIds;

  Conversation({
    required this.id,
    required this.name,
    required this.avatar,
    required this.type,
    required this.members,
    required this.totalMembers,
    required this.numberUnread,
    required this.isNotify,
    required this.isJoinFromLink,
    this.lastMessage,
    required this.leaderId,
    required this.managerIds,
  });

  // Json - Object
  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json["id"],
      name: json["name"],
      avatar: Avatar.fromJson(json["avatar"]),
      type: json["type"],
      members: ShortUser.fromJsonArray(json["members"]),
      totalMembers: json["totalMembers"],
      numberUnread: json["numberUnread"],
      isNotify: json["isNotify"],
      isJoinFromLink: json["isJoinFromLink"],
      lastMessage: json["lastMessage"] != null
          ? LastMessage.fromJson(json["lastMessage"])
          : null,
      leaderId: json["leaderId"] ?? "",
      managerIds: [],
    );
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "avatar": avatar.toJson(),
        "members": members
      };
  static List<Conversation> listFromJsonArray(List<dynamic> list) =>
      List<Conversation>.from(list.map((con) => Conversation.fromJson(con)));
}
