import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_chatapp_v4_2/plugin/constants.dart';

import '../../../models/contacts.dart';

class ConstactsItem extends StatelessWidget {
  final Contacts contacts;
  const ConstactsItem({
    Key? key,
    required this.contacts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      margin: const EdgeInsets.only(bottom: kDefaultPadding / 4),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.5),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(35), topLeft: Radius.circular(35)),
      ),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            padding: const EdgeInsets.all(kDefaultPadding / 4),
            child: contacts.avatar != null
                ? CachedNetworkImage(
                    imageUrl: contacts.avatar!.url ??
                        "https://storage.googleapis.com/talo-public-file/no-avatar.png",
                    imageBuilder: (context, imageProvider) => Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover))),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error))
                : CircleAvatar(
                    backgroundColor: Colors.white70,
                    child: Text(contacts.name[0],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: kPrimaryColor,
                          fontSize: 45,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
          ),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(kDefaultPadding / 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  contacts.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                Text(contacts.phone,
                    style: TextStyle(
                        color: contacts.isExists
                            ? kPrimaryColor
                            : kSecondaryColor)),
                contacts.isExists
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Mutual Fiend: ${contacts.numberMutualFriend}"),
                          Text("Mutual Group: ${contacts.numberMutualGroup}"),
                        ],
                      )
                    : const SizedBox()
              ],
            ),
          )),
          const Icon(Icons.arrow_forward_ios_outlined,
              size: 25, color: kPrimaryColor),
        ],
      ),
    );
  }
}
