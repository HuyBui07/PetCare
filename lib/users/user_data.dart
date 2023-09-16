import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'gender.dart';

class GlobalData {
  static String? id;
  static String? displayName;
  static String? nickName;
  static String? avatar;
  static String? email;
  static String? phone;
  static Gender? gender;
  static String? about;
}

// FirebaseAuth auth = FirebaseAuth.instance;
// String? id = auth.currentUser?.uid.toString();

Future<void> getUserData() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  GlobalData.id = auth.currentUser?.uid.toString();
  DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection('Users')
      .doc(GlobalData.id)
      .get();
  GlobalData.displayName = snapshot['name'];
  GlobalData.nickName = snapshot.data().toString().contains('nickName')
      ? snapshot['nickName']
      : '';
  GlobalData.avatar = snapshot['avatar'];
  GlobalData.email = snapshot['email'];
  GlobalData.phone = snapshot.data().toString().contains('phoneNumber')
      ? snapshot['phoneNumber']
      : '';
  GlobalData.gender = snapshot.data().toString().contains('gender')
      ? snapshot['gender'] == 'Gender.male'
          ? Gender.male
          : Gender.female
      : Gender.other;
  GlobalData.about =
      snapshot.data().toString().contains('aboutMe') ? snapshot['aboutMe'] : '';
}

Future<void> addUser(
    String? id, String? displayName, String? email, String? avatar) async {
  bool isExisted = false;
  final dataUsrs = await FirebaseFirestore.instance.collection('Users').get();
  dataUsrs.docs.forEach((docs) => {
        if (docs.id == id) {isExisted = true}
      });
  if (!isExisted) {
    CollectionReference users = FirebaseFirestore.instance.collection('Users');
    FirebaseAuth auth = FirebaseAuth.instance;
    String? email = auth.currentUser?.email.toString();
    users.doc(id).set({'name': displayName, 'email': email, 'avatar': avatar});
  }
  return;
}

Future updateUserData(String? userName, String? nickName, String? email,
    String? avt, Gender? gender, String? phone, String? about) async {
  return await FirebaseFirestore.instance
      .collection('Users')
      .doc(GlobalData.id)
      .set({
    'name': userName,
    'nickName': nickName,
    'email': email,
    'avatar': avt,
    'gender': gender.toString(),
    'phoneNumber': phone,
    'aboutMe': about,
  });
}
