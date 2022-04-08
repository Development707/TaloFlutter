import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  // Localhost: 10.0.2.2
  static const baseURL = "http://10.0.2.2:5000";
  final IO.Socket _socket = IO.io(
    baseURL,
    IO.OptionBuilder().setTransports(['websocket']).build(),
  );

  // Singleton --------------------------
  static final SocketService _singleton = SocketService._internal();
  factory SocketService() {
    return _singleton;
  }
  SocketService._internal();
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
}
