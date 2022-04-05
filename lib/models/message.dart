import 'last_message.dart';

class Message {
  final List<LastMessage> data;
  final int page;
  final int size;
  final int totalPages;

  Message({
    required this.data,
    this.size = 20,
    this.page = 0,
    this.totalPages = 1,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      data: LastMessage.fromJsonArray(json["data"]),
      page: json["page"],
      size: json["size"],
      totalPages: json["totalPages"],
    );
  }
}
