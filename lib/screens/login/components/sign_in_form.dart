// ignore_for_file: invalid_return_type_for_catch_error

import 'package:flutter/material.dart';
import 'package:flutter_mobile_chatapp_v4_2/models/account.dart';

import '../../../plugin/constants.dart';
import '../../../services/auth_socal_service.dart';
import '../../../services/dio/dio_auth_service.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignInForm> createState() => SignInFormState();
}

class SignInFormState extends State<SignInForm> {
  final formKey = GlobalKey<FormState>();
  DioAuth client = DioAuth();
  bool showLoad = false;
  String? _error, _username, _password;

  void checkLogged() async {
    if (getUserFirebase() != null) {
      String idToken = await getIdToken();
      client
          .loginFirebaseByIdToken(idToken)
          .then((token) => client
              .loginWithToken(token, context)
              .then((_) => Future.delayed(Duration.zero, () {
                    Navigator.of(context).pushReplacementNamed("/chat");
                  }))
              .catchError((e) => setState(() => _error = e.message)))
          .catchError((e) => setState(() => _error = e.message));
    }
  }

  void onSubmit() {
    final form = formKey.currentState;
    form!.save();
    if (form.validate()) {
      setState(() => showLoad = true);
      client
          .loginBasic(Account(
              username: _username.toString(), password: _password.toString()))
          .then((token) {
            client
                .loginWithToken(token, context)
                .catchError((e) => _error = e.message);
          })
          .catchError((e) => _error = e.message)
          .whenComplete(() => setState(() => showLoad = false));
    }
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: kWarninngColor,
        margin: const EdgeInsets.only(top: kDefaultPadding),
        padding: const EdgeInsets.all(kDefaultPadding / 4),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: kDefaultPadding / 2),
              child: Icon(Icons.error_outline),
            ),
            Expanded(child: Text(_error!, maxLines: 3)),
            Padding(
              padding: const EdgeInsets.only(left: kDefaultPadding / 2),
              child: IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                showLoad
                    ? const LinearProgressIndicator(
                        backgroundColor: kPrimaryColor,
                        color: kSecondaryColor,
                        minHeight: 5,
                      )
                    : const SizedBox(),
                TextFormField(
                  validator: SignUpValidator.validateUsername,
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) => _username = value,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Username",
                    border: InputBorder.none,
                    filled: true,
                    fillColor: Colors.white38,
                    hintStyle: TextStyle(color: Colors.white),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: kDefaultPadding,
                      horizontal: kDefaultPadding,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: TextFormField(
                    obscureText: true,
                    style: const TextStyle(fontSize: 16, color: Colors.white),
                    validator: SignUpValidator.validatePassword,
                    onSaved: (value) => _password = value,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.white38,
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: kDefaultPadding,
                        horizontal: kDefaultPadding,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Spacer(flex: 2),
        showAlert(),
      ],
    );
  }
}
