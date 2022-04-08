import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/account.dart';
import '../../models/token.dart';

class DioAuth {
  // Andoird 10.0.2.2
  // Web 127.0.0.1
  static const baseURL = "https://talodocker-mobile-42napghuea-as.a.run.app";
  static const accountEndpoint = "/account";
  static const firebaseEndpoint = "/firebase/auth";
  final _storage = const FlutterSecureStorage();

  final Dio api = Dio(BaseOptions(
    baseUrl: baseURL,
    receiveDataWhenStatusError: true,
    connectTimeout: 20 * 1000,
    receiveTimeout: 20 * 1000,
  ));

  Future<Token> loginBasic(Account account) async {
    try {
      final res = await api.post(
        accountEndpoint + "/login",
        data: account.toJson(),
      );
      return Token.fromJson(res.data);
    } on DioError catch (err) {
      log("Dio Auth Service: " + err.toString());
      if (err.type == DioErrorType.response) {
        if (err.response?.statusCode == 404) {
          throw Exception('Error: ${err.response?.data["message"]}');
        }
      }
      throw Exception(err.message);
    }
  }

  Future<Token> loginFirebaseEmail(String idToken) async {
    try {
      final res = await api.post(
        firebaseEndpoint + "/email",
        options: Options(headers: {"Authorization": "Bearer $idToken"}),
      );
      return Token.fromJson(res.data);
    } on DioError catch (err) {
      log("Dio Auth Service: " + err.toString());
      if (err.type == DioErrorType.response) {
        if (err.response?.statusCode == 401) {
          throw Exception('Error: ${err.response?.data["message"]}');
        }
      }
      throw Exception(err.message);
    }
  }

  Future<Token> loginFirebasePhone(String idToken, String password) async {
    try {
      final res = await api.post(
        firebaseEndpoint + "/phone",
        data: {"password": password},
        options: Options(headers: {"Authorization": "Bearer $idToken"}),
      );
      return Token.fromJson(res.data);
    } on DioError catch (err) {
      log("Dio Auth Service: " + err.toString());
      if (err.type == DioErrorType.response) {
        if (err.response?.statusCode == 401 ||
            err.response?.statusCode == 404) {
          throw Exception('Error: ${err.response?.data["message"]}');
        }
      }
      throw Exception(err.message);
    }
  }

  Future<Token> loginFirebaseByIdToken(String idToken) async {
    try {
      final res = await api.post(
        firebaseEndpoint + "/id-token",
        options: Options(headers: {"Authorization": "Bearer $idToken"}),
      );
      return Token.fromJson(res.data);
    } on DioError catch (err) {
      log("Dio Auth Service: " + err.toString());
      if (err.type == DioErrorType.response) {
        if (err.response?.statusCode == 401 ||
            err.response?.statusCode == 404) {
          throw Exception('Error: ${err.response?.data["message"]}');
        }
      }
      throw Exception(err.message);
    }
  }

  Future<void> loginWithToken(Token token, BuildContext context) async {
    if (token.refreshToken.isNotEmpty) {
      await _storage.write(key: "refreshToken", value: token.refreshToken);
      Future.delayed(
          Duration.zero, () => Navigator.of(context).popAndPushNamed("/chat"));
    } else {
      throw Exception("Token invalid");
    }
  }

  Future<void> logout(BuildContext context) async {
    await _storage.write(key: "refreshToken", value: null);
    Future.delayed(
        Duration.zero, () => Navigator.pushReplacementNamed(context, "/login"));
  }
}
