import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petcare_search/appStyle.dart';
import 'package:petcare_search/routes/routes.dart';
import 'package:petcare_search/screens/home_screen.dart';
import 'package:petcare_search/screens/sign_in.dart';
import 'package:petcare_search/screens/sign_up.dart';
import '../services/auth_service.dart';
import 'mainSearch.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  double scaleH(original) {
    return (original * MediaQuery.of(context).size.height / 812);
  }

  double scaleW(original) {
    return (original * MediaQuery.of(context).size.width / 375);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
          gradient: RadialGradient(
              center: Alignment.topLeft,
              radius: 1,
              colors: [Color(0xFF4596EA), Color(0xFF4552CB)])),
      child: Padding(
        padding: EdgeInsets.fromLTRB(scaleH(40), scaleH(128), scaleH(40), 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    style: AppTheme.textTheme.displayLarge!
                        .copyWith(color: Colors.white, fontSize: scaleH(44)),
                    children: [
                  const TextSpan(text: 'Welcome to '),
                  TextSpan(
                    text: 'Pet Care',
                    style: AppTheme.textTheme.displayLarge!.copyWith(
                        color: const Color(0xFFFFCF6F), fontSize: scaleH(44)),
                  )
                ])),
            SizedBox(
              height: scaleH(54),
            ),
            SizedBox(
              height: scaleH(46),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    try {
                      final UserCredential userCredential =
                          await facebookLogin();
                      if (context.mounted) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainScreen(
                                      index: 0,
                                    )));
                      }
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: scaleH(20)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  child: Row(children: [
                    SizedBox(
                      width: scaleW(43),
                    ),
                    Image.asset('assets/icons/fb_icon.png'),
                    SizedBox(
                      width: scaleW(16),
                    ),
                    RichText(
                      text: TextSpan(
                          style: AppTheme.textTheme.headlineMedium!.copyWith(
                              color: const Color(0xFF4552CB),
                              fontWeight: FontWeight.normal),
                          children: [
                            const TextSpan(text: 'Continue with '),
                            TextSpan(
                                text: 'FaceBook',
                                style: AppTheme.textTheme.headlineMedium!
                                    .copyWith(
                                        color: const Color(0xFF4552CB),
                                        fontWeight: FontWeight.bold))
                          ]),
                    ),
                  ])),
            ),
            SizedBox(
              height: scaleH(24),
            ),
            SizedBox(
              height: scaleH(46),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xFF4552CB),
                            ),
                          );
                        });

                    // googleLogIn().then((value) => Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //         builder: (context) => const SearchMain())));
                    googleLogIn().then((value) =>
                        Navigator.pushNamed(context, RouteGenerator.main));
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: scaleH(20)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  child: Row(children: [
                    SizedBox(
                      width: scaleW(43),
                    ),
                    Image.asset('assets/icons/google_icon.png'),
                    SizedBox(
                      width: scaleW(16),
                    ),
                    RichText(
                      text: TextSpan(
                          style: AppTheme.textTheme.headlineMedium!.copyWith(
                              color: const Color(0xFF4552CB),
                              fontWeight: FontWeight.normal),
                          children: [
                            const TextSpan(text: 'Continue with '),
                            TextSpan(
                                text: 'Google',
                                style: AppTheme.textTheme.headlineMedium!
                                    .copyWith(
                                        color: const Color(0xFF4552CB),
                                        fontWeight: FontWeight.bold))
                          ]),
                    ),
                  ])),
            ),
            SizedBox(
              height: scaleH(48),
            ),
            SizedBox(
              height: scaleH(46),
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUp()));
                  },
                  style: ElevatedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      backgroundColor: const Color(0xFF4552CB),
                      textStyle: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: scaleH(20)),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25))),
                  child: Text(
                    'Register with Email',
                    style: AppTheme.textTheme.headlineMedium!.copyWith(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  )),
            ),
            SizedBox(
              height: scaleH(80),
            ),
            Center(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text('Already have an account?',
                    style: AppTheme.textTheme.headlineMedium!.copyWith(
                        fontWeight: FontWeight.w400, color: Colors.white)),
                const SizedBox(
                  width: 3,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignIn()));
                  },
                  child: Text('Sign In',
                      style: AppTheme.textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.white)),
                )
              ]),
            )
          ],
        ),
      ),
    ));
  }
}
