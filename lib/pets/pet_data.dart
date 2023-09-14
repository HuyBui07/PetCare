import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:petcare_search/pets/pet.dart';
import 'package:petcare_search/pets/size.dart';
import 'package:petcare_search/users/user_data.dart';

// Future getPetData(String owner) async {
//   DocumentSnapshot snapshot =
//       await FirebaseFirestore.instance.collection('Pets').doc(owner).get();
// }

// Stream<Object> getPetData = FirebaseFirestore.instance
//     .collection('Pets')
//     .doc(GlobalData.email)
//     .collection('Pets')
//     .snapshots();

Future getPetDetail(String petName, MyPet pet) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? email = auth.currentUser?.email.toString();

  DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection('Pets')
      .doc(email)
      .collection('Pets')
      .doc(petName)
      .get();
  return;
}

Future<void> addPet(MyPet mypet) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? email = auth.currentUser?.email.toString();

  FirebaseFirestore.instance
      .collection('Pets')
      .doc(email)
      .collection('Pets')
      .doc()
      .set({
    'imgPath': mypet.imgPath,
    'name': mypet.name,
    'species': mypet.species,
    'breed': mypet.breed,
    'size': mypet.size.toString(),
    'gender': mypet.gender.toString(),
    'dob': mypet.dob,
    'isNeutered': mypet.isneutered,
    'isVaccinated': mypet.isvaccinated,
    'isFwd': mypet.isfwd,
    'isFwc': mypet.isfwc,
    'isFwkl': mypet.isfwkl,
    'isFwkm': mypet.isfwkm,
    'isMicrochipped': mypet.ismicrochipped,
    'isPurebred': mypet.ispurebred,
    'nursename': mypet.nursename,
  });
  return;
}

Future<void> updatePet(MyPet mypet) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String? email = auth.currentUser?.email.toString();

  FirebaseFirestore.instance
      .collection('Pets')
      .doc(email)
      .collection('Pets')
      .doc(mypet.id)
      .update({
    'imgPath': mypet.imgPath,
    'name': mypet.name,
    'species': mypet.species,
    'breed': mypet.breed,
    'size': mypet.size.toString(),
    'gender': mypet.gender.toString(),
    'dob': mypet.dob,
    'isNeutered': mypet.isneutered,
    'isVaccinated': mypet.isvaccinated,
    'isFwd': mypet.isfwd,
    'isFwc': mypet.isfwc,
    'isFwkl': mypet.isfwkl,
    'isFwkm': mypet.isfwkm,
    'isMicrochipped': mypet.ismicrochipped,
    'isPurebred': mypet.ispurebred,
    'nursename': mypet.nursename,
  });
  return;
}

// Future _getPetData() async {
//   var data = await collection.get();
//   data.docs.forEach((element) {
//     tempList.add(element.data());
//   });
// }
