import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/last_message.dart';
import '../../../plugin/constants.dart';
import 'message_content/image_message.dart';
import 'message_content/notify_messageg.dart';
import 'message_content/sticker_message.dart';
import 'message_content/text_message.dart';
import 'message_content/video_message.dart';
import 'message_content/vote_message.dart';
import 'message_status.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({
    Key? key,
    required this.message,
    required this.isSender,
  }) : super(key: key);

  final LastMessage message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    Widget messageContent(LastMessage message, bool isSender) {
      switch (message.type) {
        case MessageType.TEXT:
          return TextMessage(
            message: message,
            isSender: isSender,
          );
        case MessageType.NOTIFY:
          return NotifyMessage(message: message);
        case MessageType.IMAGE:
          return ImageMessage(message: message);
        case MessageType.VIDEO:
          return VideoMessage(message: message);
        case MessageType.STICKER:
          return StickerMessage(message: message);
        case MessageType.VOTE:
          return VoteMessage(message: message, isSender: isSender);
        default:
          return Text(message.type.toString());
      }
    }

    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSender) ...[
            CachedNetworkImage(
                imageUrl: message.user.avatar.url ??
                    "https://storage.googleapis.com/talo-public-file/no-avatar.png",
                imageBuilder: (context, imageProvider) => Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: Colors.white54,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover))),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/images/no-avatar.png")),
            const SizedBox(width: kDefaultPadding / 2)
          ],
          Stack(clipBehavior: Clip.none, children: [
            messageContent(message, isSender),
            isSender
                ? Positioned(
                    bottom: 2,
                    right: -12,
                    child: StatusMessage(status: message.messageStatus))
                : const SizedBox(),
          ]),
          SizedBox(width: isSender ? 5 : 0),
        ],
      ),
    );
  }
}
