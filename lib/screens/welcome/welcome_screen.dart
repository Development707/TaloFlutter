import 'package:flutter/material.dart';

import '../../plugin/constants.dart';
import '../../plugin/globals.dart' as globals;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () => globals.isFistLogin = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            Image.asset('assets/images/talo_welcome.png'),
            Text(
              'Wellcome to our freedom\nTalo message chat',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(flex: 1),
            Text("Thỏa sức nhắn tin bằng\nNgôn ngữ của bạn",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.color
                        ?.withOpacity(0.7))),
            const SizedBox(height: 30),
            const Spacer(flex: 3),
            FittedBox(
              child: TextButton(
                  onPressed: () => Future.delayed(
                      Duration.zero,
                      () =>
                          Navigator.of(context).pushReplacementNamed("/login")),
                  child: Row(
                    children: [
                      Text('Skip',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      ?.color
                                      ?.withOpacity(0.8))),
                      const SizedBox(width: kDefaultPadding / 4),
                      Icon(Icons.arrow_forward_ios,
                          size: 16,
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1
                              ?.color
                              ?.withOpacity(0.8))
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
