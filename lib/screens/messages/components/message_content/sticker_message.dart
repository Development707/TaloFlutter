import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../models/last_message.dart';

class StickerMessage extends StatelessWidget {
  const StickerMessage({
    Key? key,
    required this.message,
  }) : super(key: key);

  final LastMessage message;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 100,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
                imageUrl: message.content,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error))));
  }
}
