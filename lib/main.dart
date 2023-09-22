import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:petcare_search/appStyle.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:petcare_search/repository/vetRepository.dart';
import 'package:petcare_search/routes/routes.dart';
import 'package:petcare_search/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await VeterinaryRepository.GetVetsInfos();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  runApp(ChangeNotifierProvider(
    create: (context) => LogProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Care',
      theme: AppTheme,
      initialRoute: RouteGenerator.welcome,
      onGenerateRoute: RouteGenerator.generateRoute,
      // home: GoogleMapWidget(
      //     lat: 10.87017746037323, long: 106.8030326433549, name: 'ĐH CNTT'));
    );
  }
}
