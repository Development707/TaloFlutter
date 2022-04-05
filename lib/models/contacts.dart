// ignore_for_file: constant_identifier_names

import 'package:flutter_mobile_chatapp_v4_2/models/avatar.dart';
import 'package:flutter_mobile_chatapp_v4_2/models/date_of_birth.dart';

enum TypeStatus { FRIEND, FOLLOWER, FOLLOWING, NOT_FRIEND }

class Contacts {
  final String name;
  final String phone;
  final bool isExists;
  final TypeStatus status;
  final int? numberMutualGroup;
  final int? numberMutualFriend;
  final String? id;
  final Avatar? avatar;
  final Avatar? coverPhoto;
  final DateOfBirth? dateOfBirth;
  final bool? gender;

  Contacts({
    required this.name,
    required this.phone,
    required this.isExists,
    this.status = TypeStatus.NOT_FRIEND,
    this.numberMutualGroup,
    this.numberMutualFriend,
    this.id,
    this.avatar,
    this.coverPhoto,
    this.dateOfBirth,
    this.gender,
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
        dateOfBirth: DateOfBirth.fromJson(json["dateOfBirth"]),
        gender: json["gender"],
      );
    } else {
      return Contacts(
        name: json["name"],
        phone: json["phone"],
        isExists: json["isExists"],
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
        "avatar": avatar!.toJson(),
        "dateOfBirth": dateOfBirth!.toJson(),
        "gender": gender,
      };

  static List<Contacts> listFromJsonArray(List<dynamic> jsonArray) =>
      List<Contacts>.from(jsonArray.map((ct) => Contacts.fromJson(ct)));
}
