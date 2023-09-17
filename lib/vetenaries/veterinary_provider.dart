import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VetenaryProvider {
  static String? id;
  static String? name;
  static String? avatar;
  static String? email;
  static String? specialty;
  static String? location;
  static int? price;
  static String? bio;
  static String? edu;
  static String? experience;
  static String? info;
}

Future<void> getVetenaryData() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  VetenaryProvider.id = auth.currentUser?.uid.toString();
  DocumentSnapshot snapshot = await FirebaseFirestore.instance
      .collection('Vetenaries')
      .doc(VetenaryProvider.id)
      .get();
  VetenaryProvider.name = snapshot['name'];
  VetenaryProvider.avatar = snapshot['imagePath'];
  VetenaryProvider.email = snapshot['email'];
  VetenaryProvider.specialty = snapshot['specialty'];
  VetenaryProvider.location = snapshot['location'];
  VetenaryProvider.price = snapshot['price'];
  VetenaryProvider.bio = snapshot['biography'];
  VetenaryProvider.edu = snapshot['educationIntroduction'];
  VetenaryProvider.experience = snapshot['professionalExperience'];
  VetenaryProvider.info = snapshot['personalExperience'];
}
