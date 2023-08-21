import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Violetbutton extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  const Violetbutton({required this.height, required this.width, required this.text});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: height,
                    width: width,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xff4552CB),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Save',
                        style: GoogleFonts.encodeSans(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  );
  }
}