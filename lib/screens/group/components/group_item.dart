import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../models/contacts.dart';

class GroupItem extends StatelessWidget {
  const GroupItem({
    Key? key,
    required this.contact,
    required this.selected,
  }) : super(key: key);
  final Contacts contact;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: SizedBox(
          height: 53,
          width: 50,
          child: Stack(
            children: [
              CachedNetworkImage(
                  imageUrl: contact.avatar.url ??
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
              selected
                  ? const Positioned(
                      bottom: 5,
                      right: 5,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.green,
                        child: Icon(Icons.check, color: Colors.white, size: 18),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        title: Text(contact.name,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
        subtitle: Text(contact.convertTypeStatus(),
            style: const TextStyle(fontSize: 13)));
  }
}
