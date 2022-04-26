import 'dart:developer';

import 'package:socket_io_client/socket_io_client.dart';

import '../plugin/constants.dart';

class SocketIoService {
  final Socket socket = io(
    socketURL,
    OptionBuilder()
        .setTransports(['websocket'])
        .disableAutoConnect()
        .setPath('/mobile/socket.io/')
        .build(),
  );

  // Singleton --------------------------
  static final SocketIoService _singleton = SocketIoService._internal();
  factory SocketIoService() {
    return _singleton;
  }
  SocketIoService._internal();
  // -------------------------------------

  createSocketConnection() {
    socket.connect();
    socket.on("connect", (_) => log('SocketIoService connected'));
    socket.on("disconnect", (_) => log('SocketIoService disconnected'));
  }
}
