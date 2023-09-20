import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcare_search/models/user_model.dart';

import '../models/model_enums.dart';

class UserRepository {
  static final UserRepository _instance = UserRepository._internal();
  factory UserRepository() => _instance;
  static final db = FirebaseFirestore.instance;
  static UserModel? currentUser;
  UserRepository._internal() {
    // init things inside this
  }

  //Used to get currently logged in user. If null, no one is logged in
  static UserModel? GetCurrentUser() {
    if (currentUser == null) {
      print("[USER REPOS] Current user is null");
    }

    return currentUser;
  }
  //Does user exist in db?
  
  //Used to assign upon signup/login
  static Future<void> AssignCurrentUser(UserModel user) async {
    //Check if user exist in db
    if (await DoesUserWithUIDExist(user.uid)== false) {
      print("[USER REPOS] User with ${user.email}} not found for assignment");
      return;
    }
    currentUser = user;
    print("[USER REPOS] Current user assigned. Email: ${user.email}");
  }

  //Does user with UID exist?
  static Future<bool> DoesUserWithUIDExist(String uid) async {
    DocumentSnapshot querySnapshot =
        await db.collection("Users").doc (uid).get();

    return querySnapshot.exists;
  }

  //Remove user UID. Since only the user can request their own account removal.
  static Future<void> RemoveUserWithUID(String uid) async {
    //Check if user exist in db
    if (await DoesUserWithUIDExist(uid) == false) {
      print("[USER REPOS] User with ${uid}} not found for removal");
      return;
    }
    await db.collection("Users").doc(uid).delete();
    print("[USER REPOS] User with ${uid}} removed");
  }
  //Get user with UID
  static Future<UserModel?> GetUserWithUID(String uid) async {
    //Check if user exist
    DocumentSnapshot docSnap = await db.collection("Users").doc(uid).get();
    if (docSnap.exists) {
      // Convert Firestore data to Map
      Map<String, dynamic> userData = docSnap.data() as Map<String, dynamic>;

      // Pass the Map to UserModel.fromJson
      return UserModel.fromJson(userData);
    } else {
      print("[USER REPOS] User not found with UID");
      return null;
    }
  }
  //Get user mail with UID
  static Future<String?> GetUserMailWithUID(String uid) async {
    //Check if user exist
    DocumentSnapshot docSnap = await db.collection("Users").doc(uid).get();
    if (docSnap.exists) {
      // Convert Firestore data to Map
      Map<String, dynamic> userData = docSnap.data() as Map<String, dynamic>;

      // Pass the Map to UserModel.fromJson
      return userData["email"];
    } else {
      print("[USER REPOS] User not found with UID");
      return null;
    }
  }
  //Get user UID with mail. Mail should be unique so this should be safe.
  static Future<String?> GetUserUIDWithMail(String mail) async {
    //Check if user exist
    DocumentSnapshot docSnap = await db.collection("Users").where ("email", isEqualTo: mail).get().then((value) => value.docs.first);
    if (docSnap.exists) {
      // Convert Firestore data to Map
      Map<String, dynamic> userData = docSnap.data() as Map<String, dynamic>;

      // Pass the Map to UserModel.fromJson
      return userData["uid"];
    } else {
      print("[USER REPOS] User not found with UID");
      return null;
    }
  }

  //Get user Ref with UID
  static Future<DocumentReference> GetUserRefWithUID(String uid) async {
    //Check if user exist
    DocumentSnapshot docSnap = await db.collection("Users").doc(uid).get();
    if (docSnap.exists) {
      // Convert Firestore data to Map
      Map<String, dynamic> userData = docSnap.data() as Map<String, dynamic>;

      // Pass the Map to UserModel.fromJson
      return docSnap.reference;
    } else {
      print("[USER REPOS] User not found with UID");
      return Future.error("User not found with UID");
    }
  }
  //Get usermodel from database using a DocumentReference.
  static Future<UserModel?> GetUserWithReference(DocumentReference userRef) async {
    //Check if user exist
    DocumentSnapshot docSnap = await userRef.get();
    if (docSnap.exists) {
      // Convert Firestore data to Map
      Map<String, dynamic> userData = docSnap.data() as Map<String, dynamic>;

      // Pass the Map to UserModel.fromJson
      return UserModel.fromJson(userData);
    } else {
      print("[USER REPOS] User not found with reference");
      return null;
    }
  }

  
  //Add user to db. If they already exist, return error.
  static Future<void> AddUser(UserModel user) async {
    //UID as document name
    //If user already exist, print errors. Else, add user
    if (await DoesUserWithUIDExist(user.uid)) {
      print("[USER REPOS] User with ${user.uid} and ${user.email} already exist");
      return Future.error("User already exist");
    } else {
      //Add user
      await db.collection("Users").doc(user.uid).set(user.toJson());
      print("[USER REPOS] User with ${user.uid} and ${user.email} added");
      return Future.value(null);
    }
  }
  //Update user if they exist, if not return error.
  static Future<void> UpdateUser(UserModel user) async {
    //If user does not exist, print errors. Else, update user
    if (await DoesUserWithUIDExist(user.uid)) {
      //Update user
      await db.collection("Users").doc(user.uid).update(user.toJson());
      print("[USER REPOS] User with ${user.uid} and ${user.email} updated");
      return Future.value("Success");
    } else {
      print("[USER REPOS] User with ${user.uid} and ${user.email} does not exist");
      return Future.error("User does not exist");
    }
  }
  // AVOID USING THESE IF YOU ONLY WANT CURRENT USER DATA. LOGIN/ SIGN UP AND USE USE UID
  //
  //Get usermodel from database using email.
  //Scan through entire database.
  static Future<UserModel?> GetUserWithEmail({required String email , bool ignoreWarning = false}) async {
    //Check if user with email exist
    DocumentSnapshot docSnap = await db.collection("Users").where ("email", isEqualTo: email).get().then((value) => value.docs.first);
    if (docSnap.exists) {
      // Convert Firestore data to Map
      Map<String, dynamic> userData = docSnap.data() as Map<String, dynamic>;

      // Pass the Map to UserModel.fromJson
      return UserModel.fromJson(userData);
    } else {
      if (ignoreWarning == false)
      {
        print("[USER REPOS] User not found with email");
      }
      return null;
    }

  }
  //Get DocumentReference of user using email
  //Scan through entire database.
  static Future<DocumentReference> GetUserReferenceWithEmail(
      String email) async {
    DocumentSnapshot docSnap = await db.collection("Users").where ("email", isEqualTo: email).get().then((value) => value.docs.first);
    if (!docSnap.exists) {
      return Future.error("User not found with reference");
    }
    return docSnap.reference;
  }
}
