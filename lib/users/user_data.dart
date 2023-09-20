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
  // FirebaseAuth auth = FirebaseAuth.instance;
  // GlobalData.id = auth.currentUser?.uid.toString();
  // DocumentSnapshot snapshot = await FirebaseFirestore.instance
  //     .collection('Users')
  //     .doc(GlobalData.id)
  //     .get();
  // GlobalData.displayName = snapshot['name'];
  // GlobalData.nickName = snapshot.data().toString().contains('nickName')
  //     ? snapshot['nickName']
  //     : '';
  // GlobalData.avatar = snapshot['avatar'];
  // GlobalData.email = snapshot['email'];
  // GlobalData.phone = snapshot.data().toString().contains('phoneNumber')
  //     ? snapshot['phoneNumber']
  //     : '';
  // GlobalData.gender = snapshot.data().toString().contains('gender')
  //     ? snapshot['gender'] == 'Gender.male'
  //         ? Gender.male
  //         : Gender.female
  //     : Gender.other;
  // GlobalData.about =
  //     snapshot.data().toString().contains('aboutMe') ? snapshot['aboutMe'] : '';

  //Get UID from auth -> Assign current user (if not already done) -> Get user data from db -> Assign to global data

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
  try 
  {
    //Assign user
  UserRepository.AssignCurrentUser(user);

  //Assign to global data
  GlobalData.displayName = user.name;
  GlobalData.nickName = "";
  
  GlobalData.email = user.email;
  GlobalData.about = user.aboutMe;
  GlobalData.gender = user.gender;
  GlobalData.phone = user.phoneNumber;
  GlobalData.avatar = user.avatarPath;
  print ("[USER DATA] User data assigned");
  }
  catch (e) {
    print("[USER DATA] Error: ${e.toString()}");
  }


  


}

Future<void> addUser(
    String? id, String? displayName, String? email, String? avatar) async {
  // bool isExisted = false;
  // final dataUsrs = await FirebaseFirestore.instance.collection('Users').get();
  // dataUsrs.docs.forEach((docs) => {
  //       if (docs.id == id) {isExisted = true}
  //     });
  // if (!isExisted) {
  //   CollectionReference users = FirebaseFirestore.instance.collection('Users');
  //   FirebaseAuth auth = FirebaseAuth.instance;
  //   String? email = auth.currentUser?.email.toString();
  //   users.doc(id).set({'name': displayName, 'email': email, 'avatar': avatar});
  // }
  // return;
  
  //Make an UserModel -> Add to database 
  UserModel user = UserModel (
    aboutMe: "Nothing yet~",
    uid: id!,
    name: displayName!,
    email: email!,
  );

  //Add user to db
  await UserRepository.AddUser(user);

  
}

Future updateUserData(String? userName, String? nickName, String? email,
    String? avt, Gender? gender, String? phone, String? about) async {
       // return await FirebaseFirestore.instance
  //     .collection('Users')
  //     .doc(GlobalData.id)
  //     .set({
  //   'name': userName,
  //   'nickName': nickName,
  //   'email': email,
  //   'avatar': avt,
  //   'gender': gender.toString(),
  //   'phoneNumber': phone,
  //   'aboutMe': about,
  // });

  UserModel newUser = UserModel 
  (
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
