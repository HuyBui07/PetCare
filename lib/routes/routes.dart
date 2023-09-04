import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcare_search/screens/add_detail_pet.dart';
import 'package:petcare_search/screens/appointmentScreen.dart';
import 'package:petcare_search/screens/editPro5_Screen.dart';
import 'package:petcare_search/screens/explore_screen.dart';
import 'package:petcare_search/screens/home_screen.dart';
import 'package:petcare_search/screens/loader_screen.dart';
import 'package:petcare_search/screens/mainSearch.dart';
import 'package:petcare_search/screens/petPro5_Screen.dart';
import 'package:petcare_search/screens/profile_Screen.dart';
import 'package:petcare_search/screens/reset_password.dart';

import 'package:petcare_search/screens/search_tks.dart';

import 'package:petcare_search/screens/registration.dart';

import 'package:petcare_search/screens/sign_in.dart';
import 'package:petcare_search/screens/welcome.dart';
import 'package:petcare_search/screens/welcome1.dart';
import 'package:petcare_search/screens/welcome2.dart';
import 'package:petcare_search/screens/welcome3.dart';

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
      case addpet:
        return MaterialPageRoute(
          builder: (_) => AddDetailPet(),
        );

      case thanks:
        return MaterialPageRoute(
          builder: (_) => SearchThanks(),
        );
      case registration:
        return MaterialPageRoute<Registration>(
          builder: (_) => Registration(),
        );
      case forgotpassword:
        return MaterialPageRoute<ForgotPassword>(
            builder: (_) => ForgotPassword());
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
  static const addpet = '/addpet';

  static const thanks = '/thanks';

  static const registration = '/registration';
  static const forgotpassword = '/forgotpassword';
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
