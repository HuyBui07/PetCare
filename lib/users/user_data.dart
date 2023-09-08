import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GlobalData {
  static String? displayName;
  static String? nickName;
  static String? avatar;
  static String? email;
  static String? phone;
  static String? gender;
  static String? about;
}

Future<void> getUserData(String? email, String? avatar) async {
  DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('Users').doc(email).get();
  GlobalData.displayName = snapshot['name'];
  GlobalData.nickName = snapshot.data().toString().contains('nickname')
      ? snapshot['nickname']
      : '';
  GlobalData.avatar = snapshot['avatar'];
  GlobalData.email = snapshot['email'];
  GlobalData.phone =
      snapshot.data().toString().contains('phone') ? snapshot['phone'] : '';
  GlobalData.gender =
      snapshot.data().toString().contains('gender') ? snapshot['gender'] : '';
  GlobalData.about =
      snapshot.data().toString().contains('about') ? snapshot['about'] : '';
}

Future<void> addUser(String? displayName, String? email, String? avatar) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String? email = auth.currentUser?.email.toString();
  users.doc(email).set({'name': displayName, 'email': email, 'avatar': avatar});
  return;
}

Stream getUserData2 = FirebaseFirestore.instance
    .collection('Users')
    .doc(GlobalData.email)
    .snapshots();

Future updateUserData(String? userName, String? nickName, String? email,
    String? avt, String? gender, String? phone, String? about) async {
  return await FirebaseFirestore.instance.collection('Users').doc(email).set({
    'name': userName,
    'nickname': nickName,
    'email': email,
    'avatar': avt,
    'gender': gender,
    'phone': phone,
    'about': about,
  });
}
