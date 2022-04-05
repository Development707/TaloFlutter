import 'package:flutter/material.dart';

import '../../../models/last_message.dart';
import '../../../plugin/constants.dart';
import 'message_content/audio_message.dart';
import 'message_content/notify_messageg.dart';
import 'message_content/text_message.dart';
import 'message_content/video_message.dart';
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
          return AudioMessage(
            message: message,
            isSender: isSender,
          );
        case MessageType.VIDEO:
          return VideoMessage(message: message);
        default:
          return const SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding / 2),
      child: Row(
        mainAxisAlignment:
            isSender ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (message.user.id == '') ...[
            const CircleAvatar(
                radius: 12,
                backgroundImage: AssetImage("assets/images/talo.png")),
            const SizedBox(width: kDefaultPadding / 2)
          ],
          messageContent(message, isSender),
          isSender
              ? StatusMessage(status: message.messageStatus)
              : const SizedBox(),
        ],
      ),
    );
  }
}
