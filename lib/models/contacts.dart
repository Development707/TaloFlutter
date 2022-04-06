// ignore_for_file: constant_identifier_names

import 'package:flutter_mobile_chatapp_v4_2/models/avatar.dart';
import 'package:flutter_mobile_chatapp_v4_2/models/date_of_birth.dart';

enum TypeStatus { FRIEND, FOLLOWER, FOLLOWING, NOT_FRIEND }

class Contacts {
  final String name;
  final String phone;
  final bool isExists;
  final TypeStatus status;
  final int numberMutualGroup;
  final int numberMutualFriend;
  final String id;
  final Avatar avatar;
  final Avatar coverPhoto;
  final DateOfBirth dateOfBirth;
  final bool gender;

  String convertTypeStatus() {
    switch (status) {
      case TypeStatus.FRIEND:
        return "Friend";
      case TypeStatus.FOLLOWER:
        return "Friend invitation request";
      case TypeStatus.FOLLOWING:
        return "Friend request";
      default:
        return "Stranger";
    }
  }

  Contacts({
    required this.name,
    required this.phone,
    required this.isExists,
    required this.dateOfBirth,
    required this.avatar,
    required this.coverPhoto,
    this.status = TypeStatus.NOT_FRIEND,
    this.numberMutualGroup = 0,
    this.numberMutualFriend = 0,
    this.id = "",
    this.gender = true,
  });

  factory Contacts.fromJson(Map<String, dynamic> json) {
    TypeStatus convertTypeStatus(dynamic status) {
      return TypeStatus.values.firstWhere(
        (e) => e.toString() == "TypeStatus." + status,
      );
    }

    if (json["isExists"]) {
      return Contacts(
        name: json["name"],
        phone: json["phone"],
        isExists: json["isExists"],
        status: convertTypeStatus(json["status"]),
        numberMutualGroup: json["numberMutualGroup"],
        numberMutualFriend: json["numberMutualFriend"],
        id: json["id"],
        avatar: Avatar.fromJson(json["avatar"]),
        coverPhoto: Avatar.fromJson(json["coverPhoto"]),
        dateOfBirth: DateOfBirth.fromJson(json["dateOfBirth"]),
        gender: json["gender"],
      );
    } else {
      return Contacts(
        name: json["name"],
        phone: json["phone"],
        isExists: json["isExists"],
        avatar: Avatar(),
        coverPhoto: Avatar(),
        dateOfBirth: DateOfBirth(),
      );
    }
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "isExists": isExists,
        "status": status,
        "numberMutualGroup": numberMutualGroup,
        "numberMutualFriend": numberMutualFriend,
        "id": id,
        "avatar": avatar.toJson(),
        "dateOfBirth": dateOfBirth.toJson(),
        "gender": gender,
      };

  static List<Contacts> listFromJsonArray(List<dynamic> jsonArray) =>
      List<Contacts>.from(jsonArray.map((ct) => Contacts.fromJson(ct)));
}
