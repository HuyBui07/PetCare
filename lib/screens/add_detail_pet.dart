import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:petcare_search/utils/addPetDetail/cupertino_switch.dart';
import 'package:petcare_search/utils/addPetDetail/textFormField.dart';
import 'package:petcare_search/utils/addPetDetail/violetButton.dart';
import '../constants/colors.dart';
import '../utils/widget_utils.dart';

import '../utils/pet_events_list.dart';

class AddDetailPet extends StatefulWidget {
  @override
  State<AddDetailPet> createState() => _AddDetailPetState();
}

class _AddDetailPetState extends State<AddDetailPet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const Icon(Icons.arrow_back, color: AppColors.violet),
        centerTitle: true,
        title: Text(
          'Add pet detail',
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Skip',
              style: Theme.of(context).textTheme.headline6?.apply(
                    color: AppColors.violet,
                  ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: scaleH(32, context)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: scaleH(112, context),
                  width: scaleH(112, context),
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
                          height: scaleH(30, context),
                          width: scaleH(30, context),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            gradient: const LinearGradient(
                              colors: <Color>[
                                Color(0xff4596EA),
                                Color(0xff4552CB),
                              ],
                            ),
                          ),
                          child: IconButton(
                            iconSize: scaleH(16, context),
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: scaleH(20, context), top: scaleH(32, context)),
                  child: Row(
                    children: [
                      Text(
                        'General\ninformation',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        left: scaleH(20, context), right: scaleH(20, context)),
                    child: CustomTextformfield(text: "Pet's name")),
                Padding(
                    padding: EdgeInsets.only(
                        left: scaleH(20, context), right: scaleH(20, context)),
                    child: CustomTextformfield(text: "Species of your pet")),
                Padding(
                    padding: EdgeInsets.only(
                        left: scaleH(20, context), right: scaleH(20, context)),
                    child: CustomTextformfield(text: "Breed")),
                Padding(
                    padding: EdgeInsets.only(
                        left: scaleH(20, context), right: scaleH(20, context)),
                    child: CustomTextformfield(text: "Size (optional)")),
                Padding(
                  padding: EdgeInsets.only(
                      left: scaleH(20, context), top: scaleH(24, context)),
                  child: Row(
                    children: [
                      Text(
                        "Gender",
                        style: Theme.of(context).textTheme.headline6?.apply(
                              color: AppColors.gray,
                            ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: scaleH(20, context),
                      right: scaleH(20, context),
                      top: scaleH(13, context)),
                  child: Row(
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
                  padding:EdgeInsets.only(left: scaleW(20, context), right: scaleH(20, context)),
                  child: CustomTextformfield(text: "Date of birth")
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
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: scaleH(20, context),
                      top: scaleH(37, context),
                      right: scaleH(20, context)),
                  child: CusCupertinoswitch(text: 'Neutered'),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: scaleH(20, context),
                      top: scaleH(24, context),
                      right: scaleH(20, context)),
                  child: CusCupertinoswitch(text: 'Vaccinated'),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: scaleH(20, context),
                      top: scaleH(24, context),
                      right: scaleH(20, context)),
                  child: CusCupertinoswitch(text: 'Friendly with dogs'),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: scaleH(20, context),
                      top: scaleH(24, context),
                      right: scaleH(20, context)),
                  child: CusCupertinoswitch(text: 'Friendly with cats'),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: scaleH(20, context),
                      top: scaleH(24, context),
                      right: scaleH(20, context)),
                  child:
                      CusCupertinoswitch(text: 'Friendly with kids <10 years'),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: scaleH(20, context),
                      top: scaleH(24, context),
                      right: scaleH(20, context)),
                  child:
                      CusCupertinoswitch(text: 'Friendly with kids >10 years'),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: scaleH(20, context),
                      top: scaleH(24, context),
                      right: scaleH(20, context)),
                  child: CusCupertinoswitch(text: 'Microchipped'),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: scaleH(20, context),
                      top: scaleH(24, context),
                      right: scaleH(20, context)),
                  child: CusCupertinoswitch(text: 'Purebred'),
                ),

                Padding(
                  padding: EdgeInsets.only(
                      left: scaleH(20, context),
                      top: scaleH(24, context),
                      right: scaleH(20, context)),
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.lightgrey2,
                          width: 1.5,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColors.lightgrey2, width: 2),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(
                    left: scaleH(20, context),
                    top: scaleH(32, context),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Reminders',
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: scaleH(20, context),
                    top: scaleH(14, context),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Add vaccines, haircuts, pills, estrus, etc. and\nyou will receive notifications for the next\nevent.',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: scaleW(20, context), right: scaleW(20, context), top: scaleH(24, context)),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xffF0F0F8),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.violet.withOpacity(0.09),
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
                                      color:
                                          Color(0xff4552CB).withOpacity(0.23),
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
                  padding:EdgeInsets.only(top: scaleH(24, context), ),
                  child: Violetbutton(height: scaleH(46, context), width: scaleW(335, context), text: 'Next')
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
