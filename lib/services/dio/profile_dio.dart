import 'dart:developer';

import 'package:dio/dio.dart';

import 'dio_token_service.dart';

class ProfireDio {
  DioToken dioToken = DioToken();
  static const profileEndpoint = "/profile";

  Future<dynamic> getProfile() async {
    try {
      final res = await dioToken.api.get(profileEndpoint);
      return res.data;
    } on DioError catch (err) {
      log("Dio Profile Service: " + err.response.toString());
      if (err.type == DioErrorType.response) {
        if (err.response?.statusCode == 404) {
          throw Exception('Error: ${err.response?.data["message"]}');
        }
      }
      throw Exception(err.message);
    }
  }

  Future<List<dynamic>> getContacts() async {
    try {
      final res = await dioToken.api.get(profileEndpoint + "/contacts");
      return res.data;
    } on DioError catch (err) {
      log("Dio Profile Service: " + err.response.toString());
      if (err.type == DioErrorType.response) {
        if (err.response?.statusCode == 404) {
          throw Exception('Error: ${err.response?.data["message"]}');
        }
      }
      throw Exception(err.message);
    }
  }

  Future<void> asyncContacts(Iterable<Map<String, String>> list) async {
    try {
      await dioToken.api.post(
        profileEndpoint + "/contacts",
        data: list,
      );
    } on DioError catch (err) {
      log("Dio Profile Service: " + err.response.toString());
      if (err.type == DioErrorType.response) {
        if (err.response?.statusCode == 404) {
          throw Exception('Error: ${err.response?.data["message"]}');
        }
      }
      throw Exception(err.message);
    }
  }

  Future<dynamic> getAllRequest() async {
    try {
      final res = await dioToken.api.get("/friend/requests");
      return res.data;
    } on DioError catch (err) {
      log("Dio Profile Service: " + err.response.toString());
      if (err.type == DioErrorType.response) {
        if (err.response?.statusCode == 400) {
          throw Exception('Error: ${err.response?.data["message"]}');
        }
      }
      throw Exception(err.message);
    }
  }

  Future<dynamic> appendRequest(String id) async {
    try {
      Map<String, dynamic> body = {"userId": id};
      final res = await dioToken.api.post("/friend/requests", data: body);
      return res.data;
    } on DioError catch (_) {}
  }

  Future<dynamic> deleteRequest(String id) async {
    try {
      final res = await dioToken.api.delete("/friend/requests/" + id);
      return res.data;
    } on DioError catch (_) {}
  }
}
