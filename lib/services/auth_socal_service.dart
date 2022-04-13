import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

var verificationIdResult = '';
var confirmationResult;

Future<UserCredential> signInWithFacebook() async {
  if (kIsWeb) {
    FacebookAuthProvider facebookProvider = FacebookAuthProvider();
    facebookProvider.addScope('email');
    facebookProvider.setCustomParameters({
      'display': 'popup',
    });
    return await FirebaseAuth.instance.signInWithPopup(facebookProvider);
  }
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(loginResult.accessToken!.token);

  // Once signed in, return the UserCredential
  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}

Future<UserCredential> signInWithGoogle() async {
  if (kIsWeb) {
    var googleProvider = GoogleAuthProvider();
    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  } else {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
  // Once signed in, return the UserCredential
}

Future<void> signUpWithPhoneNumber(phoneNumber) async {
  if (kIsWeb) {
    confirmationResult =
        await FirebaseAuth.instance.signInWithPhoneNumber(phoneNumber);
  } else {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          // Sign the user in (or link) with the auto-generated credential
          await FirebaseAuth.instance.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          throw e;
        },
        codeSent: (String verificationId, int? resendToken) {
          verificationIdResult = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          // Auto-resolution timed out...
        });
  }
}

Future<UserCredential> verifyOTP(String verificationId, String smsCode) async {
  if (kIsWeb) {
    return await confirmationResult.confirm(smsCode);
  } else {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

Future<String> getIdToken() async {
  return await FirebaseAuth.instance.currentUser!.getIdToken();
}

Future<void> signOut() async {
  await FirebaseAuth.instance.signOut();
  await GoogleSignIn().disconnect();
}

User? getUserFirebase() {
  return FirebaseAuth.instance.currentUser;
}

class SignUpValidator {
  static const emailRegex =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static const phoneRegex = r"^([0])+([3|5|7|8|9])+([0-9]{8})\b";
  static const nameRegex = r"^\w{1,50}";

  static String? validateEmail(String? email) {
    if (email!.isEmpty) return "Email not empty.";
    if (RegExp(emailRegex).hasMatch(email)) {
      return "Email is not a valid email.";
    }
    return null;
  }

  static String? validatePhone(String? phone) {
    if (phone!.isEmpty) return "Phone not empty.";
    if (!RegExp(phoneRegex).hasMatch(phone)) {
      return "Phone is not a valid phone";
    }
    return null;
  }

  static String? validateUsername(String? username) {
    if (username!.isEmpty) return "Username not empty.";
    if (!RegExp(phoneRegex).hasMatch(username) &&
        !RegExp(emailRegex).hasMatch(username)) {
      return "Username is not a valid phone or email address.";
    }
    return null;
  }

  static String? validateOtp(String? otp) {
    if (otp!.isEmpty) return "OTP not empty.";
    if (otp.length != 6) {
      return "OTP is not a valid 6 character";
    }
    return null;
  }

  static String? validateName(String? name) {
    if (name!.isEmpty) return "Name not empty.";
    if (RegExp(nameRegex).hasMatch(name)) {
      return "Name is not a valid phone";
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password!.isEmpty) return "Password not empty.";
    if (password.length > 50 || password.length < 8) {
      return "Password is not a valid 8 - 50 character";
    }
    return null;
  }
}
