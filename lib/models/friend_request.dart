import 'package:flutter_mobile_chatapp_v4_2/models/avatar.dart';

class FriendRequest {
  final String id;
  final String name;
  final String message;
  final Avatar avatar;
  final int numberMutualGroup;
  final int numberMutualFriend;

  FriendRequest({
    required this.id,
    required this.name,
    required this.message,
    required this.avatar,
    required this.numberMutualGroup,
    required this.numberMutualFriend,
  });

  factory FriendRequest.fromJson(Map<String, dynamic> json) {
    return FriendRequest(
      id: json["id"],
      name: json["name"],
      message: json["message"],
      avatar: Avatar.fromJson(json["avatar"]),
      numberMutualGroup: json["numberMutualGroup"],
      numberMutualFriend: json["numberMutualFriend"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar": avatar.toJson(),
        "numberMutualGroup": numberMutualGroup,
        "numberMutualFriend": numberMutualFriend,
      };

  static List<FriendRequest> listFromJsonArray(List<dynamic> jsonArray) =>
      List<FriendRequest>.from(
          jsonArray.map((rq) => FriendRequest.fromJson(rq)));
}
