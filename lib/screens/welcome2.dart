import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Welcome2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 39),
              child: Image.asset(
                'assets/imgs/welcomeImgs/welcome2.png',
                fit: BoxFit.cover,
                width: 410,
              ),
            ),
            const SizedBox(
              height: 77,
            ),
            Text(
              'Proven experts',
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
              'We interview every specialist before\nthey get to work.',
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
                  backgroundColor: Color(0xff4552CB),
                ),
                onPressed: () {},
                child: Text(
                  'Next',
                  style: GoogleFonts.encodeSans(
                    textStyle: TextStyle(
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
