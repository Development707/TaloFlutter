import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketClient {
  // Localhost: 10.0.2.2
  static const baseURL = "https://talodocker-mobile-42napghuea-as.a.run.app";
  final IO.Socket _socket = IO.io(
    baseURL,
    OptionBuilder().setTransports(['websocket']).build(),
  );

  // Singleton --------------------------
  static final SocketClient _singleton = SocketClient._internal();
  factory SocketClient() {
    return _singleton;
  }
  SocketClient._internal();
  // -------------------------------------

  IO.Socket get socket => _socket;

  void testConnect() {
    _socket.emit("message", _socket.id);
    _socket.on("message-server", (message) => log(message));
  }

  void userOnline(String userId) {
    socket.emit("UserOnline", userId);
  }

  void userOffline(String userId) {
    socket.emit("UserOffline", userId);
  }

  void joinConversation(String conversationId) {
    socket.emit("ConversationJoin", conversationId);
  }

  void leftConversation(String conversationId) {
    socket.emit("ConversationLeft", conversationId);
  }

  void typing(String conversationId, String userId) {
    socket.emit("ConversationUserTyping", {conversationId, userId});
  }

  void typingFinish(String conversationId, String userId) {
    socket.emit("ConversationUserTypingFinish", {conversationId, userId});
  }

  void getStatusUser(String userId, Function callback) {
    socket.emit("UserGetStatus", {userId, callback});
  }
}
