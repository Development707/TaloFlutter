import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'dart:io';

List<String> jsonArrayToList(List<dynamic> list) {
  return List<String>.from(list.map((e) => jsonEncode(e)));
}

List<dynamic> listToJsonArray(List<String>? list) {
  return List<dynamic>.from(list!.map((e) => jsonDecode(e)));
}

String jsonToString(Map<String, dynamic> json) {
  return jsonEncode(json);
}

Map<String, dynamic> stringToJson(String? string) {
  return jsonDecode(string!);
}

Future<bool> hasNetwork() async {
  try {
    if (kIsWeb) return true;
    final result = await InternetAddress.lookup("www.google.com");
    return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
  } on SocketException catch (_) {
    Fluttertoast.showToast(
        msg: "No internet connection..!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        fontSize: 12);
    return false;
  }
}
