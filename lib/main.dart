import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petcare_search/appStyle.dart';
<<<<<<< HEAD
import 'package:petcare_search/screens/registration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
=======
import 'package:petcare_search/screens/add_detail_pet.dart';

import 'package:petcare_search/screens/appointmentScreen.dart';

import 'package:petcare_search/screens/editPro5_Screen.dart';
import 'package:petcare_search/screens/mainSearch.dart';
import 'package:petcare_search/screens/petPro5_Screen.dart';

import 'package:petcare_search/screens/profile_Screen.dart';
import 'package:petcare_search/screens/sign_in.dart';
import 'package:petcare_search/screens/welcome.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

>>>>>>> main
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
<<<<<<< HEAD
      home: const Registration(),
=======
      home: PetProfileScreen(),
>>>>>>> main
    );
  }
}
