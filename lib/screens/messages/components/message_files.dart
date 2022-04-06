import 'package:flutter/material.dart';

import '../../../plugin/constants.dart';

Widget MessageFile(BuildContext context) {
  return Container(
    height: 250,
    width: MediaQuery.of(context).size.width,
    child: Card(
      margin: EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconFile(Icons.insert_drive_file, kPrimaryColor, "Document"),
              IconFile(Icons.camera_alt, Colors.deepPurple.shade300, "Camera"),
              IconFile(Icons.insert_photo, Colors.green, "Gallery"),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconFile(Icons.location_pin, Colors.pink.shade300, "Location"),
              IconFile(Icons.saved_search, Colors.cyan, "Find Sticker"),
              IconFile(Icons.headset, Colors.yellow.shade300, "Audio"),
            ])
          ],
        ),
      ),
    ),
  );
}

Widget IconFile(IconData icon, Color color, String text) {
  return Container(
    margin: EdgeInsets.symmetric(
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
