import 'dart:developer';

import 'package:dio/dio.dart';

import 'dio_token_service.dart';

class MessageDio {
  DioToken dioToken = DioToken();
  static const messageEndpoint = "/message";

  Future<String> loadSticker() async {
    try {
      final res = await dioToken.api.get("/sticker");
      return res.data;
    } on DioError catch (err) {
      log("Dio Message Service: " + err.response.toString());
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
      final res = await dioToken.api.get(messageEndpoint + "/" + id);
      return res.data;
    } on DioError catch (err) {
      log("Dio Message Service: " + err.response.toString());
      if (err.type == DioErrorType.response) {
        if (err.response?.statusCode == 404) {
          throw Exception('Error: ${err.response?.data["message"]}');
        }
      }
      throw Exception(err.message);
    }
  }

  Future<dynamic> sendMessage(
      String conversationId, String type, String content) async {
    try {
      final res = await dioToken.api.post(
        messageEndpoint + "/" + conversationId + "/text",
        data: {
          "type": type,
          "content": content,
        },
      );
      return res.data;
    } on DioError catch (err) {
      log("Dio Message Service: " + err.response.toString());
      if (err.type == DioErrorType.response) {
        if (err.response?.statusCode == 404) {
          throw Exception('Error: ${err.response?.data["message"]}');
        }
      }
      throw Exception(err.message);
    }
  }
}
