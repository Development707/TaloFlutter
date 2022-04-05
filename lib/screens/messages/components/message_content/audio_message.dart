import 'package:flutter/material.dart';
import 'package:flutter_mobile_chatapp_v4_2/models/last_message.dart';

import '../../../../plugin/constants.dart';

class AudioMessage extends StatelessWidget {
  final LastMessage message;
  final bool isSender;

  const AudioMessage({
    Key? key,
    required this.message,
    required this.isSender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding * 0.75,
        vertical: kDefaultPadding / 2,
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(isSender ? 1 : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.play_arrow,
            color: isSender ? Colors.white : kPrimaryColor,
            size: 20,
          ),
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                      width: double.infinity,
                      height: 2,
                      color: isSender
                          ? Colors.white
                          : kPrimaryColor.withOpacity(0.4)),
                  Positioned(
                    left: 0,
                    child: Container(
                        height: 8,
                        width: 8,
                        decoration: BoxDecoration(
                          color: isSender ? Colors.white : kPrimaryColor,
                          shape: BoxShape.circle,
                        )),
                  ),
                ],
              ),
            ),
          ),
          Text("0.15",
              style: TextStyle(
                  fontSize: 12, color: isSender ? Colors.white : null)),
        ],
      ),
    );
  }
}
