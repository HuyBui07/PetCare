import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petcare_search/appStyle.dart';
import 'package:petcare_search/screens/add_detail_pet.dart';

import 'package:petcare_search/screens/appointmentScreen.dart';

import 'package:petcare_search/screens/editPro5_Screen.dart';
import 'package:petcare_search/screens/mainSearch.dart';

import 'package:petcare_search/screens/profileScreen.dart';
import 'package:petcare_search/screens/sign_in.dart';
import 'package:petcare_search/screens/welcome.dart';

import 'firebase_options.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
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

      home: SearchMain(),


    );
  }
}
