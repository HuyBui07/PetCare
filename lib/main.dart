import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petcare_search/appStyle.dart';
import 'package:petcare_search/routes/routes.dart';
import 'package:petcare_search/screens/add_detail_pet.dart';

import 'package:petcare_search/screens/appointmentScreen.dart';

import 'package:petcare_search/screens/editPro5_Screen.dart';
import 'package:petcare_search/screens/explore_screen.dart';
import 'package:petcare_search/screens/home_screen.dart';
import 'package:petcare_search/screens/loader_screen.dart';
import 'package:petcare_search/screens/mainSearch.dart';
import 'package:petcare_search/screens/pastScreen.dart';
import 'package:petcare_search/screens/petPro5_Screen.dart';

import 'package:petcare_search/screens/profile_Screen.dart';
import 'package:petcare_search/screens/sign_in.dart';
import 'package:petcare_search/screens/upComingScreen.dart';
import 'package:petcare_search/screens/welcome.dart';
import 'package:petcare_search/screens/welcome1.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

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
      initialRoute: RouteGenerator.loading,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return CupertinoPageRoute(
                builder: (_) => LoaderScreen(), settings: settings);
          case 'loading':
            return CupertinoPageRoute(
                builder: (_) => LoaderScreen(), settings: settings);
          case 'welcome':
            return CupertinoPageRoute(
                builder: (_) => Welcome(), settings: settings);
          case 'signin':
            return CupertinoPageRoute(
                builder: (_) => SignIn(), settings: settings);
          case 'main':
            return CupertinoPageRoute(
                builder: (_) => MainScreen(), settings: settings);
          case 'search':
            return CupertinoPageRoute(
                builder: (_) => SearchMain(), settings: settings);
          case 'appoitment':
            return CupertinoPageRoute(
                builder: (_) => AppointmentScreen(), settings: settings);
          case 'explore':
            return CupertinoPageRoute(
                builder: (_) => ExploreScreen(), settings: settings);
          case 'pro5':
            return CupertinoPageRoute(
                builder: (_) => ProfileScreen(), settings: settings);
          case 'editpro5':
            return CupertinoPageRoute(
                builder: (_) => EditProfileScreen(), settings: settings);
        }
      },
      //home: LoaderScreen(),
    );
  }
}
