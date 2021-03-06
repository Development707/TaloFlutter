import 'package:flutter_contacts/contact.dart';
import 'package:flutter_mobile_chatapp_v4_2/models/friend_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/contacts.dart';
import '../models/user.dart';
import '../services/dio/profile_dio.dart';
import '../services/json_service.dart';

class ProfileStore {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final client = ProfireDio();
  static const profileKey = "profile:";

  // Singleton --------------------------
  static final ProfileStore _singleton = ProfileStore._internal();
  factory ProfileStore() {
    return _singleton;
  }
  ProfileStore._internal();
  // -------------------------------------

  Future<User> getProFile() async {
    Map<String, dynamic> data;
    var prefs = await _prefs;
    if (await hasNetwork()) {
      var json = await client.getProfile();
      await prefs.setString(profileKey, jsonToString(json));
      var user = User.fromJson(json);
      return user;
    }
    data = stringToJson(prefs.getString(profileKey));
    return User.fromJson(data);
  }

  Future<List<Contacts>> getContacts() async {
    List<dynamic> data = [];
    var prefs = await _prefs;
    if (await hasNetwork()) {
      var json = await client.getContacts();
      await prefs.setStringList(profileKey + "contacs:", jsonArrayToList(json));
    }
    data = listToJsonArray(prefs.getStringList(profileKey + "contacs:"));
    return Contacts.listFromJsonArray(data);
  }

  Future<void> asyncContacts(List<Contact> contacts) async {
    if (await hasNetwork()) {
      var list = contacts.where((con1) => con1.phones.isNotEmpty).map((e) =>
          {"name": e.displayName.toString(), "phone": e.phones[0].number});
      if (list.isNotEmpty) await client.asyncContacts(list);
    }
  }

  Future<List<FriendRequest>> getAllRequest() async {
    List<dynamic> data = [];
    var prefs = await _prefs;
    if (await hasNetwork()) {
      var json = await client.getAllRequest();
      await prefs.setStringList(
          profileKey + "friendRequest:", jsonArrayToList(json));
    }
    data = listToJsonArray(prefs.getStringList(profileKey + "friendRequest:"));
    return FriendRequest.listFromJsonArray(data);
  }

  Future<void> appendRequest(String id) async {
    await client.appendRequest(id);
  }

  Future<void> deleteRequest(String id) async {
    await client.deleteRequest(id);
  }
}
