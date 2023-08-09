import 'package:flutter/material.dart';
import 'package:petcare_search/screens/mainSearch.dart';

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
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 34.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFF070821),
              //42.5px
              height: 1.25,
            ),
            headline2: TextStyle(
              fontSize: 34.0,
              fontWeight: FontWeight.w700,
              color: Color(0xFFFFCF6F),
              //42.5px
              height: 1.25,
            ),
            bodyText1: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Color(0xFF070821),
              //16px
              height: 1.45,
              letterSpacing: 0.4,
              //font encode sans
              fontFamily: 'EncodeSans',
            ),
          )),
      home: SearchMain(),
    );
  }
}

