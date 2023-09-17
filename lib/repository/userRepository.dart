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
  static Future<bool> DoesUserExist(String userEmail) async {
    DocumentSnapshot docSnap = await db.collection("Users").doc(userEmail).get();

    return docSnap.exists;
  }
  //Used to assign upon signup/login
  static Future<void> AssignCurrentUser(UserModel user) async {
    //Check if user exist in db
    if (await DoesUserExist(user.email) == false) {
      print("[USER REPOS] User with ${user.email}} not found for assignment");
      return;
    }
    currentUser = user;
    print("[USER REPOS] Current user assigned. Email: ${user.email}");
  }

  //Remove user with email
  static Future<void> RemoveUserWithEmail(String email) async {
    //Check if user exist
    if (await GetUserWithEmail(email: email) == null) {
      print("[USER REPOS] User with ${email}} not found for removal");
      return Future.error(" User not found for removal");
    } else {
      //Remove user
      try {
        await db.collection("Users").doc(email).delete();
        print("[USER REPOS] User with ${email}} removed");
      } catch (e) {
        print(e);
      }
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

  //Get usermodel from database using email.
  static Future<UserModel?> GetUserWithEmail({required String email , bool ignoreWarning = false}) async {
    DocumentSnapshot docSnap = await db.collection("Users").doc(email).get();
    if (docSnap.exists) {
      // Convert Firestore data to Map
      Map<String, dynamic> userData = docSnap.data() as Map<String, dynamic>;

      // Pass the Map to UserModel.fromJson
      print ("[USER REPOS] User found with email");
      return UserModel.fromJson(userData);
    } else {
      print("[USER REPOS] User not found with email");
      return null;
    }
  }
  //Get DocumentReference of user using email
  static Future<DocumentReference> GetUserReferenceWithEmail(
      String email) async {
    DocumentSnapshot docSnap = await db.collection("Users").doc(email).get();
    if (!docSnap.exists) {
      return Future.error("User not found with reference");
    }
    return docSnap.reference;
  }
  //Add user to db. If they already exist, return error.
  static Future<void> AddUser(UserModel user) async {
    //If user already exist, print errors. Else, add user
    if (await GetUserWithEmail(email :user.email) != null) {
      print("[USER REPOS - ADD USER] User with ${user.email}} already exist");
      return Future.error("User already exist");
    } else {
      //Create user
      await db.collection("Users").doc(user.email).set(user.toJson());
      print("[USER REPOS - ADD USER]User with ${user.email}} added");
      return Future.value(null);
    }
  }
  //Update user if they exist, if not return error.
  static Future<void> UpdateUser(UserModel user) async {
    //If user already exist, print errors. Else, update user
    if (await GetUserWithEmail(email :user.email) == null) {
      print("[USER REPOS] User with ${user.email}} not found for update");
      return Future.error("User not found for update");
    } else {
      //Update user
      await db.collection("Users").doc(user.email).update(user.toJson());
      print("[USER REPOS] User with ${user.email}} updated");
      return Future.value(null);
    }
  }
}
