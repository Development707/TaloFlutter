import 'package:flutter/material.dart';

import '../../../plugin/constants.dart';

Widget messageFile(BuildContext context) {
  return SizedBox(
    height: 250,
    width: MediaQuery.of(context).size.width,
    child: Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              iconFile(Icons.insert_drive_file, kPrimaryColor, "Document"),
              iconFile(Icons.camera_alt, Colors.deepPurple.shade300, "Camera"),
              iconFile(Icons.insert_photo, Colors.green, "Gallery"),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              iconFile(Icons.location_pin, Colors.pink.shade300, "Location"),
              iconFile(Icons.saved_search, Colors.cyan, "Find Sticker"),
              iconFile(Icons.headset, Colors.yellow.shade300, "Audio"),
            ])
          ],
        ),
      ),
    ),
  );
}

Widget iconFile(IconData icon, Color color, String text) {
  return Container(
    margin: const EdgeInsets.symmetric(
        vertical: kDefaultPadding / 2, horizontal: kDefaultPadding),
    child: Column(
      children: [
        CircleAvatar(
          backgroundColor: color,
          radius: 30,
          child: Icon(icon, size: 30, color: Colors.white),
        ),
        Text(text),
      ],
    ),
  );
}
