import 'package:flutter/material.dart';
import 'package:flutter_mobile_chatapp_v4_2/models/last_message.dart';

import '../../../../plugin/constants.dart';

class VideoMessage extends StatelessWidget {
  const VideoMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final LastMessage message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: AspectRatio(
          aspectRatio: 1.6,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset("assets/images/talo_welcome.png"),
              ),
              Container(
                  height: 25,
                  width: 25,
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    size: 15,
                    color: Colors.white,
                  ))
            ],
          )),
    );
  }
}
