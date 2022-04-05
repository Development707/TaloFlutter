import 'package:flutter/material.dart';

import '../../../models/last_message.dart';
import '../../../plugin/constants.dart';

class StatusMessage extends StatelessWidget {
  const StatusMessage({
    Key? key,
    required this.status,
  }) : super(key: key);

  final MessageStatus status;

  @override
  Widget build(BuildContext context) {
    Color? statusColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.ERROR:
          return kErrorColor;
        case MessageStatus.NOT_VIEW:
          return Theme.of(context).textTheme.bodyText1?.color?.withOpacity(0.2);
        case MessageStatus.VIEWED:
          return kPrimaryColor;
        default:
          return Colors.transparent;
      }
    }

    return Container(
      margin: const EdgeInsets.only(left: kDefaultPadding / 2),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        color: statusColor(status),
        shape: BoxShape.circle,
      ),
      child: Icon(
        status == MessageStatus.ERROR ? Icons.close : Icons.done,
        size: 8,
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );
  }
}
