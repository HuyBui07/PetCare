import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GlobalData {
  static String? displayName;
  static String? avatar;
}

Future<void> getUserData(String? email, String? avatar) async {
  DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('Users').doc(email).get();
  GlobalData.displayName = snapshot['name'];
  GlobalData.avatar = snapshot['avatar'];
}

Future<void> addUser(String? displayName, String? email, String? avatar) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String? email = auth.currentUser?.email.toString();
  users.doc(email).set({'name': displayName, 'email': email, 'avatar': avatar});
  return;
}
