import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:petcare_search/appStyle.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/constants/time.dart';
import 'package:petcare_search/repository/vetRepository.dart';
import 'package:petcare_search/screens/search_tab/search_results.dart';
import 'package:petcare_search/utils/dentist_item.dart';
import 'package:petcare_search/utils/widget_utils.dart';
import 'package:petcare_search/vetenaries/veterinary_args.dart';
import 'package:petcare_search/widgets/bottomsheet_booking.dart';
import 'package:petcare_search/widgets/dateCard.dart';
import 'package:petcare_search/widgets/google_map_widget.dart';
import 'package:petcare_search/widgets/reviewCard.dart';

class VeterinaryInfo extends StatefulWidget {
  const VeterinaryInfo({super.key, required this.vetArgs});
  final VetArgs vetArgs;

  @override
  State<VeterinaryInfo> createState() => _VeterinaryInfoState();
}

class _VeterinaryInfoState extends State<VeterinaryInfo> {
  static List<VetArgs> mainDentistList = VeterinaryRepository.vets;
  int _isSelected = 0;
  var selectedTime = DateFormat.Hm().format(DateTime.now());

  List<VetArgs> displayList = List.from(mainDentistList);

  List<Widget> vetCardgenerator() {
    List<Widget> list = [];
    displayList.forEach((index) {
      list.add(DentistItem(vetArgs: index));
    });
    return list;
  }

  List<Widget> dateCardGenerator() {
    List<Widget> list = [];
    int dayGen = 6;
    for (int i = 1; i < 32; i++) {
      list.add(DateCard(dayOfTheWeek: dayGen, date: i));
      dayGen++;
      if (dayGen == 9) {
        dayGen = 2;
      }
      ;
    }
    return list;
  }

  List<Widget> reviewCardGenerator() {
    List<String> names = ["Ann & Leo", "Bob"];
    List<Widget> list = [];
    for (int i = 0; i < names.length; i++) {
      list.add(ReviewCard(name: names[i]));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
          height: scaleH(108, context),
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40), topRight: Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$20 / first visit',
                      style: AppTheme.textTheme.displayMedium!
                          .copyWith(height: 1.2),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(children: [
                      RatingBar.builder(
                        itemSize: 16,
                        initialRating: 2.5,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (ctx, star) {
                          return const Icon(
                            Icons.star,
                            color: Color(0xffFFCF6F),
                          );
                        },
                        onRatingUpdate: (rating) {},
                      ),
                      const Text(
                        '125 reviews',
                        style: TextStyle(color: Color(0xFFBBC3CE), height: 1.2),
                      )
                    ]),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) => const BottomSheetBooking(),
                    );
                  },
                  child: Container(
                    height: scaleH(45, context),
                    width: scaleW(150, context),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0xFF4552CB)),
                    child: const Center(
                      child: Text(
                        'Book',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            height: 1.2),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: scaleH(2545, context),
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                SizedBox(
                  height: scaleH(420, context),
                  width: MediaQuery.of(context).size.width,
                  child: const Image(
                      fit: BoxFit.fitWidth,
                      image:
                          AssetImage("assets/imgs/profileImgs/valensky.png")),
                ),
                Positioned(
                    top: scaleH(49, context),
                    left: scaleW(14, context),
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true)
                            .push(MaterialPageRoute(
                                builder: (_) => SearchResults(
                                      date: DateTime.now(),
                                      speciality: 'Dentists',
                                    )));
                      },
                      icon: const Icon(Icons.arrow_back),
                      color: Colors.white,
                    )),
                Positioned(
                    top: scaleH(49, context),
                    right: scaleW(14, context),
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.share),
                            color: Colors.white),
                        SizedBox(
                          width: scaleW(14, context),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border),
                          color: Colors.white,
                        )
                      ],
                    )),
                Positioned(
                    top: scaleH(350, context),
                    left: scaleW(20, context),
                    child: Container(
                      height: scaleH(115, context),
                      width: scaleW(335, context),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: scaleW(20, context),
                                top: scaleH(14, context)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(0),
                                  child: Text(
                                    widget.vetArgs.nameVet,
                                    style: AppTheme.textTheme.displaySmall!
                                        .copyWith(height: 1.2),
                                  ),
                                ),
                                Text(
                                  'Veterinary Dentist',
                                  style: AppTheme.textTheme.headlineSmall!
                                      .copyWith(height: 1.2),
                                ),
                                Text(
                                  '10 years of experience',
                                  style: AppTheme.textTheme.bodySmall!.copyWith(
                                      height: 1.2,
                                      fontSize: 12,
                                      color: const Color(0xFF9BA0A6)),
                                ),
                                SizedBox(
                                  height: scaleH(9, context),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: AppColors.lightgray,
                                      ),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: SvgPicture.asset(
                                            'assets/icons/iconsvg/wallet.svg'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: scaleW(8, context),
                                    ),
                                    Text(
                                      '\$20',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.apply(
                                            color: const Color(0xff070821),
                                          ),
                                    ),
                                    SizedBox(
                                      width: scaleW(10, context),
                                    ),
                                    Container(
                                      height: 30,
                                      width: 30,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        color: AppColors.lightgray,
                                      ),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: SvgPicture.asset(
                                            'assets/icons/iconsvg/location.svg'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: scaleW(8, context),
                                    ),
                                    Text(
                                      '1.5km',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          ?.apply(
                                            color: const Color(0xff070821),
                                          ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(
                                top: scaleH(8, context),
                                right: scaleW(17, context)),
                            child: Column(
                              children: [
                                Container(
                                  height: scaleH(64, context),
                                  width: scaleW(64, context),
                                  decoration: BoxDecoration(
                                      gradient: const RadialGradient(
                                          center: Alignment.topLeft,
                                          radius: 1,
                                          colors: [
                                            Color(0xFF4596EA),
                                            Color(0xFF4552CB)
                                          ]),
                                      borderRadius: BorderRadius.circular(23)),
                                  child: const Center(
                                    child: Text(
                                      '4.9',
                                      style: TextStyle(
                                          fontSize: 28,
                                          color: Colors.white,
                                          height: 1.2,
                                          fontFamily: 'Montserrat'),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Text(
                                    '125 reviews',
                                    style:
                                        AppTheme.textTheme.bodySmall!.copyWith(
                                      height: 1.2,
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                Positioned(
                    top: scaleH(492, context),
                    child: Padding(
                        padding: EdgeInsets.only(
                            left: scaleW(20, context),
                            right: scaleW(20, context)),
                        child: SizedBox(
                          width: scaleW(335, context),
                          child: Column(children: [
                            Text(
                              "\"He was a friendly and diligent in getting to the right diagnosis and prescription.\"",
                              style: AppTheme.textTheme.bodyLarge,
                            ),
                            Row(
                              children: [
                                Text(
                                  'a verified review',
                                  style: AppTheme.textTheme.bodyMedium!
                                      .copyWith(color: const Color(0xFFBBC3CE)),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Padding(
                                  padding: EdgeInsets.fromLTRB(0, 8, 10, 0),
                                  child: Image(
                                    image:
                                        AssetImage('assets/icons/success.png'),
                                    fit: BoxFit.fill,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                RatingBar.builder(
                                  itemSize: 16,
                                  initialRating: 2.5,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemBuilder: (ctx, star) {
                                    return const Icon(
                                      Icons.star,
                                      color: Color(0xffFFCF6F),
                                    );
                                  },
                                  onRatingUpdate: (rating) {},
                                ),
                                const Spacer(),
                                Text(
                                  'View all 125 reviews',
                                  style: AppTheme.textTheme.bodyMedium!
                                      .copyWith(
                                          color: const Color(0xFF4552CB),
                                          fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: scaleH(32, context),
                            ),
                            Container(
                              height: scaleH(203, context),
                              width: scaleW(335, context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: scaleH(16, context)),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: scaleW(16, context),
                                        ),
                                        Container(
                                          height: 36,
                                          width: 36,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            color: AppColors.lightgray,
                                          ),
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: SvgPicture.asset(
                                                'assets/icons/iconsvg/calendar.svg'),
                                          ),
                                        ),
                                        SizedBox(
                                          width: scaleW(16, context),
                                        ),
                                        Text(
                                          'September',
                                          style: AppTheme.textTheme.labelLarge!
                                              .copyWith(
                                            fontWeight: FontWeight.bold,
                                            height: 1.2,
                                          ),
                                        ),
                                        IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.arrow_forward_ios_sharp,
                                              size: 17,
                                              color: Colors.grey,
                                            )),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: scaleH(15, context),
                                  ),
                                  const SizedBox(height: 0, child: Divider()),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(children: dateCardGenerator()),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  SizedBox(
                                      height: scaleH(35, context),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: times.length,
                                        itemBuilder: (context, index) {
                                          return Container(
                                            margin: EdgeInsets.only(
                                                left: scaleW(15, context)),
                                            child: ChoiceChip(
                                              selectedColor: AppColors.violet,
                                              label: SizedBox(
                                                height: scaleH(28, context),
                                                width: scaleH(68, context),
                                                child: Center(
                                                  child: Text(
                                                    times[index],
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline5!
                                                        .apply(
                                                            color:
                                                                _isSelected ==
                                                                        index
                                                                    ? Colors
                                                                        .white
                                                                    : Colors
                                                                        .black),
                                                  ),
                                                ),
                                              ),
                                              selected: _isSelected == index,
                                              onSelected: (bool selected) {
                                                setState(() {
                                                  _isSelected =
                                                      selected ? index : 0;
                                                  selectedTime = times[index];
                                                });
                                              },
                                            ),
                                          );
                                        },
                                      )),
                                ],
                              ),
                            ),
                            SizedBox(height: scaleH(27, context)),
                            Container(
                              height: scaleH(203, context),
                              width: scaleW(335, context),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: 36,
                                            width: 36,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: AppColors.lightgray,
                                            ),
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: SvgPicture.asset(
                                                  'assets/icons/iconsvg/work.svg'),
                                            ),
                                          ),
                                          SizedBox(
                                            width: scaleW(16, context),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Veterinary clinic "Alden-Vet"',
                                                style: AppTheme
                                                    .textTheme.headlineSmall!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 15),
                                              ),
                                              Text(
                                                '141N Union Ave, Los Angeles, CA',
                                                style: AppTheme
                                                    .textTheme.bodySmall!
                                                    .copyWith(
                                                        height: 1.2,
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.normal),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                          // height: scaleH(135, context),
                                          // width: scaleH(342, context),
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                            // image: DecorationImage(
                                            //   image:
                                            //       AssetImage('assets/imgs/map.png'),
                                            //   fit: BoxFit.fitWidth,
                                            // )),
                                          ),
                                          child: GoogleMapWidget(
                                              lat: widget.vetArgs.lat,
                                              long: widget.vetArgs.long,
                                              name:
                                                  widget.vetArgs.nameLocation)),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: scaleH(40, context),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Biography',
                                      style: AppTheme.textTheme.headlineLarge!
                                          .copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              height: 1.2),
                                    ),
                                    SizedBox(height: scaleH(10, context)),
                                    Text(
                                      '${widget.vetArgs.nameVet}, born in 1974',
                                      style: const TextStyle(height: 1.4),
                                    ),
                                    const Text(
                                      'Master of Veterinary Medicine',
                                      style: TextStyle(height: 1.4),
                                    ),
                                    const Text(
                                      'Leading doctor Veterinary clinic "Alden Vet"',
                                      style: TextStyle(height: 1.4),
                                    ),
                                    const Text(
                                      'Specialization: clinical diagnostics, surgery vet, dentist',
                                      style: TextStyle(height: 1.4),
                                    ),
                                    SizedBox(
                                      height: scaleH(24, context),
                                    ),
                                    Text(
                                      'Education',
                                      style: AppTheme.textTheme.headlineMedium,
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                      height: scaleH(10, context),
                                    ),
                                    const Text(
                                      'Before entering the agricultural Academy he worked at the department of surgery of the veterinary faculty (1991-1992). He graduated from the Faculty of Veterinary Medicine of NAU in 1997. He defended his thesis at the Departmentof Surgery on the topic: "Surgery on the urinary organs of cats." Scientific advisor prof. Borisevich V.B. In 1998 graduated from the Magistracy.',
                                      style: TextStyle(height: 1.4),
                                      textAlign: TextAlign.justify,
                                    ),
                                    SizedBox(
                                      height: scaleH(24, context),
                                    ),
                                    Text(
                                      'Professional Experience',
                                      style: AppTheme.textTheme.headlineMedium,
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                      height: scaleH(10, context),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 7, right: 8),
                                          child: Container(
                                            height: 8,
                                            width: 8,
                                            decoration: const BoxDecoration(
                                                color: Colors.yellow,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                        Expanded(
                                          //width: scaleW(320, context),
                                          child: Text(
                                            widget.vetArgs.personalInf,
                                            style: const TextStyle(height: 1.4),
                                            textAlign: TextAlign.justify,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: scaleH(10, context),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 7, right: 8),
                                          child: Container(
                                            height: 8,
                                            width: 8,
                                            decoration: const BoxDecoration(
                                                color: Colors.yellow,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                        Expanded(
                                          // width: scaleW(320, context),
                                          child: const Text(
                                            'From 1998 to 2001, he was the chief physician of the\nEquus veterinary medicine clinic.',
                                            style: TextStyle(height: 1.4),
                                            textAlign: TextAlign.justify,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: scaleH(10, context),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 7, right: 8),
                                          child: Container(
                                            height: 8,
                                            width: 8,
                                            decoration: const BoxDecoration(
                                                color: Colors.yellow,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                        const Expanded(
                                          //width: scaleW(320, context),
                                          child: Text(
                                            'Constantly increases the level of his qualifications,\nattending international conferences, congresses, \nworkshops on veterinary services for small pets.',
                                            style: TextStyle(height: 1.4),
                                            textAlign: TextAlign.justify,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: scaleH(10, context),
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 7, right: 8),
                                          child: Container(
                                            height: 8,
                                            width: 8,
                                            decoration: const BoxDecoration(
                                                color: Colors.yellow,
                                                shape: BoxShape.circle),
                                          ),
                                        ),
                                        const Expanded(
                                          //width: scaleW(320, context),
                                          child: Text(
                                            'Since 2006, the leading doctor of veterinary care "UCCA". At the same time, she continues to conduct reception at the Equus veterinary medicine clinic, where he has been working since 1997.',
                                            style: TextStyle(height: 1.4),
                                            textAlign: TextAlign.justify,
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: scaleH(24, context),
                                    ),
                                    Text(
                                      'Personal Infomation',
                                      style: AppTheme.textTheme.headlineMedium,
                                      textAlign: TextAlign.left,
                                    ),
                                    SizedBox(
                                      height: scaleH(10, context),
                                    ),
                                    const Text(
                                      'Candidate master of sports in equestrian sport (dressage). Favorite breed of dog is German Shepherd. He is married, has two children: daughter Alika and son Timur.',
                                      style: TextStyle(height: 1.4),
                                      textAlign: TextAlign.justify,
                                    ),
                                    SizedBox(
                                      height: scaleH(24, context),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Review',
                                          style: AppTheme
                                              .textTheme.headlineLarge!
                                              .copyWith(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black,
                                                  height: 1.2),
                                        ),
                                        const Spacer(),
                                        Text(
                                          'View all 125 reviews',
                                          style: AppTheme.textTheme.bodyMedium!
                                              .copyWith(
                                                  color:
                                                      const Color(0xFF4552CB),
                                                  fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                            padding: EdgeInsets.zero,
                                            constraints: const BoxConstraints(),
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.arrow_forward_ios_sharp,
                                              size: 17,
                                              color: Color(0xFF4552CB),
                                            )),
                                      ],
                                    ),
                                    SizedBox(
                                      height: scaleH(24, context),
                                    ),
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: reviewCardGenerator(),
                                      ),
                                    ),
                                    SizedBox(height: scaleH(24, context)),
                                    Container(
                                      height: scaleH(46, context),
                                      width: scaleW(335, context),
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFF0F0F8),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.edit_square,
                                            color: Color(0xFF4552CB),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            'Write a review',
                                            style: AppTheme.textTheme.bodyLarge!
                                                .copyWith(
                                                    color:
                                                        const Color(0xFF4552CB),
                                                    fontWeight:
                                                        FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: scaleH(34, context),
                                    ),
                                    Text(
                                      'Nearby vet',
                                      style: AppTheme.textTheme.headlineLarge!
                                          .copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                              height: 1.2),
                                    ),
                                    SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: vetCardgenerator(),
                                        )),
                                  ]),
                            )
                          ]),
                        )))
              ],
            ),
          ),
        ));
  }
}
