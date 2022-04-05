import 'package:flutter_mobile_chatapp_v4_2/services/dio/message_dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/last_message.dart';
import '../models/message.dart';
import '../services/json_service.dart';

class MessageStore {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final client = MessageDio();
  static const messageKey = "message:";
  static const pageKey = "page:";
  static const sizeKey = "size:";
  static const totalPagesKey = "totalPaages:";

  // Singleton --------------------------
  static final MessageStore _singleton = MessageStore._internal();
  factory MessageStore() {
    return _singleton;
  }
  MessageStore._internal();
  // -------------------------------------

  Future<Message> findById(String conversationId) async {
    List<dynamic> data;
    var prefs = await _prefs;
    // Load to server
    if (await hasNetwork()) {
      var json = await client.findById(conversationId);
      var message = Message.fromJson(json);
      await prefs.setStringList(
          messageKey + conversationId, jsonArrayToList(json["data"]));
      await prefs.setInt(pageKey + conversationId, message.page);
      await prefs.setInt(sizeKey + conversationId, message.size);
      await prefs.setInt(totalPagesKey + conversationId, message.totalPages);
    }
    // Load to prefs
    data = listToJsonArray(prefs.getStringList(messageKey + conversationId));
    var page = prefs.getInt(pageKey + conversationId);
    var size = prefs.getInt(sizeKey + conversationId);
    var totalPages = prefs.getInt(totalPagesKey + conversationId);
    return Message(
      data: LastMessage.fromJsonArray(data),
      page: page ?? 0,
      size: size ?? 20,
      totalPages: totalPages ?? 1,
    );
  }
}
