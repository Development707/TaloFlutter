import 'package:flutter/material.dart';
import 'package:flutter_mobile_chatapp_v4_2/models/last_message.dart';

import '../../../../plugin/constants.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key? key,
    required this.message,
    required this.isSender,
  }) : super(key: key);

  final LastMessage message;
  final bool isSender;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 0.75,
          vertical: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(isSender ? 1 : 0.1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(message.content,
            style: TextStyle(
              color: isSender
                  ? Colors.white
                  : Theme.of(context).textTheme.bodyText1?.color,
            )));
  }
}
