import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future googleLogIn() async {
  final googleSignIn = GoogleSignIn();
  final googleUser = await googleSignIn.signIn();
  if (googleUser == null) return;

  final googleAuth = await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

  await FirebaseAuth.instance.signInWithCredential(credential);
}

Future facebookLogin() async {
  FacebookAuth.instance
      .login(permissions: ["public_profile", "email"]).then((value) {
    FacebookAuth.instance.getUserData().then((userData) async {});
  });
}
