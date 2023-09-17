import 'package:cloud_firestore/cloud_firestore.dart';

class VeterinaryList {
  static List<String> uids = [];
  static List<String> names = [];
  static getVeterinaries() async {
    var db = FirebaseFirestore.instance;
    var collectionRef = db.collection('Veterinaries');

    collectionRef.get().then((QuerySnapshot querySnapshot) => {
          querySnapshot.docs.forEach((doc) async {
            var uid = doc.id;
            uids.add(uid.toString());
            DocumentSnapshot snapshot = await FirebaseFirestore.instance
                .collection('Veterinaries')
                .doc(uid)
                .get();
            names.add(snapshot["name"]);
          })
        });
  }
}
