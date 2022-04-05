import 'package:flutter/material.dart';

import '../../../plugin/constants.dart';
import '../../../services/auth_socal_service.dart';
import '../../../services/dio/dio_auth_service.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUpForm> createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final formKey = GlobalKey<FormState>();
  DioAuth client = DioAuth();
  bool showOtp = false, showLoad = false;
  String? _phone, _otp, _password, _error;

  void onSubmit() {
    final form = formKey.currentState;
    form!.save();
    if (form.validate()) {
      if (_otp != null && _password != null && _phone != null) {
        setState(() => showLoad = true);
        verifyOTP(verificationIdResult, _otp.toString())
            .then((value) => getIdToken().then((idToken) {
                  client
                      .loginFirebasePhone(idToken, _password.toString())
                      .then((token) {
                        form.reset();
                        setState(() => showOtp = false);
                      })
                      .catchError((e) => _error = e)
                      .whenComplete(() => setState(() => showLoad = false));
                }))
            .catchError((e) {
          _error = e.message;
          setState(() => showLoad = false);
        });
      }
      if (_otp == null && _password == null && _phone != null) {
        signUpWithPhoneNumber('+84' + _phone.toString())
            .then((value) => {})
            .catchError((e) => _error = e.message)
            .whenComplete(() => setState(() => showOtp = true));
      }
    }
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
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
              children: [
                // Phone number field
                TextFormField(
                  validator: SignUpValidator.validatePhone,
                  keyboardType: TextInputType.phone,
                  onSaved: (value) => _phone = value,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                  decoration: const InputDecoration(
                    hintText: "Phone number",
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
                // OTP field
                showOtp
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: kDefaultPadding),
                        child: TextFormField(
                          validator: SignUpValidator.validateOtp,
                          keyboardType: TextInputType.number,
                          onSaved: (value) => _otp = value,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                          decoration: const InputDecoration(
                            hintText: "OTP",
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
                      )
                    : const SizedBox(height: 0),
                // Password field
                showOtp
                    ? TextFormField(
                        validator: SignUpValidator.validatePassword,
                        obscureText: true,
                        onSaved: (value) => _password = value,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: "Password",
                          border: InputBorder.none,
                          filled: true,
                          fillColor: Colors.white38,
                          hintStyle: TextStyle(color: Colors.white),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: kDefaultPadding,
                            horizontal: kDefaultPadding,
                          ),
                        ),
                      )
                    : const SizedBox(height: 0),
                showLoad
                    ? const LinearProgressIndicator(
                        backgroundColor: kPrimaryColor,
                        color: kSecondaryColor,
                        minHeight: 5,
                      )
                    : const SizedBox(),
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
