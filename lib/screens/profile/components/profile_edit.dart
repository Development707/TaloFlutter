import 'package:flutter/material.dart';
import 'package:flutter_mobile_chatapp_v4_2/screens/profile/components/profile_avatar.dart';

import '../../../models/user.dart';
import '../../../plugin/constants.dart';
import '../../../store/profile_store.dart';

class ProfileEdit extends StatelessWidget {
  const ProfileEdit({Key? key}) : super(key: key);

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
            return buildProfileEdit(snapshot.data);
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

  Scaffold buildProfileEdit(User? user) {
    bool _gender = user!.gender;
    String date =
        "${user.dateOfBirth.day}-${user.dateOfBirth.month}-${user.dateOfBirth.year}";

    return Scaffold(
        appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: const Text("Profile Edit"),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.settings)),
            ]),
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: kDefaultPadding / 2),
            ProfileAvatar(url: null),
            const SizedBox(height: kDefaultPadding / 2),
            Container(
              padding: const EdgeInsets.symmetric(
                  vertical: kDefaultPadding / 2, horizontal: kDefaultPadding),
              child: Column(children: [
                TextFormField(
                  initialValue: user.name,
                  decoration: const InputDecoration(
                    labelText: "Your Name",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.drive_file_rename_outline),
                  ),
                ),
                const SizedBox(height: kDefaultPadding / 2),
                TextFormField(
                  initialValue: date,
                  decoration: const InputDecoration(
                    labelText: "Your Bithday",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today_rounded),
                  ),
                ),
                const SizedBox(height: kDefaultPadding / 2),
                TextFormField(
                  enabled: false,
                  initialValue: user.username,
                  decoration: const InputDecoration(
                    labelText: "Your Username",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.account_circle_outlined),
                  ),
                ),
                const SizedBox(height: kDefaultPadding / 2),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "Your Password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.password_outlined),
                  ),
                ),
                const SizedBox(height: kDefaultPadding / 2),
                Row(
                  children: [
                    Radio(
                        value: false,
                        groupValue: _gender,
                        onChanged: (value) => _gender = value as bool),
                    const Text("Male"),
                    Radio(
                        value: true,
                        groupValue: _gender,
                        onChanged: (value) => _gender = value as bool),
                    const Text("Femail"),
                  ],
                ),
                const SizedBox(height: kDefaultPadding / 2),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text("SAVE", style: TextStyle(fontSize: 25)),
                  style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(40),
                      primary: kPrimaryColor,
                      side: const BorderSide(width: 2, color: kPrimaryColor)),
                ),
              ]),
            ),
          ]),
        ));
  }
}
