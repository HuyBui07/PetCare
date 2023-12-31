import 'dart:io';
import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:petcare_search/models/model_enums.dart';
import 'package:petcare_search/models/pet_model.dart';
import 'package:petcare_search/models/review_model.dart';
import 'package:petcare_search/repository/petRepository.dart';
import 'package:petcare_search/repository/reviewRepository.dart';
import 'package:petcare_search/repository/userRepository.dart';
import 'package:petcare_search/users/gender.dart';

//Avatar is storage in firebase storage. With path: UserAvatar/{email}.png

class UserModel {
  String uid;
  String name;
  String nickName; //Optional
  String email;

  String avatarPath; //In URL
  Gender? gender;
  String? phoneNumber;
  String aboutMe;
  List<Review> reviews = [];

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    this.nickName = "",
    this.gender,
    required this.aboutMe,
    this.phoneNumber = "",
    this.avatarPath =
        "https://firebasestorage.googleapis.com/v0/b/petcarevz.appspot.com/o/UserAvatar%2FAmongUs.jpg?alt=media&token=b65158df-9acc-4626-8b28-345404eebfff", //default value
  }) {
    if (gender == null) {
      gender = Gender.other;
    }
  }

  Future<List<Pet>?> GetUserPets() async {
    List<Pet> pets = [];

    PetRepository.GetAllPetsByOwner(email).then((value) => pets = value!);
    print("[USER MODEL] Pets length: ${pets.length}");
    return pets;
  }

  Future<List<Review>?> GetAllReviews() async {
    List<Review> reviews = [];
    ReviewRepository.GetAllReviewsOfUser(email)
        .then((value) => reviews = value!);
    print("[USER MODEL] Reviews length: ${reviews.length}");
    return reviews;
  }

  Future<Pet?> GetPet(String name) async {
    Pet? pet = await PetRepository.GetPetFromOwner(name, email);
    if (pet == null) {
      print("[USER MODEL] Pet is null");
    }
    return pet;
  }

  //Get a review of a vet by user
  Future<Review?> GetReviewOfVet(String vetMail) async {
    Review? rev = await ReviewRepository.GetReviewOfVetByUserUsingMail(
        this.email, vetMail);
    if (rev == null) {
      print("[USER MODEL] Review is null");
    }
    return rev;
  }

  //Change avatar
  Future<void> ChangeAvatar(Image newAvatar) async {
    //Todo:: Implement avatar change
  }

  //Update information
  Future<void> UpdateUserInformation({
    String newName = "",
    String nickName = "",
    Gender gender = Gender.other,
    String newPhoneNumber = "",
    String newAboutMe = "",
  }) async {
    //If its empty or none, dont update. Otherwise change current value. Then send it to the db
    if (newName != "") {
      this.name = newName;
    }
    if (nickName != "") {
      this.name = nickName;
    }
    if (gender != Gender.other) {
      this.gender = gender;
    }
    if (newAboutMe != "") {
      this.aboutMe = newAboutMe;
    }
    if (newPhoneNumber != "") {
      this.phoneNumber = newPhoneNumber;
    }
    //Update to db
    await UserRepository.UpdateUser(this);
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'nickName': nickName,
      'email': email,
      'avatarPath': avatarPath,
      'gender': gender.toString(), // Assuming Gender is an enum
      'phoneNumber': phoneNumber,
      'aboutMe': aboutMe,
    };
  }
  //

  // Convert from json map to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    UserModel newUser = UserModel(
      uid: json.containsKey('uid') ? json['uid'] as String : "",
      avatarPath:
          json.containsKey('avatarPath') ? json['avatarPath'] as String : "",
      name: json.containsKey('name') ? json['name'] as String : "",
      nickName: json.containsKey('nickName') ? json['nickName'] as String : "",
      email: json.containsKey('email') ? json['email'] as String : "",
      gender: json.containsKey('gender')
          ? _parseGender(json['gender'] as String)
          : Gender.other,
      phoneNumber: json.containsKey('phoneNumber')
          ? json['phoneNumber'] as String?
          : null,
      aboutMe: json.containsKey('aboutMe') ? json['aboutMe'] as String : "",
    );
    if (json.containsKey('avatarPath')) {
      newUser.avatarPath = json['avatarPath'] as String;
    }
    return newUser;
  }

// Helper function to parse gender from string
  static Gender _parseGender(String genderString) {
    switch (genderString.toLowerCase()) {
      case 'gender.male':
        return Gender.male;
      case 'gender.female':
        return Gender.female;
      case 'gender.other':
        return Gender.other;
      default:
        return Gender.other; // Default to 'other' if invalid value
    }
  }
}
