import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import 'screens/group/create_group_screen.dart';
import 'screens/fisrt_screen.dart';
import 'screens/login/login_screen_animation.dart';
import 'screens/profile/components/profile_edit.dart';
import 'plugin/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    await Firebase.initializeApp();
  } else {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyD8PFw1STBXraClBaE2AQI88FeUnMQbNN0",
          authDomain: "talo-342211.firebaseapp.com",
          projectId: "talo-342211",
          storageBucket: "talo-342211.appspot.com",
          messagingSenderId: "771338672762",
          appId: "1:771338672762:web:e966779bde4a9022adb9c3",
          measurementId: "G-BG6ZP344NV"),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Talo Chat App',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        "/": (_) => const FirstScreen(),
        "/login": (_) => const LoginScreenAnimation(),
        "/create-group": (_) => const CreateGroupScreen(),
        "/profile": (_) => const ProfileEdit(),
      },
    );
  }
}
