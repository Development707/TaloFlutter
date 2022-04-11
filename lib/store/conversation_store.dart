import 'package:flutter_mobile_chatapp_v4_2/models/create_conversation.dart';
import 'package:flutter_mobile_chatapp_v4_2/plugin/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/contacts.dart';
import '../models/conversation.dart';
import '../services/dio/conversation_dio.dart';
import '../services/json_service.dart';

class ConversationStore {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final client = ConversationDio();
  static const conversationKey = "conversation:";

  // Singleton --------------------------
  static final ConversationStore _singleton = ConversationStore._internal();
  factory ConversationStore() {
    return _singleton;
  }
  ConversationStore._internal();
  // -------------------------------------

  Future<List<Conversation>> loadServer() async {
    List<dynamic> data = [];
    var prefs = await _prefs;
    if (await hasNetwork()) {
      var json = await client.findAll();
      await prefs.setStringList(conversationKey, jsonArrayToList(json));
    }
    data = listToJsonArray(prefs.getStringList(conversationKey));
    return Conversation.listFromJsonArray(data);
  }

  Future<Conversation> findById(String id) async {
    Map<String, dynamic> data;
    var prefs = await _prefs;
    try {
      var json = await client.findById(id);
      await prefs.setString(conversationKey + id, jsonToString(json));
    } on Exception catch (_) {}
    data = stringToJson(prefs.getString(conversationKey + id));
    return Conversation.fromJson(data);
  }

  Future<Conversation> getDual(String userId) async {
    try {
      var json = await client.createDual(userId);
      var checked = CreateConversation.fromeJson(json);
      return findById(checked.conversationId);
    } on Exception catch (_) {
      throw Exception("Can't not create group");
    }
  }

  Future<Conversation> createGroup(List<String> userIds) async {
    try {
      var json = await client.createGroup(userIds);
      return findById(json["id"]);
    } on Exception catch (_) {
      throw Exception("Can't not create group");
    }
  }

  Future<void> sendRequest(String username) async {
    try {
      Map<String, dynamic> json = await client.findByUsername(username);
      json.addEntries(<String, dynamic>{"isExists": true}.entries);
      json.addEntries(<String, dynamic>{"phone": username}.entries);
      var user = Contacts.fromJson(json);
      switch (user.status) {
        case TypeStatus.FRIEND:
          notication(username + " is Friend");
          break;
        case TypeStatus.FOLLOWER:
          notication("You are send requested");
          break;
        case TypeStatus.FOLLOWING:
          notication(username + " is send you request");
          break;
        case TypeStatus.NOT_FRIEND:
          client
              .sendRequest(user.id)
              .then((value) => notication("Send request success"))
              .catchError((err) => notication(err.message));
          break;
        default:
      }
    } catch (e) {
      notication(username + " not found");
    }
  }

  void notication(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: kPrimaryColor,
        textColor: kContentColorDarkTheme,
        fontSize: 16.0);
  }
}
