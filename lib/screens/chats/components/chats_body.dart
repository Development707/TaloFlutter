import 'package:flutter/material.dart';

import '../../../components/filled_outline_button.dart';
import '../../../models/conversation.dart';
import '../../../plugin/constants.dart';
import '../../../store/conversation_store.dart';
import '../../messages/messages_screen.dart';
import 'chats_card.dart';

class ChatsBody extends StatefulWidget {
  const ChatsBody({Key? key}) : super(key: key);

  @override
  State<ChatsBody> createState() => _ChatsBodyState();
}

class _ChatsBodyState extends State<ChatsBody> {
  final ConversationStore store = ConversationStore();

  @override
  void initState() {
    super.initState();
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
            return buildChatBody(snapshot.data ?? []);
          } else {
            return const LinearProgressIndicator(color: kPrimaryColor);
          }
        });
  }

  Column buildChatBody(List<Conversation> items) {
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
          itemBuilder: (context, index) => ChatCard(
            conversation: items[index],
            press: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MessagesScreen(conversation: items[index]),
              ),
            ),
          ),
        ))
      ],
    );
  }
}
