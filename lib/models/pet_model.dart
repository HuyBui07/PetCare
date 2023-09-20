import 'dart:ui';

import 'package:petcare_search/repository/petRepository.dart';

import 'model_enums.dart';

//User can have multiple pet, they are not unique.
//Avatar is stored in firebase storage. With path: PetAvatar/{ownerMail}/{petName}.png
class Pet {
  String name;
  String? avatarPath;
  String ownerMail;
  String breed;
  PetSize size;
  bool isNeutered = false;
  bool isVaccinated = false;
  bool isFriendlyWithDog = false;
  bool isFriendlyWithCat = false;
  bool isFriendlyWithChildOlderThan10 = false;
  bool isFriendlyWithChildYoungerThan10 = false;
  bool isMicroChipped = false;
  bool purebreed = false;
  String? nurseryName;
  //Reminder[] reminders;
  Pet({
    required this.name,
    this.avatarPath,
    required this.ownerMail,
    required this.breed,
    required this.size,
    this.isNeutered = false,
    this.isVaccinated = false,
    this.isFriendlyWithDog = false,
    this.isFriendlyWithCat = false,
    this.isFriendlyWithChildOlderThan10 = false,
    this.isFriendlyWithChildYoungerThan10 = false,
    this.isMicroChipped = false,
    this.purebreed = false,
    this.nurseryName = "",
  });
  //Change avatar
  Future<void> ChangeAvatar(String newPath) async {
    //Todo:: implement change avatar
  }
  //Tojson
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'avatarPath': avatarPath,
      'ownerMail': ownerMail,
      'breed': breed,
      'size': size.toString(),
      'isNeutered': isNeutered,
      'isVaccinated': isVaccinated,
      'isFriendlyWithDog': isFriendlyWithDog,
      'isFriendlyWithCat': isFriendlyWithCat,
      'isFriendlyWithChildOlderThan10': isFriendlyWithChildOlderThan10,
      'isFriendlyWithChildYoungerThan10': isFriendlyWithChildYoungerThan10,
      'isMicroChipped': isMicroChipped,
      'purebreed': purebreed,
      'nurseryName': nurseryName,
    };
  }

  //Update pet on db
  Future<void> Update() async {
    await PetRepository.UpdatePet(this);
  }

  //From json to pet
  static Pet fromJsonToPet(Map<String, dynamic> petJson) {
    return Pet(
      name: petJson.containsKey('name') ? petJson['name'] as String : "",
      avatarPath: petJson.containsKey('avatarPath')
          ? petJson['avatarPath'] as String?
          : null,
      ownerMail: petJson.containsKey('ownerMail')
          ? petJson['ownerMail'] as String
          : "",
      breed: petJson.containsKey('breed') ? petJson['breed'] as String : "",
      size: petJson.containsKey('size')
          ? PetSize.values.firstWhere((g) => g.toString() == petJson['size'])
          : PetSize.small,
      isNeutered: petJson.containsKey('isNeutered')
          ? petJson['isNeutered'] as bool
          : false,
      isVaccinated: petJson.containsKey('isVaccinated')
          ? petJson['isVaccinated'] as bool
          : false,
      isFriendlyWithDog: petJson.containsKey('isFriendlyWithDog')
          ? petJson['isFriendlyWithDog'] as bool
          : false,
      isFriendlyWithCat: petJson.containsKey('isFriendlyWithCat')
          ? petJson['isFriendlyWithCat'] as bool
          : false,
      isFriendlyWithChildOlderThan10:
          petJson.containsKey('isFriendlyWithChildOlderThan10')
              ? petJson['isFriendlyWithChildOlderThan10'] as bool
              : false,
      isFriendlyWithChildYoungerThan10:
          petJson.containsKey('isFriendlyWithChildYoungerThan10')
              ? petJson['isFriendlyWithChildYoungerThan10'] as bool
              : false,
      isMicroChipped: petJson.containsKey('isMicroChipped')
          ? petJson['isMicroChipped'] as bool
          : false,
      purebreed: petJson.containsKey('purebreed')
          ? petJson['purebreed'] as bool
          : false,
      nurseryName: petJson.containsKey('nurseryName')
          ? petJson['nurseryName'] as String
          : "",
    );
  }
}
