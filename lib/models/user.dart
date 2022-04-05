import 'avatar.dart';
import 'date_of_birth.dart';

class User {
  final String id;
  final String name;
  final String username;
  final Avatar avatar;
  final Avatar coverPhoto;
  final DateOfBirth dateOfBirth;
  final bool gender;
  final bool isActived;

  User({
    required this.id,
    required this.name,
    required this.username,
    required this.avatar,
    required this.coverPhoto,
    required this.dateOfBirth,
    required this.gender,
    required this.isActived,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      name: json["name"],
      username: json["username"],
      avatar: Avatar.fromJson(json["avatar"]),
      coverPhoto: Avatar.fromJson(json["coverPhoto"]),
      dateOfBirth: DateOfBirth.fromJson(json["dateOfBirth"]),
      gender: json["gender"],
      isActived: json["isActived"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "avatar": avatar.toJson(),
        "coverPhoto": coverPhoto.toJson(),
        "dateOfBirth": dateOfBirth.toJson(),
        "gender": gender,
        "isActived": isActived,
      };
}
