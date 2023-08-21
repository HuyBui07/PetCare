import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petcare_search/appStyle.dart';

import 'package:petcare_search/screens/welcome.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
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
      home: Welcome(),
    );
  }
}
