import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_chatapp_v4_2/models/conversation.dart';
import 'package:intl/intl.dart';

import '../../../plugin/constants.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key? key,
    required this.conversation,
    required this.press,
  }) : super(key: key);

  final Conversation conversation;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: kDefaultPadding * 0.75),
        child: Row(
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                    imageUrl: conversation.avatar.url ??
                        "https://storage.googleapis.com/talo-public-file/no-avatar.png",
                    imageBuilder: (context, imageProvider) => Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover))),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error)),
                if (!conversation.isNotify)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      height: 16,
                      width: 16,
                      child: const Icon(Icons.do_not_disturb_on),
                      decoration: BoxDecoration(
                          color: kPrimaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              width: 3)),
                    ),
                  ),
              ],
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(conversation.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    Opacity(
                        opacity: 0.6,
                        child: conversation.lastMessage != null
                            ? Text(
                                conversation.lastMessage!.user.name +
                                    ": " +
                                    conversation.lastMessage!.content,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis)
                            : Text("")),
                  ],
                ),
              ),
            ),
            Opacity(
              opacity: 0.6,
              child: conversation.lastMessage != null
                  ? Text(DateFormat('hh:mm\ndd-MM')
                      .format(conversation.lastMessage!.createdAt.toLocal()))
                  : const Text("--:--"),
            ),
          ],
        ),
      ),
    );
  }
}
