import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_chatapp_v4_2/plugin/constants.dart';

import '../../models/user.dart';
import '../../services/auth_socal_service.dart';
import '../../services/dio/dio_auth_service.dart';
import '../../services/socket_io_service.dart';
import '../../store/profile_store.dart';
import 'components/profile_avatar.dart';
import 'components/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ProfileStore store = ProfileStore();

    return FutureBuilder<User>(
        future: store.getProFile(),
        builder: (_context, snapshot) {
          if (snapshot.hasError) {
            Future.delayed(
                Duration.zero, () => Navigator.of(context).pushNamed("/"));
          }
          if (snapshot.hasData) {
            return buildProfile(snapshot.data, _context);
          } else {
            return const LinearProgressIndicator(color: kPrimaryColor);
          }
        });
  }

  SingleChildScrollView buildProfile(User? user, BuildContext _context) {
    final DioAuth client = DioAuth();
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: kDefaultPadding / 2),
          ProfileAvatar(url: user!.avatar.url),
          const SizedBox(height: kDefaultPadding / 2),
          Text(user.name,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          const SizedBox(height: kDefaultPadding / 2),
          ProfileMenu(
            icon: Icons.person_outline,
            text: "My Account",
            color: kSecondaryColor,
            press: () => Navigator.of(_context).pushNamed("/profile"),
          ),
          ProfileMenu(
            icon: Icons.notifications,
            text: "Notication & Sound",
            press: () {},
          ),
          ProfileMenu(
            icon: Icons.dark_mode_outlined,
            text: "Dark Mode",
            press: () {},
          ),
          ProfileMenu(
            icon: Icons.settings,
            text: "Setting",
            press: () {},
          ),
          ProfileMenu(
            icon: Icons.help_outline,
            text: "Help Center",
            press: () {},
          ),
          ProfileMenu(
            icon: Icons.logout,
            text: "Log Out",
            color: kTertiaryColor,
            press: () async {
              SocketIoService().socket.dispose();
              await signOut();
              await client.logout(_context);
            },
          ),
        ],
      ),
    );
  }
}
