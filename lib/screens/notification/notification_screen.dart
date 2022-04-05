import 'package:flutter/material.dart';

import '../../plugin/constants.dart';
import 'components/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          ListTile(
            leading: const Text("Notification",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            trailing: CircleAvatar(
                backgroundColor: Colors.grey.withOpacity(0.7),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.clear_all,
                        color: Theme.of(context).textTheme.bodyText1?.color))),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: kDefaultPadding / 2),
            child: const Text("Earlier",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => NotificationItem(
                icon: Icons.bookmark,
                title: "ABC",
                callback: () {
                  print(index);
                },
              ),
              itemCount: 10,
            ),
          ),
        ],
      ),
    );
  }
}
