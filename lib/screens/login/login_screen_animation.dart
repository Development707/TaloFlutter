import 'dart:math';

import 'package:flutter/material.dart';

import '../../plugin/constants.dart';
import 'components/sign_in_form.dart';
import 'components/sign_up_form.dart';
import 'components/socal_buttons.dart';

class LoginScreenAnimation extends StatefulWidget {
  const LoginScreenAnimation({Key? key}) : super(key: key);

  @override
  State<LoginScreenAnimation> createState() => _LoginScreenAnimationState();
}

class _LoginScreenAnimationState extends State<LoginScreenAnimation>
    with SingleTickerProviderStateMixin {
  bool _isShowSignUp = false;
  late AnimationController _animationController;
  late Animation<double> _animationTextRotate;

  GlobalKey<SignUpFormState> signUpKey = GlobalKey();
  GlobalKey<SignInFormState> signInKey = GlobalKey();

  void setUpAnimation() {
    _animationController =
        AnimationController(vsync: this, duration: kDefaultDuration);
    _animationTextRotate =
        Tween<double>(begin: 0, end: 90).animate(_animationController);
  }

  void updateView() {
    setState(() {
      _isShowSignUp = !_isShowSignUp;
    });
    _isShowSignUp
        ? _animationController.forward()
        : _animationController.reverse();
  }

  @override
  void initState() {
    super.initState();
    setUpAnimation();
    Future.delayed(Duration.zero, () => signInKey.currentState?.checkIsLogIn());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, _) {
            return Stack(
              children: [
                // Sign in
                AnimatedPositioned(
                  duration: kDefaultDuration,
                  width: _size.width * 0.9,
                  height: _size.height,
                  left: _isShowSignUp ? -_size.width * 0.8 : 0,
                  child: Container(
                    color: kPrimaryColor,
                    child: SignInForm(key: signInKey),
                  ),
                ),
                // Sign up
                AnimatedPositioned(
                    duration: kDefaultDuration,
                    height: _size.height,
                    width: _size.width * 0.9,
                    left: _isShowSignUp ? _size.width * 0.1 : _size.width * 0.9,
                    child: Container(
                      color: kSecondaryColor,
                      child: SignUpForm(key: signUpKey),
                    )),
                AnimatedPositioned(
                  duration: kDefaultDuration,
                  left: 0,
                  right: _isShowSignUp ? -_size.width * 0.1 : _size.width * 0.1,
                  top: _size.height * 0.1,
                  child: Image.asset("assets/images/talo.png", height: 70),
                ),
                AnimatedPositioned(
                  duration: kDefaultDuration,
                  top: _size.height * 0.7,
                  left: 0,
                  right: _isShowSignUp ? -_size.width * 0.1 : _size.width * 0.1,
                  child: const SocalButtons(),
                ),
                // Sign in text
                AnimatedPositioned(
                    duration: kDefaultDuration,
                    top: _isShowSignUp
                        ? _size.height / 2 + 80
                        : _size.height * 0.6,
                    left: _isShowSignUp
                        ? _size.width * 0.025 - 5
                        : _size.width * 0.45 - 90,
                    child: AnimatedDefaultTextStyle(
                      duration: kDefaultDuration,
                      style: TextStyle(
                        fontSize: _isShowSignUp ? 20 : 32,
                        fontWeight: FontWeight.bold,
                        color: _isShowSignUp ? Colors.white : Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                      child: Transform.rotate(
                        angle: -_animationTextRotate.value * pi / 180,
                        alignment: Alignment.topLeft,
                        child: InkWell(
                          onTap: () {
                            if (_isShowSignUp) {
                              updateView();
                            } else {
                              // Sign in here
                              signInKey.currentState!.onSubmit();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding / 3),
                            width: 160,
                            child: Text("Log In".toUpperCase()),
                          ),
                        ),
                      ),
                    )),
                // Sign Up text
                AnimatedPositioned(
                    duration: kDefaultDuration,
                    top: !_isShowSignUp
                        ? _size.height / 2 + 80
                        : _size.height * 0.6,
                    right: _isShowSignUp
                        ? _size.width * 0.45 - 90
                        : _size.width * 0.025 - 5,
                    child: AnimatedDefaultTextStyle(
                      duration: kDefaultDuration,
                      style: TextStyle(
                        fontSize: !_isShowSignUp ? 20 : 32,
                        fontWeight: FontWeight.bold,
                        color: _isShowSignUp ? Colors.white : Colors.white70,
                      ),
                      textAlign: TextAlign.center,
                      child: Transform.rotate(
                        angle: (90 - _animationTextRotate.value) * pi / 180,
                        alignment: Alignment.topRight,
                        child: InkWell(
                          onTap: () {
                            if (!_isShowSignUp) {
                              updateView();
                            } else {
                              // Sign Up here
                              signUpKey.currentState!.onSubmit();
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: kDefaultPadding / 3),
                            width: 160,
                            child: Text("Log Up".toUpperCase()),
                          ),
                        ),
                      ),
                    )),
              ],
            );
          }),
    );
  }
}
