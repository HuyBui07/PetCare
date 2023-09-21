import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcare_search/pets/addpet_args.dart';
import 'package:petcare_search/pets/pet.dart';
import 'package:petcare_search/screens/profile_tab/add_detail_pet.dart';
import 'package:petcare_search/screens/appoinment_tab/appointmentScreen.dart';
import 'package:petcare_search/screens/profile_tab/editPro5_Screen.dart';
import 'package:petcare_search/screens/explore_screen.dart';
import 'package:petcare_search/screens/home_screen.dart';
import 'package:petcare_search/screens/profile_tab/loader_screen.dart';
import 'package:petcare_search/screens/search_tab/mainSearch.dart';
import 'package:petcare_search/screens/profile_tab/petPro5_Screen.dart';
import 'package:petcare_search/screens/profile_tab/profile_Screen.dart';
import 'package:petcare_search/screens/search_tab/vetenary_info.dart';
import 'package:petcare_search/screens/sign_methods/reset_password.dart';

import 'package:petcare_search/screens/search_tab/search_tks.dart';

import 'package:petcare_search/screens/sign_methods/registration.dart';
import 'package:petcare_search/screens/profile_tab/settings.dart';

import 'package:petcare_search/screens/sign_methods/sign_in.dart';
import 'package:petcare_search/screens/splash_screens/welcome.dart';
import 'package:petcare_search/screens/splash_screens/welcome1.dart';
import 'package:petcare_search/screens/splash_screens/welcome2.dart';
import 'package:petcare_search/screens/splash_screens/welcome3.dart';

class RouteGenerator {
  const RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case home:
        return MaterialPageRoute<MainScreen>(
          builder: (_) => MainScreen(
            index: 0,
          ),
        );
      case loading:
        return MaterialPageRoute<LoaderScreen>(
          builder: (_) => const LoaderScreen(),
        );
      case welcome:
        return MaterialPageRoute<Welcome>(
          builder: (_) => Welcome(),
        );
      case signin:
        return MaterialPageRoute<SignIn>(
          builder: (_) => const SignIn(),
        );
      case main:
        int index = args as int;
        return MaterialPageRoute(
          builder: (_) => MainScreen(
            index: index,
          ),
        );
      case search:
        return MaterialPageRoute<SearchMain>(
          builder: (_) => SearchMain(),
        );
      case appoitment:
        return MaterialPageRoute<AppointmentScreen>(
          builder: (_) => AppointmentScreen(),
        );
      case explore:
        return MaterialPageRoute<ExploreScreen>(
          builder: (_) => const ExploreScreen(),
        );
      case pro5:
        return MaterialPageRoute(
          builder: (_) => ProfileScreen(),
        );
      case editpro5:
        return MaterialPageRoute(
          builder: (_) => EditProfileScreen(),
        );
      case petpro5:
        return MaterialPageRoute(
          builder: (_) => PetProfileScreen(),
        );
      case petdetail:
        AddPetArgs addPetArgs = args as AddPetArgs;
        return MaterialPageRoute(
          builder: (_) => AddDetailPet(
            args: addPetArgs,
          ),
        );

      case thanks:
        return MaterialPageRoute(
          builder: (_) => SearchThanks(
            datePicked: DateTime.now(),
            timePicked: '10:20pm',
          ),
        );
      case registration:
        return MaterialPageRoute<Registration>(
          builder: (_) => Registration(),
        );
      case forgotpassword:
        return MaterialPageRoute<ForgotPassword>(
            builder: (_) => ForgotPassword());
      case settingsscreen:
        return MaterialPageRoute<Settings>(builder: (_) => SettingsScreen());
      case vetecard:
        return MaterialPageRoute<VeterinaryInfo>(
            builder: (_) => VeterinaryInfo());
      default:
        throw const RouteException("Route not found");
    }
  }

  static const home = '/';
  static const loading = 'loading';
  static const welcome = 'welcome';
  static const signin = 'signin';
  static const main = 'main';
  static const search = '/search';
  static const appoitment = '/appoitment';
  static const explore = '/explore';
  static const pro5 = '/pro5';
  static const editpro5 = '/editpro5';
  static const petpro5 = '/petpro5';
  static const petdetail = '/addpet';
  static const settingsscreen = '/settings';
  static const thanks = '/thanks';
  static const vetecard = '/vetenarycard';
  static const registration = '/registration';
  static const forgotpassword = '/forgotpassword';
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
