import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/pet_events_list.dart';

class AddDetailPet extends StatefulWidget {
  @override
  State<AddDetailPet> createState() => _AddDetailPetState();
}

class _AddDetailPetState extends State<AddDetailPet> {
  var filter = false;
  var filter1 = false;
  var filter2 = false;
  var filter3 = false;
  var filter4 = false;
  var filter5 = false;
  var filter6 = false;
  var filter7 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Icon(
          Icons.arrow_back,
          color: Color(0xFF4552CB),
          size: 30,
          weight: 8,
        ),
        centerTitle: true,
        title: Text(
          'Add pet detail',
          style: GoogleFonts.encodeSans(
            textStyle: TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              color: Color(0XFF070821),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Skip',
              style: GoogleFonts.encodeSans(
                textStyle: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF4552CB),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 112,
                  width: 112,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      const Positioned(
                        top: 10,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage:
                              AssetImage('assets/welcomeImgs/Avt_Pet.png'),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    const Color(0xff4552CB).withOpacity(0.23),
                                spreadRadius: 5,
                                blurRadius: 17,
                                offset: const Offset(0, 10),
                              ),
                            ],
                            gradient: const LinearGradient(
                              colors: <Color>[
                                Color(0xff4596EA),
                                Color(0xff4552CB),
                              ],
                            ),
                          ),
                          child: IconButton(
                            iconSize: 22,
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                              weight: 5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    
                    children: [
                      Text(
                        'General\ninformation',
                        style: GoogleFonts.encodeSans(
                          textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0XFF070821),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFF0F0F8),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFF0F0F8), width: 2),
                      ),
                      label: Text(
                        "Pet's name",
                        style: GoogleFonts.encodeSans(
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0XFFBBC3CE),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFF0F0F8),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFF0F0F8), width: 2),
                      ),
                      label: Text(
                        "Species of your pet",
                        style: GoogleFonts.encodeSans(
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0XFFBBC3CE),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFF0F0F8),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFF0F0F8), width: 2),
                      ),
                      label: Text(
                        "Breed",
                        style: GoogleFonts.encodeSans(
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0XFFBBC3CE),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFF0F0F8),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFF0F0F8), width: 2),
                      ),
                      label: Text(
                        "Size (opsional)",
                        style: GoogleFonts.encodeSans(
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0XFFBBC3CE),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Gender",
                        style: GoogleFonts.encodeSans(
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0XFFBBC3CE),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 13,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff4552CB).withOpacity(0.09),
                              spreadRadius: 0,
                              blurRadius: 13,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        width: 163,
                        child: TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.mars,
                            size: 15,
                            weight: 2,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Male',
                            style: GoogleFonts.encodeSans(
                              textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0xFF4552CB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 163,
                        child: TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            FontAwesomeIcons.venus,
                            size: 15,
                            weight: 2,
                            color: Color(0xFFFD90AA),
                          ),
                          label: Text(
                            'Female',
                            style: GoogleFonts.encodeSans(
                              textStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff070821),
                              ),
                            ),
                          ),
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                              side: BorderSide(
                                  color: Color(0xFFF0F0F8), width: 1.5),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFF0F0F8),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFF0F0F8), width: 2),
                      ),
                      label: Text(
                        "Date of birth",
                        style: GoogleFonts.encodeSans(
                          textStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0XFFBBC3CE),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Text(
                        'Additional Information',
                        style: GoogleFonts.encodeSans(
                          textStyle: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: Color(0XFF070821),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      Text(
                        'Neutered',
                        style: GoogleFonts.encodeSans(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFF070821),
                          ),
                        ),
                      ),
                      Spacer(),
                      CupertinoSwitch(
                        value: filter,
                        onChanged: (isChecked) {
                          setState(() {
                            filter = isChecked;
                          });
                        },
                        trackColor: Color(0xffF5F5F5),
                        activeColor: Color(0xff4552CB),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
                  child: Row(
                    children: [
                      Text(
                        'Vaccinated',
                        style: GoogleFonts.encodeSans(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFF070821),
                          ),
                        ),
                      ),
                      Spacer(),
                      CupertinoSwitch(
                        value: filter1,
                        onChanged: (isChecked) {
                          setState(() {
                            filter1 = isChecked;
                          });
                        },
                        trackColor: Color(0xffF5F5F5),
                        activeColor: Color(0xff4552CB),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
                  child: Row(
                    children: [
                      Text(
                        'Friendly with dogs',
                        style: GoogleFonts.encodeSans(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFF070821),
                          ),
                        ),
                      ),
                      Spacer(),
                      CupertinoSwitch(
                        value: filter2,
                        onChanged: (isChecked) {
                          setState(() {
                            filter2 = isChecked;
                          });
                        },
                        trackColor: Color(0xffF5F5F5),
                        activeColor: Color(0xff4552CB),
                      ),
                    ],
                  ),
                ),

               Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
                  child: Row(
                    children: [
                      Text(
                        'Friendly with cats',
                        style: GoogleFonts.encodeSans(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFF070821),
                          ),
                        ),
                      ),
                      Spacer(),
                      CupertinoSwitch(
                        value: filter3,
                        onChanged: (isChecked) {
                          setState(() {
                            filter3 = isChecked;
                          });
                        },
                        trackColor: Color(0xffF5F5F5),
                        activeColor: Color(0xff4552CB),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
                  child: Row(
                    children: [
                      Text(
                        'Friendly with kids <10 years',
                        style: GoogleFonts.encodeSans(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFF070821),
                          ),
                        ),
                      ),
                      Spacer(),
                      CupertinoSwitch(
                        value: filter4,
                        onChanged: (isChecked) {
                          setState(() {
                            filter4 = isChecked;
                          });
                        },
                        trackColor: Color(0xffF5F5F5),
                        activeColor: Color(0xff4552CB),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
                  child: Row(
                    children: [
                      Text(
                        'Friendly with kids >10 years',
                        style: GoogleFonts.encodeSans(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFF070821),
                          ),
                        ),
                      ),
                      Spacer(),
                      CupertinoSwitch(
                        value: filter5,
                        onChanged: (isChecked) {
                          setState(() {
                            filter5 = isChecked;
                          });
                        },
                        trackColor: Color(0xffF5F5F5),
                        activeColor: Color(0xff4552CB),
                      ),
                    ],
                  ),
                ),

Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
                  child: Row(
                    children: [
                      Text(
                        'Microchipped',
                        style: GoogleFonts.encodeSans(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFF070821),
                          ),
                        ),
                      ),
                      Spacer(),
                      CupertinoSwitch(
                        value: filter6,
                        onChanged: (isChecked) {
                          setState(() {
                            filter6 = isChecked;
                          });
                        },
                        trackColor: Color(0xffF5F5F5),
                        activeColor: Color(0xff4552CB),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
                  child: Row(
                    children: [
                      Text(
                        'Purebred',
                        style: GoogleFonts.encodeSans(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFF070821),
                          ),
                        ),
                      ),
                      Spacer(),
                      CupertinoSwitch(
                        value: filter7,
                        onChanged: (isChecked) {
                          setState(() {
                            filter7 = isChecked;
                          });
                        },
                        trackColor: Color(0xffF5F5F5),
                        activeColor: Color(0xff4552CB),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFF0F0F8),
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFFF0F0F8), width: 2),
                      ),
                      
                    ),
                  ),
                ),
                
                
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 32),
                  child: Row(
                    children: [
                      Text(
                        'Reminders',
                        style: GoogleFonts.encodeSans(
                          textStyle: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0XFF070821),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 14),
                  child: Row(
                    children: [
                      Text(
                        'Add vaccines, haircuts, pills, estrus, etc. and\nyou will receive notifications for the next\nevent.',
                        style: GoogleFonts.encodeSans(
                          textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0XFF070821),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 24),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffF0F0F8),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff2D368A).withOpacity(0.09),
                              spreadRadius: 2,
                              blurRadius: 50,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        width: 140,
                        height: 150,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: Container(
                                height: 55,
                                width: 55,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xff4552CB).withOpacity(0.23),
                                      spreadRadius: 5,
                                      blurRadius: 17,
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                  gradient: const LinearGradient(
                                    colors: <Color>[
                                      Color(0xff4596EA),
                                      Color(0xff4552CB),
                                    ],
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    weight: 5,
                                    size: 40,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                'Add event',
                                style: GoogleFonts.encodeSans(
                                  textStyle: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0XFF070821),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Expanded(
                        child: SizedBox(
                          height: 150,
                          child: ListItem(title: [
                            'Measles vaccine',
                            'Measles vaccine',
                            'Measles vaccine',
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),

                //nút save

                Padding(
                  padding: const EdgeInsets.only(top: 24, left: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 46,
                    width: 380,
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
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
