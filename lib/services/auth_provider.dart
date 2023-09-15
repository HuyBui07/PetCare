import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogProvider extends ChangeNotifier {
  bool loggedIn = false;

  bool get loggedState => loggedIn;

  signUp({required String email, required String password}) async {
    loggedIn = true;
    return await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  loggingInWithFaceBook() async {
    final LoginResult result = await FacebookAuth.instance.login();
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);
    loggedIn = true;
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  loggingInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();

    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
    loggedIn = true;

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  loggingInWithEmailAndPassword(
      {required String email, required String password}) async {
    loggedIn = true;
    return await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  loggingOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final providerId =
        FirebaseAuth.instance.currentUser!.providerData[0].providerId;

    if (providerId == 'google.com') {
      await googleSignIn.signOut();
      print('User signed out from Google');
    } else if (providerId == 'facebook.com') {
      await FacebookAuth.instance.logOut();
      print('User signed out from Facebook');
    }

    await FirebaseAuth.instance.signOut();

    loggedIn = false;
    notifyListeners();
  }
}
