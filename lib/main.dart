import 'package:flutter/material.dart';
import 'package:petcare_search/appStyle.dart';
import 'package:petcare_search/screens/add_detail_pet.dart';
import 'package:petcare_search/screens/appointmentScreen.dart';
import 'package:petcare_search/screens/profileScreen.dart';
import 'package:petcare_search/screens/sign_in.dart';
import 'package:petcare_search/screens/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Balls',
      theme: AppTheme,
      home: AddDetailPet()
    );
  }
}
