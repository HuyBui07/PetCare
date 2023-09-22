import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_search/routes/routes.dart';

class Welcome1 extends StatelessWidget {
  final VoidCallback onPressed;

  const Welcome1({super.key, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Image.asset(
                'assets/imgs/welcomeImgs/welcome1.png',
                fit: BoxFit.cover,
                width: 410,
              ),
            ),
            const SizedBox(
              height: 77,
            ),
            Text(
              'Welcome to Pet Care',
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
              'All types of services for your pet in one\nplace, instanly searchable.',
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
                // onPressed: () {
                //   //Navigator.pushNamed(context, RouteGenerator.welcome2);
                // },
                onPressed: onPressed,
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
            // Container(
            //   height: 50,
            //   width: 270,
            //   child: TextButton(
            //     style: TextButton.styleFrom(
            //       backgroundColor: Color(0xff4552CB),
            //     ),
            //     // onPressed: () {
            //     //   //Navigator.pushNamed(context, RouteGenerator.welcome2);
            //     // },
            //     onPressed: onPressed,
            //     child: Text(
            //       'Next',
            //       style: GoogleFonts.encodeSans(
            //         textStyle: TextStyle(
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
