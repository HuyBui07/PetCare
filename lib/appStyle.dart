import 'package:flutter/material.dart';

ThemeData AppTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
    textTheme:  TextTheme(
      //Usage: Main search title text
      headline1: TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.w700,
        color: Color(0xFF070821),
        //42.5px
        height: 1.25,
        fontFamily: 'EncodeSans',
      ),
      
      //Usage:
      headline2: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: Color(0xFF070821),
        height: 30 / 24,
        letterSpacing: 0.02,
        fontFamily: 'EncodeSans',
      ),
      headline3: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w700,
        color: Color(0xFF070821),
        height: 22.5 / 18,
        letterSpacing: 0.02,
        fontFamily: 'EncodeSans',
      ),
      headline4: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFF070821),
        height: 20 / 16,
        fontFamily: 'EncodeSans',
        
      ),
      headline5: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFF070821),
        height: 17.5 / 14,
        fontFamily: 'EncodeSans',
       
      ),
      headline6: TextStyle(
        fontSize: 13.0,
        fontWeight: FontWeight.w600,
        color: Color(0xFF070821),
        height: 16.25 / 13,
        letterSpacing: 0.01,
        fontFamily: 'EncodeSans',
      ),
      //Usage: 
      bodyText1: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: Color(0xFF070821),
        
        height: 24/16,
        letterSpacing: 0.01,
        //font encode sans
        fontFamily: 'EncodeSans',
      ),
      subtitle2:  TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,

        //0.1 opacity
        color: ColorConstants.sub2Color,
        height: 21/14,
        letterSpacing: 0.01,
        fontFamily: 'EncodeSans',
      ),
      button:  TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w700,
        color: Color(0xFF070821),
        height: 20/16,
        fontFamily: 'EncodeSans',
      ),
      bodyText2:  TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: Color(0xFF070821),
        height: 28/14,
        letterSpacing: 0.25,
        fontFamily: 'EncodeSans',
      ),
      caption: TextStyle(
        fontSize: 11.0,
        fontWeight: FontWeight.w500,
        color: Color(0xFF070821),
        height: 16/11,
        letterSpacing: 0.04 / 11,
        fontFamily: 'EncodeSans',
      ),
      overline:  TextStyle(
        fontSize: 10.0,
        fontWeight: FontWeight.w700,
        color: Color(0xFF070821),
        height: 16/10,
        letterSpacing: 1.5 / 10,
        fontFamily: 'EncodeSans',
      ),
      

    ));


class ColorConstants
{
  static Color sub2Color = Color(0xFF070821).withOpacity(0.1);
}
class NavigationBarStyle {
  //gradient bg
  static const Color gradientStartColor = Color(0xFFF9F8FD);
  static const Color gradientEndColor = Color(0xFFFFFF);

  static const Color unselectedItemColor = Colors.grey;
  static const Color selectedItemColor = Color(0xFF4552CB);

  static const TextStyle unselectedLabelStyle = TextStyle(
    color: Colors.grey,
  );
  static const TextStyle selectedLabelStyle =
      TextStyle(color: selectedItemColor);
  static const double unselectedFontSize = 14.0;
  static const double selectedFontSize = 14.0;

  static TextStyle menu  = TextStyle(
    fontSize: 10.0,
    fontWeight: FontWeight.w500,
    color: Color(0xFF070821),
    height: 12.5 / 10,
    letterSpacing: 0.04,
    fontFamily: 'EncodeSans',
  );

}