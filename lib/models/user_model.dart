import 'dart:ui';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:petcare_search/models/model_enums.dart';
import 'package:petcare_search/models/pet_model.dart';
import 'package:petcare_search/models/review_model.dart';
import 'package:petcare_search/repository/petRepository.dart';
import 'package:petcare_search/repository/reviewRepository.dart';
import 'package:petcare_search/repository/userRepository.dart';

//Avatar is storage in firebase storage. With path: UserAvatar/{email}.png



class UserModel {
  String uid;
  String name;
  String email;
  late String imagePath = "UserAvatar/$email.png";
  Gender gender;
  String? phoneNumber;
  String aboutMe;
  List<Review> reviews = [];
  
  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.gender,
    required this.aboutMe,
    this.phoneNumber = "",
  })
  {
    imagePath = "UserAvatar/AmongUs.jpg";
  }
  
  Future<List<Pet>?> GetUserPets() async 
  {
    List<Pet> pets = [];

    PetRepository.GetAllPetsByOwner (email).then((value) => pets = value!);
    print ("[USER MODEL] Pets length: ${pets.length}");
    return pets;
  }
  Future<List<Review>?> GetAllReviews () async 
  {
    List<Review> reviews = [];
    ReviewRepository.GetAllReviewsOfUser( email).then((value) => reviews = value!);
    print ("[USER MODEL] Reviews length: ${reviews.length}");
    return reviews;
  }
  Future<Pet?> GetPet(String name) async
  {
    Pet? pet = await PetRepository.GetPetFromOwner(name, email);
    if (pet == null)
    {
      print ("[USER MODEL] Pet is null");
    }
    return pet;
  }
  //Get a review of a vet by user
  Future<Review?> GetReviewOfVet(String vetMail) async
  {

    Review? rev = await ReviewRepository.GetReviewOfVetByUserUsingMail(this.email, vetMail);
    if (rev == null)
    {
      print ("[USER MODEL] Review is null");

    }
    return rev;
  }
  //Change avatar
  Future<void> ChangeAvatar(Image newAvatar) async
  {
     //Todo:: Implement avatar change
     
  }

  //Update information
  Future<void> UpdateUserInformation(
    {
      String newName = "",
      Gender gender = Gender.none,
      String newPhoneNumber = "",
      String newAboutMe = "",
    }
  ) async
  {
    //If its empty or none, dont update. Otherwise change current value. Then send it to the db
    if (newName != "") {
      this.name = newName;
    }
    if (gender != Gender.none)
    {
      this.gender = gender;
    }
    if (newAboutMe != "")
    {
      this.aboutMe = newAboutMe;
    }
    if (newPhoneNumber != "")
    {
      this.phoneNumber = newPhoneNumber;
    }
    //Update to db
    await UserRepository.UpdateUser(this);
  }
  
  
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'imagePath': imagePath,
      'gender': gender.toString(), // Assuming Gender is an enum
      'phoneNumber': phoneNumber,
      'aboutMe': aboutMe,
      
    };
  }
  //



  //Convert from json map to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
  return UserModel(
    uid: json.containsKey('uid') ? json['uid'] as String : "",
    name: json.containsKey('name') ? json['name'] as String : "",
    email: json.containsKey('email') ? json['email'] as String : "",
    gender: json.containsKey('gender')
        ? Gender.values.firstWhere((g) => g.toString() == json['gender'])
        : Gender.male, // Provide a default value or handle missing gender
    phoneNumber: json.containsKey('phoneNumber') ? json['phoneNumber'] as String? : null,
    aboutMe: json.containsKey('aboutMe') ? json['aboutMe'] as String : "",
    
  );
}
}



