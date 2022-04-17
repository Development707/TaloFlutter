import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/contacts.dart';
import '../../../plugin/constants.dart';

class GroupAvatar extends StatelessWidget {
  const GroupAvatar({Key? key, required this.contacts}) : super(key: key);
  final Contacts contacts;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              CachedNetworkImage(
                  imageUrl: contacts.avatar.url ??
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
                      Image.asset("assets/images/no-avatar.png")),
              const Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.clear, color: Colors.white, size: 18),
                  )),
            ],
          ),
          const SizedBox(height: 4),
          Container(
            width: 50,
            child: Text(contacts.name,
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 1),
          ),
        ],
      ),
    );
  }
}
