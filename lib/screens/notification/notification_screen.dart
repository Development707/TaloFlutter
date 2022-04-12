import 'package:flutter/material.dart';

import '../../models/friend_request.dart';
import '../../plugin/constants.dart';
import '../../store/profile_store.dart';
import 'components/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = ProfileStore();

    return FutureBuilder<List<FriendRequest>>(
        future: store.getAllRequest(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Future.delayed(
                Duration.zero, () => Navigator.of(context).pushNamed("/chat"));
          }
          if (snapshot.hasData) {
            return buildBody(context, snapshot.data ?? []);
          } else {
            return const LinearProgressIndicator(color: kPrimaryColor);
          }
        });
  }

  GestureDetector buildBody(BuildContext context, List<FriendRequest> list) {
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
                icon: Icons.person,
                title: list[index].name + ": " + list[index].message,
                url: list[index].avatar.url,
                time: "Mutuak Firend: " +
                    list[index].numberMutualFriend.toString() +
                    " - Mutuak Group: " +
                    list[index].numberMutualGroup.toString(),
                callback: () {},
              ),
              itemCount: list.length,
            ),
          ),
        ],
      ),
    );
  }
}
