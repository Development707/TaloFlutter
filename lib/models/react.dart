import 'package:flutter_mobile_chatapp_v4_2/models/short_user.dart';

class React {
  final ShortUser userId;
  final String type;

  React({required this.userId, required this.type});

  factory React.fromJson(Map<String, dynamic> json) {
    return React(
      userId: ShortUser.fromJson(json["userId"]),
      type: json["name"],
    );
  }

  static List<React> fromJsonArray(List<dynamic> jsonArray) =>
      List<React>.from(jsonArray.map((r) => React.fromJson(r)));
}
