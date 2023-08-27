import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petcare_search/constants/colors.dart';

class LightButton extends StatelessWidget {
  final double height;
  final double width;
  final String text;
  const LightButton({required this.height, required this.width, required this.text});
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
                        backgroundColor: AppColors.lightgrey2,
                      ),
                      onPressed: () {},
                      child: Text(
                        text,
                        style: GoogleFonts.encodeSans(
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff070821),
                          ),
                        ),
                      ),
                    ),
                  );
  }
}