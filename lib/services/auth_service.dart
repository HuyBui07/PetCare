import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<UserCredential> googleLogIn() async {
  final googleSignIn = GoogleSignIn();
  final googleUser = await googleSignIn.signIn();

  final googleAuth = await googleUser?.authentication;

  final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

  return await FirebaseAuth.instance.signInWithCredential(credential);
}

Future<UserCredential> facebookLogin() async {
  final LoginResult result = await FacebookAuth.instance.login();
  final OAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(result.accessToken!.token);
  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}
