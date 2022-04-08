import 'package:flutter/material.dart';
import 'package:flutter_mobile_chatapp_v4_2/plugin/constants.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../models/conversation.dart';
import '../../../models/message.dart';
import '../../../models/user.dart';
import '../../../store/profile_store.dart';
import 'messages_input_field.dart';
import 'messages_item.dart';

class MessagesBody extends StatefulWidget {
  const MessagesBody({Key? key, this.message, this.conversation})
      : super(key: key);
  final Message? message;
  final Conversation? conversation;

  @override
  State<MessagesBody> createState() => _MessagesBodyState();
}

class _MessagesBodyState extends State<MessagesBody> {
  final storeProfile = ProfileStore();
  final _scrollController = ScrollController();
  late IO.Socket socket;

  @override
  void initState() {
    super.initState();
    connectSockets();
  }

  void connectSockets() {
    socket = IO.io(
      "http://10.0.2.2:5000",
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );
    socket.connect();
    socket.onConnect((data) {
      print("Connected");
    });
    print(socket.connected);
  }

  @override
  Widget build(BuildContext context) {
    return widget.message != null
        ? FutureBuilder<User>(
            future: storeProfile.getProFile(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                Future.delayed(Duration.zero,
                    () => Navigator.of(context).pushNamed("/chat"));
              }
              if (snapshot.hasData) {
                return buildBody(snapshot.data);
              } else {
                return const LinearProgressIndicator(color: kPrimaryColor);
              }
            },
          )
        : const LinearProgressIndicator(color: kPrimaryColor);
  }

  Widget buildBody(User? user) {
    return Column(
      children: [
        Expanded(
            flex: 1,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: widget.message!.data.length,
              itemBuilder: (context, index) => MessageItem(
                  message: widget.message!.data[index],
                  isSender: widget.message!.data[index].user.id == user!.id),
            )),
        MessagesInputField(conversation: widget.conversation),
      ],
    );
  }
}
