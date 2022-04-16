import 'package:flutter/material.dart';

import '../../../components/filled_outline_button.dart';
import '../../../models/conversation.dart';
import '../../../models/last_message.dart';
import '../../../plugin/constants.dart';
import '../../../services/socket_io_service.dart';
import '../../../store/conversation_store.dart';
import '../../messages/messages_screen.dart';
import 'chats_card.dart';

class ChatsBody extends StatefulWidget {
  const ChatsBody({Key? key}) : super(key: key);

  @override
  State<ChatsBody> createState() => _ChatsBodyState();
}

class _ChatsBodyState extends State<ChatsBody> {
  final store = ConversationStore();
  final socketIO = SocketIoService();
  late List<Conversation> items;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    socketIO.socket.on(
        "MessageNew",
        (data) => setState(() {
              items.firstWhere((conver) => conver.id == data[0]).lastMessage =
                  LastMessage.fromJson(data[1]);
            }));
    socketIO.socket.on("ConversationGroupCreate", (data) => print(data));
    socketIO.socket.on("ConversationDuaCreate", (data) => print(data));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Conversation>>(
        future: store.loadServer(),
        builder: (_context, snapshot) {
          if (snapshot.hasError) {
            Future.delayed(Duration.zero,
                () => Navigator.of(context).popAndPushNamed("/login"));
          }
          if (snapshot.hasData) {
            items = snapshot.data ?? [];
            return buildChatBody();
          } else {
            return const LinearProgressIndicator(color: kPrimaryColor);
          }
        });
  }

  Column buildChatBody() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(
              kDefaultPadding, 0, kDefaultPadding, kDefaultPadding / 4),
          color: kPrimaryColor,
          child: Row(
            children: [
              FillOutlineButton(
                press: () {},
                text: "Messages",
                key: const ValueKey(1),
              ),
              const SizedBox(width: kDefaultPadding),
              FillOutlineButton(
                press: () {},
                text: "Active Status",
                isFilled: false,
                key: const ValueKey(2),
              ),
            ],
          ),
        ),
        Expanded(
            child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  socketIO.socket.emit('ConversationJoin', items[index].id);
                  return ChatCard(
                    conversation: items[index],
                    press: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MessagesScreen(conversation: items[index]),
                      ),
                    ),
                  );
                }))
      ],
    );
  }
}
