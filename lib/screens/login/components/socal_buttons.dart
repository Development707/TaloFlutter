import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import '../../../models/token.dart';
import '../../../services/auth_socal_service.dart';
import '../../../services/dio/dio_auth_service.dart';

class SocalButtons extends StatefulWidget {
  const SocalButtons({
    Key? key,
  }) : super(key: key);

  @override
  State<SocalButtons> createState() => SocalButtonsState();
}

class SocalButtonsState extends State<SocalButtons> {
  DioAuth client = DioAuth();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SignInButton(
          Buttons.GoogleDark,
          text: "Sign in with Google",
          onPressed: () {
            signInWithGoogle().then((value) async {
              String idToken = await getIdToken();
              Token token = await client.loginFirebaseEmail(idToken);
              await client.loginWithToken(token, context);
            });
          },
        ),
        SignInButton(
          Buttons.FacebookNew,
          text: "Sign in with Facebook",
          onPressed: () {
            signInWithFacebook().then((value) async {
              String idToken = await getIdToken();
              Token token = await client.loginFirebaseEmail(idToken);
              await client.loginWithToken(token, context);
            });
          },
        ),
        SignInButton(
          Buttons.AppleDark,
          text: "Sign in with Apple",
          onPressed: () async {
            await signOut();
          },
        ),
      ],
    );
  }
}
