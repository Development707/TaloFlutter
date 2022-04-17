import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../plugin/constants.dart';
import 'chats/chats_screen.dart';
import 'welcome/welcome_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  State<FirstScreen> createState() => _FirstScreen();
}

class _FirstScreen extends State<FirstScreen> {
  Future<bool> checkFirstScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool("firstScreen") ?? true) {
      prefs.setBool("firstScreen", false);
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: checkFirstScreen(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data ?? true) {
              return const WelcomeScreen();
            } else {
              return const ChatsScreen();
            }
          } else {
            return const Scaffold(
                body: Center(
                    child: SizedBox(
                        height: 80,
                        width: 80,
                        child:
                            CircularProgressIndicator(color: kPrimaryColor))));
          }
        });
  }
}
