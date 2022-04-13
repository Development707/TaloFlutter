import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../models/conversation.dart';
import '../../models/message.dart';
import '../../plugin/constants.dart';
import '../../store/message_store.dart';
import 'components/messages_body.dart';

class MessagesScreen extends StatelessWidget {
  MessagesScreen({Key? key, this.conversation}) : super(key: key);
  final Conversation? conversation;
  final MessageStore messageStore = MessageStore();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Message>(
      future: messageStore.findById(conversation!.id),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Future.delayed(
              Duration.zero, () => Navigator.of(context).pushNamed("/"));
        }
        return Scaffold(
            appBar: buildAppBar(),
            body: MessagesBody(
                message: snapshot.data, conversation: conversation));
      },
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Row(
        children: [
          CachedNetworkImage(
              imageUrl: conversation!.avatar.url ??
                  "https://storage.googleapis.com/talo-public-file/no-avatar.png",
              imageBuilder: (context, imageProvider) => Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                      color: Colors.white54,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover))),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error)),
          const SizedBox(width: kDefaultPadding * 0.75),
          // ignore: prefer_const_literals_to_create_immutables
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  conversation!.name,
                  style: const TextStyle(fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Text(
                  "Active 3m ago",
                  style: TextStyle(fontSize: 12),
                )
              ],
            ),
          )
        ],
      ),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.local_phone)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
        const SizedBox(width: kDefaultPadding / 2)
      ],
    );
  }
}
