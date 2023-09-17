import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petcare_search/models/user_model.dart';
import 'package:petcare_search/repository/userRepository.dart';

import '../models/model_enums.dart';
import '../models/pet_model.dart';

class PetRepository {
  static final PetRepository _instance = PetRepository._internal();
  factory PetRepository() => _instance;
  static final db = FirebaseFirestore.instance;
  PetRepository._internal() {
    // init things inside this
  }

  Future<List<Pet>> GetCurrentUserPets() async {
    List<Pet> pets = [];
    UserModel? currentUser = UserRepository.GetCurrentUser();
    if (currentUser == null) { //Not assigned yet
      return Future.error("User not found");
    } else //Assigned
      try {
        final petCollection = await db
            .collection("Pets")
            .where("ownerMail", isEqualTo: currentUser.email)
            .get();
        petCollection.docs.forEach((element) {
          pets.add(Pet.fromJsonToPet(element.data()));
        });
      } catch (e) {
        print(e);
      }
    return pets;
  }

  static Future<List<Pet>?> GetAllPetsByOwner(String ownerMail) async {
    List<Pet> pets = [];
    if (ownerMail == "") {
      return Future.error("Owner mail is empty");
    }
    try {
      final petCollection = await db
          .collection("Pets")
          .where("ownerMail", isEqualTo: ownerMail)
          .get();
      petCollection.docs.forEach((element) {
        pets.add(Pet.fromJsonToPet(element.data()));
      });
    } catch (e) {
      print(e);
    }
    return pets;
  }

  static Future<Pet?> GetPetFromOwner(
      String petName, String ownerMail) async {
    //if context is null, dont show snackbar
    try {
      DocumentReference petRef = await db
          .collection("Pets")
          .doc(ownerMail)
          .collection("Pets")
          .doc(petName);
      DocumentSnapshot petSnapshot = await petRef.get();
      if (await !petSnapshot.exists) {
        print("[PET REPOS] Pet not found");
        return Future.value();
      } else {
        //Convert data to json then pet
        Map<String, dynamic> petData =
            petSnapshot.data() as Map<String, dynamic>;
        Pet pet = Pet.fromJsonToPet(petData);

        return pet;
      }
    } catch (error) {
      // Show a snackbar on error
      print("[PET REPOS] Failed to get pet: $error");
      return null;
    }
  }

  static Future<void> AddPetToOwner(
      Pet pet, UserModel owner) async {
    //Check if owner exist on db, if they dont, show snack bar error user not exist. Else, add to them
    DocumentReference docRef = await db.collection("Users").doc(owner.email);
    DocumentSnapshot docSnap = await docRef.get();

    if (!docSnap.exists) {
      print("[PET REPOS] User not found");
      return Future.error("User not found");
    } else {
      try {
        //Add pet to owner
        pet.ownerMail = owner.email;
        String ownerMail = owner.email;

        //Check if path exist first, if not create it. Then add it
        DocumentReference petRef = await db
            .collection("Pets")
            .doc(ownerMail)
            .collection("Pets")
            .doc(pet.name);
        DocumentSnapshot petSnapshot = await petRef.get();
        if (await !petSnapshot.exists) {
          await db
              .collection("Pets")
              .doc(ownerMail)
              .collection("Pets")
              .doc(pet.name)
              .set(pet.toJson());
          
            content: Text("Pet Added");
        } else {
          await docRef.update(pet.toJson());
          print ("[PET REPOS] Pet already exist, updated");
        }
        return Future.value();
      } catch (error) {
        // Show a snackbar on error
        print ("[PET REPOS] Failed to add pet: $error");
      }
    }
  }
  //Add pet using mail
  static Future<void> AddPetToOwnerUsingMail(
      Pet pet, String ownerMail) async {
    //Check if owner exist on db, if they dont, show snack bar error user not exist. Else, add to them
    DocumentReference docRef = await db.collection("Users").doc(ownerMail);
    DocumentSnapshot docSnap = await docRef.get();

    if (!docSnap.exists) {
      print("[PET REPOS] User not found");
      return Future.error("User not found");
    } else {
      try {
        //Add pet to owner
        pet.ownerMail = ownerMail;

        //Check if path exist first, if not create it. Then add it
        DocumentReference petRef = await db
            .collection("Pets")
            .doc(ownerMail)
            .collection("Pets")
            .doc(pet.name);
        DocumentSnapshot petSnapshot = await petRef.get();
        if (await !petSnapshot.exists) {
          await db
              .collection("Pets")
              .doc(ownerMail)
              .collection("Pets")
              .doc(pet.name)
              .set(pet.toJson());
          print("[PET REPOS] Pet added");
        } else {
          await docRef.update(pet.toJson());
          print ("[PET REPOS] Pet already exist, updated");
        }
        return Future.value();
      } catch (error) {
        // Show a snackbar on error
        print ("[PET REPOS] Failed to add pet: $error");
      }
    }
  }
  //Update pet
  static Future<void> UpdatePet(Pet pet) async
  {
    //If pet doesnt exist, return error. Else, update it
    if (await GetPetFromOwner(pet.name, pet.ownerMail) == null)
    {
      return Future.error("Pet not found");
    }
    else
    {
      try {
        //Update pet
        db.collection("Pets").doc(pet.ownerMail).collection("Pets").doc(pet.name).update(pet.toJson());
        print ("[PET REPOS] Pet updated");
        return Future.value();
      } catch (error) {
        // Show a snackbar on error
        print ("[PET REPOS] Failed to update pet: $error");

      }
    }
  }

  //Remove pet from owner using mail
  static Future<void> RemovePetFromOwner(
      String petName, String ownerMail) async {
    try {
      //Check if it exist, if not , use snackbar to alert. Else, remove it
      DocumentReference petRef = await db
          .collection("Pets")
          .doc(ownerMail)
          .collection("Pets")
          .doc(petName);
      DocumentSnapshot petSnapshot = await petRef.get();
      if (await !petSnapshot.exists) {
        print("[PET REPOS] Pet not found");
        return Future.error("Pet not found");
      } else {
        await petRef.delete();
        print("[PET REPOS] Pet of $ownerMail with $petName removed");
        return Future.value();
      }
    } catch (error) {
      // Show a snackbar on error
      print("[PET REPOS] Failed to remove pet: $error");
    }
  }
}

  // //Test function that add to current user a pet
  
 
