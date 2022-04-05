import 'dart:developer';

import 'package:dio/dio.dart';

import 'dio_token_service.dart';

class ConversationDio {
  DioToken dioToken = DioToken();
  static const conversationEndpoint = "/conversations";

  Future<List<dynamic>> findAll() async {
    try {
      final res = await dioToken.api.get(conversationEndpoint);
      return res.data;
    } on DioError catch (err) {
      log("Dio Auth Service: " + err.response.toString());
      if (err.type == DioErrorType.response) {
        if (err.response?.statusCode == 404) {
          throw Exception('Error: ${err.response?.data["message"]}');
        }
      }
      throw Exception(err.message);
    }
  }

  Future<dynamic> findById(String id) async {
    try {
      final res = await dioToken.api.get(conversationEndpoint + "/" + id);
      return res.data;
    } on DioError catch (err) {
      log("Dio Conversation Service: " + err.response.toString());
      if (err.type == DioErrorType.response) {
        if (err.response?.statusCode == 404) {
          throw Exception('Error: ${err.response?.data["message"]}');
        }
      }
      throw Exception(err.message);
    }
  }
}
