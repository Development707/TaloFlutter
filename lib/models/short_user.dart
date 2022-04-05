import 'package:flutter_mobile_chatapp_v4_2/models/avatar.dart';

class ShortUser {
  final String id;
  final String name;
  final Avatar avatar;

  ShortUser({required this.id, required this.name, required this.avatar});

  factory ShortUser.fromJson(Map<String, dynamic> json) {
    return ShortUser(
      id: json["id"],
      name: json["name"],
      avatar: Avatar.fromJson(json["avatar"]),
    );
  }

  static List<ShortUser> fromJsonArray(List<dynamic> jsonArray) =>
      List<ShortUser>.from(jsonArray.map((user) => ShortUser.fromJson(user)));
}
