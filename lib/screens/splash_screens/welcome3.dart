import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_search/routes/routes.dart';

class Welcome3 extends StatelessWidget {
  const Welcome3({super.key});

  // final VoidCallback onPressed;

  // const Welcome3({super.key, required this.onPressed});
  @override
  Widget build(BuildContext context) {
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
                textStyle: const TextStyle(
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
                textStyle: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Color(0XFF070821),
                ),
              ),
            ),
            const SizedBox(
              height: 58,
            ),
            SizedBox(
              height: 50,
              width: 270,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xff4552CB),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, RouteGenerator.registration);
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
            // SizedBox(
            //   height: 50,
            //   width: 270,
            //   child: TextButton(
            //     style: TextButton.styleFrom(
            //       backgroundColor: const Color(0xff4552CB),
            //     ),
            //     onPressed: () {
            //       Navigator.pushNamed(context, RouteGenerator.registration);
            //     },
            //     child: Text(
            //       'Get Started',
            //       style: GoogleFonts.encodeSans(
            //         textStyle: const TextStyle(
            //           fontSize: 18,
            //           fontWeight: FontWeight.w700,
            //           color: Colors.white,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
