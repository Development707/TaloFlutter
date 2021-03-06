import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../plugin/constants.dart';
import 'dio_auth_service.dart';

class DioToken {
  final _storage = const FlutterSecureStorage();
  final Dio api = Dio(BaseOptions(
    receiveDataWhenStatusError: true,
    connectTimeout: 20 * 1000,
    receiveTimeout: 20 * 1000,
  ));

  DioToken() {
    api.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Check not exist http
        if (!options.path.contains('http')) {
          options.path = baseURL + options.path;
        }
        // Add token
        options.headers["Authorization"] = "Bearer ${await getAccessToken()}";
        // Next request
        return handler.next(options);
      },
      onError: (DioError error, handler) async {
        // Check statuc code 401 and error 'Token không hợp lệ'
        if (error.response?.statusCode == 401) {
          // Check token exist storage
          if (await _storage.containsKey(key: "refreshToken")) {
            await refreshToken();
            return handler.resolve(await retry(error.requestOptions));
          }
        }
        // Next error
        return handler.next(error);
      },
    ));
  }

  Future<Response<dynamic>> retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return api.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }

  Future<void> refreshToken() async {
    print("refresh token");
    final refreshToken = await _storage.read(key: "refreshToken");
    DioAuth()
        .refreshToken(refreshToken ?? "")
        .then((accessToken) async =>
            await _storage.write(key: "accessToken", value: accessToken))
        .catchError((_) async => await _storage.deleteAll());
  }

  getAccessToken() async {
    return await _storage.read(key: "accessToken");
  }
}
