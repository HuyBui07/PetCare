import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:petcare_search/models/veterinary_model.dart';

class VeterinaryRepository {
  static List<String> vetsNames = [];

  static final VeterinaryRepository _instance =
      VeterinaryRepository._internal();
  factory VeterinaryRepository() => _instance;
  static final db = FirebaseFirestore.instance;

  //Todo: Implement security
  VeterinaryRepository._internal() {
    // init things inside this
  }

  //Get vets names
  static GetVetsNames() async {
    try {
      final vetCollection = await db.collection("Veterinaries").get();
      vetCollection.docs.forEach((element) {
        vetsNames.add(Veterinary.fromJson(element.data()).name);
      });
    } catch (e) {
      print(e);
    }
  }

  //Get all vets
  static Future<List<Veterinary>> GetAllVets() async {
    List<Veterinary> vets = [];
    try {
      final vetCollection = await db.collection("Veterinaries").get();
      vetCollection.docs.forEach((element) {
        vets.add(Veterinary.fromJson(element.data()));
      });
    } catch (e) {
      print(e);
    }
    return vets;
  }

  //Add vet. Check if exist, if not, add. If yes, return error
  static Future<void> AddVet(Veterinary vet) async {
    //Check if vet exist
    if (await GetVeterinaryWithEmail(vet.vetMail) != null) {
      return Future.error("Vet already exist");
    } else {
      //Add vet
      try {
        await db.collection("Veterinaries").doc(vet.vetMail).set(vet.toJson());
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<void> UpdateVet(Veterinary vet) async {
    //Check if vet exist
    if (await GetVeterinaryWithEmail(vet.vetMail) == null) {
      return Future.error("Vet not found");
    } else {
      //Update vet
      try {
        await db
            .collection("Veterinaries")
            .doc(vet.vetMail)
            .update(vet.toJson());
      } catch (e) {
        print(e);
      }
    }
  }

  //Get ref with email
  static Future<DocumentReference> GetVetReferenceWithEmail(
      String email) async {
    DocumentSnapshot docSnap =
        await db.collection("Veterinaries").doc(email).get();
    if (!docSnap.exists) {
      return Future.error("Vet not found");
    }
    return docSnap.reference;
  }

  //Get vet
  static Future<DocumentReference> GetVetReference(Veterinary vet) async {
    DocumentSnapshot docSnap =
        await db.collection("Veterinaries").doc(vet.vetMail).get();
    return docSnap.reference;
  }

  //Get vets within X km of location

  //Get vet by mail.
  static Future<Veterinary?> GetVeterinaryWithEmail(String email) async {
    DocumentSnapshot docSnap =
        await db.collection("Veterinaries").doc(email).get();
    if (docSnap.exists) {
      // Convert Firestore data to Map
      Map<String, dynamic> vetData = docSnap.data() as Map<String, dynamic>;

      // Pass the Map to UserModel.fromJson
      return Veterinary.fromJson(vetData);
    } else {
      return null;
    }
  }

  //Get vet by ref
  static Future<Veterinary?> GetVeterinaryWithReference(
      DocumentReference vetRef) async {
    //Check if user exist
    DocumentSnapshot docSnap = await vetRef.get();
    if (docSnap.exists) {
      // Convert Firestore data to Map
      Map<String, dynamic> vetData = docSnap.data() as Map<String, dynamic>;

      // Pass the Map to UserModel.fromJson
      return Veterinary.fromJson(vetData);
    } else {
      return null;
    }
  }

  static Future<bool> DoesVetExist(String email) async {
    DocumentSnapshot docSnap =
        await db.collection("Veterinaries").doc(email).get();
    return docSnap.exists;
  }
}
