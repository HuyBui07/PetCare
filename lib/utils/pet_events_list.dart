import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListItem extends StatelessWidget {
  const ListItem({super.key, required this.title});

  final List<String> title;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: title.length,
      itemBuilder: (ctx, index) {
        return Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff2D368A).withOpacity(0.008),
                  spreadRadius: 1,
                  blurRadius: 28,
                  offset: const Offset(4, 6),
                ),
              ],
            ),
            width: 140,
            height: 150,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Image.asset('assets/welcomeImgs/vaccine_icon.png'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    title[index],
                    style: GoogleFonts.encodeSans(
                      textStyle: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFF070821),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: Text(
                    '30.08.2018 r',
                    style: GoogleFonts.encodeSans(
                      textStyle: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0XFFBBC3CE),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
