import 'package:flutter/material.dart';
import 'package:flutter_mobile_chatapp_v4_2/models/last_message.dart';

import '../../../../plugin/constants.dart';

class NotifyMessage extends StatelessWidget {
  const NotifyMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final LastMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.8,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding * 0.75,
          vertical: kDefaultPadding / 2,
        ),
        decoration: BoxDecoration(
          color: kTertiaryColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text(message.content,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1?.color,
              fontWeight: FontWeight.bold,
            )));
  }
}
