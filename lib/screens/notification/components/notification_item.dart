import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../plugin/constants.dart';

class NotificationItem extends StatelessWidget {
  final String? url;
  final String title;
  final String time;
  final IconData icon;
  final Function(int) callback;
  const NotificationItem({
    this.url,
    required this.title,
    required this.time,
    required this.icon,
    required this.callback,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 55,
        width: 55,
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
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) =>
                    Image.asset("assets/images/no-avatar.png")),
            Positioned(
              bottom: 0,
              right: -10,
              child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 15,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  )),
            ),
          ],
        ),
      ),
      title: Text(title,
          style: const TextStyle(fontSize: 15),
          textAlign: TextAlign.start,
          maxLines: 3,
          overflow: TextOverflow.ellipsis),
      subtitle:
          Text(time, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      trailing: PopupMenuButton<int>(
        onSelected: callback,
        icon: const Icon(Icons.more_vert, size: 28),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
          const PopupMenuItem<int>(
            value: 1,
            child: Text("Append Request Friend"),
          ),
          const PopupMenuItem<int>(
            value: 0,
            child: Text("Delete Request Friend"),
          )
        ],
      ),
    );
  }
}
