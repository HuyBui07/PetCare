import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_search/screens/registration.dart';

class Welcome3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 92),
              child: Image.asset(
                'assets/imgs/welcomeImgs/welcome3.png',
                fit: BoxFit.cover,
                width: 410,
              ),
            ),
            const SizedBox(
              height: 77,
            ),
            Text(
              'Reliable reviews',
              style: GoogleFonts.encodeSans(
                textStyle: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Color(0XFF070821),
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'A review can be left only by a user\nwho used the service.',
              textAlign: TextAlign.center,
              style: GoogleFonts.encodeSans(
                textStyle: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Color(0XFF070821),
                ),
              ),
            ),
            const SizedBox(
              height: 58,
            ),
            Container(
              height: 50,
              width: 270,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff4552CB),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Registration()));
                },
                child: Text(
                  'Get Started',
                  style: GoogleFonts.encodeSans(
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
