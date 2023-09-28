import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petcare_search/models/user_model.dart';
import 'package:petcare_search/repository/userRepository.dart';
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
  if (GlobalData.id == null) {
    print("[USER DATA] User not logged in");
    return;
  }
  //Logged in already, can't be null. Get user data from db.
  UserModel? user = await UserRepository.GetUserWithUID(GlobalData.id!);

  //Adding to remove error. Shouldn't happen
  if (user == null) {
    print("[USER DATA] User not found in db");
    return;
  }
  try {
    //Assign user
    UserRepository.AssignCurrentUser(user);

    //Assign to global data
    GlobalData.displayName = user.name;
    GlobalData.nickName = user.nickName;

    GlobalData.email = user.email;
    GlobalData.about = user.aboutMe;
    GlobalData.gender = user.gender;

    print("[USER DATA] User data assigned");
  } catch (e) {
    print("[USER DATA] Error: ${e.toString()}");
  }

  GlobalData.phone = user.phoneNumber;
  GlobalData.avatar = user.avatarPath;
}

Future<void> addUser(
    String? id, String? displayName, String? email, String? avatar) async {
  if (id == null) {
    print("[USER DATA] User not logged in");
    return;
  }
  if (await UserRepository.DoesUserWithUIDExist(id)) {
    print("[USER DATA] User already exists");
    return;
  }
  //Make an UserModel -> Add to database
  UserModel user = UserModel(
    aboutMe: "Nothing yet~",
    uid: id,
    name: displayName!,
    email: email!,
  );
  user.avatarPath = avatar ??
      "https://firebasestorage.googleapis.com/v0/b/petcarevz.appspot.com/o/UserAvatar%2FAmongUs.jpg?alt=media&token=b65158df-9acc-4626-8b28-345404eebfff";
  //Add user to db
  await UserRepository.AddUser(user);
}

Future updateUserData(String? userName, String? nickName, String? email,
    String? avt, Gender? gender, String? phone, String? about) async {
  UserModel newUser = UserModel(
    name: userName!,
    nickName: nickName!,
    email: email!,
    gender: gender!,
    phoneNumber: phone!,
    aboutMe: about!,
    uid: GlobalData.id!,
  );
  newUser.avatarPath = avt!;
  await UserRepository.UpdateUser(newUser);
}
