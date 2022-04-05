import 'package:shared_preferences/shared_preferences.dart';

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
    data = stringToJson(prefs.getString(id));
    return Conversation.fromJson(data);
  }
}
