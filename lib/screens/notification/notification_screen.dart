import 'package:flutter/material.dart';
import 'package:flutter_mobile_chatapp_v4_2/models/avatar.dart';
import 'package:flutter_mobile_chatapp_v4_2/services/socket_io_service.dart';

import '../../models/friend_request.dart';
import '../../plugin/constants.dart';
import '../../store/profile_store.dart';
import 'components/notification_item.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final store = ProfileStore();
  late List<FriendRequest> list;

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    SocketIoService().socket.on("FriendRequestSend", (data) {
      setState(() {
        list.add(FriendRequest(
            id: data["id"],
            name: data["name"],
            message: "New request by Friend",
            avatar: Avatar.fromJson(data["avatar"]),
            numberMutualGroup: 0,
            numberMutualFriend: 0));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FriendRequest>>(
        future: store.getAllRequest(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            Future.delayed(
                Duration.zero, () => Navigator.of(context).pushNamed("/"));
          }
          if (snapshot.hasData) {
            list = snapshot.data ?? [];
            return buildBody(context);
          } else {
            return const LinearProgressIndicator(color: kPrimaryColor);
          }
        });
  }

  GestureDetector buildBody(BuildContext context) {
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
                callback: (int result) {
                  if (result == 1) {
                    store
                        .appendRequest(list[index].id)
                        .then((value) => Navigator.of(context).pushNamed("/"));
                  } else {
                    store
                        .deleteRequest(list[index].id)
                        .then((value) => Navigator.of(context).pushNamed("/"));
                  }
                },
              ),
              itemCount: list.length,
            ),
          ),
        ],
      ),
    );
  }
}
