import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_chatapp_v4_2/screens/contacts/contacts_screen.dart';
import 'package:flutter_mobile_chatapp_v4_2/screens/notification/notification_screen.dart';
import 'package:flutter_mobile_chatapp_v4_2/store/profile_store.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../models/user.dart';
import '../../plugin/constants.dart';
import '../../services/dio/dio_auth_service.dart';
import '../../services/socket_io_service.dart';
import '../profile/profile_screen.dart';
import 'components/chats_body.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({Key? key}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  final ProfileStore store = ProfileStore();
  final DioAuth client = DioAuth();
  final socketService = SocketIoService();
  DateTime currentBackPressTime = DateTime.now();
  int _selectedIndex = 0;
  static const List<Widget> __widgetOptions = <Widget>[
    ChatsBody(),
    ContactsScreen(),
    NotificationScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext _context) {
    return FutureBuilder<User>(
        future: store.getProFile(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            client.logout(context).then((_) => print("Data has Error"));
          }
          if (snapshot.hasData) {
            return buildChat(snapshot.data);
          } else {
            return const Scaffold(
                body: Center(
                    child: SizedBox(
                        height: 50,
                        width: 50,
                        child:
                            CircularProgressIndicator(color: kPrimaryColor))));
          }
        });
  }

  Scaffold buildChat(User? user) {
    socketService.createSocketConnection();
    socketService.socket.emit('UserOnline', user?.id);
    return Scaffold(
      appBar: buildAppBar(),
      body: WillPopScope(
          child: __widgetOptions.elementAt(_selectedIndex),
          onWillPop: onWillPop),
      floatingActionButton:
          _selectedIndex < 2 ? buildFloatingActionButton() : null,
      bottomNavigationBar: builBottomNavigationBar(user!),
    );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).pushNamed("/create-group");
      },
      backgroundColor: kPrimaryColor,
      child: const Icon(
        Icons.person_add_alt_1,
        color: Colors.white,
      ),
    );
  }

  BottomNavigationBar builBottomNavigationBar(User user) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.shifting,
      currentIndex: _selectedIndex,
      onTap: (value) {
        setState(() {
          _selectedIndex = value;
        });
      },
      items: [
        const BottomNavigationBarItem(
            icon: Icon(Icons.message), label: "Chats"),
        const BottomNavigationBarItem(
            icon: Icon(Icons.contacts), label: "Contact"),
        const BottomNavigationBarItem(
            icon: Icon(Icons.circle_notifications), label: "Notications"),
        BottomNavigationBarItem(
          icon: CachedNetworkImage(
              imageUrl: user.avatar.url ??
                  "https://storage.googleapis.com/talo-public-file/no-avatar.png",
              imageBuilder: (context, imageProvider) => Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover))),
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error)),
          label: "Profile",
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryColor,
      title: const Text("Talo Chats"),
      actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
      ],
    );
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 1)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
          msg: "Tap back again to exit",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: kPrimaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
