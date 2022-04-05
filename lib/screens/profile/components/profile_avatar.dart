import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../plugin/constants.dart';

class ProfileAvatar extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  ProfileAvatar({Key? key, this.url}) : super(key: key);
  final String? url;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CachedNetworkImage(
              imageUrl: url ??
                  "https://storage.googleapis.com/talo-public-file/no-avatar.png",
              imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover))),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error)),
          Positioned(
            right: -25,
            bottom: 0,
            child: Container(
                decoration: BoxDecoration(
                    color: kPrimaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        width: 3)),
                child: TextButton(
                    onPressed: () {},
                    child: const Icon(Icons.camera_alt,
                        color: Colors.white, size: 25))),
          )
        ],
      ),
    );
  }
}
