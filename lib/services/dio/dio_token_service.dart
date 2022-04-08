import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioToken {
  final _storage = const FlutterSecureStorage();
  static const baseURL = "https://talodocker-mobile-42napghuea-as.a.run.app";
  Dio api = Dio(BaseOptions(
    receiveDataWhenStatusError: true,
    connectTimeout: 20 * 1000,
    receiveTimeout: 20 * 1000,
  ));
  String accessToken = "";

  DioToken() {
    api.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        // Check not exist http
        if (!options.path.contains('http')) {
          options.path = baseURL + options.path;
        }
        // Add token
        options.headers["Authorization"] = "Bearer $accessToken";
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
    final refreshToken = await _storage.read(key: "refreshToken");
    final response = await api.post(
      "/account/refresh-token",
      data: {"refreshToken": refreshToken},
    );
    if (response.statusCode == 200) {
      accessToken = response.data["token"];
    } else {
      accessToken = "";
      _storage.deleteAll();
    }
  }
}
