import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petcare_search/appStyle.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/repository/vetRepository.dart';
import 'package:petcare_search/utils/dentist_item.dart';

import 'package:petcare_search/utils/widget_utils.dart';
import 'package:petcare_search/widgets/dateCard.dart';
import 'package:petcare_search/widgets/reviewCard.dart';
import 'package:petcare_search/widgets/timeCard.dart';

class VeterinaryInfo extends StatefulWidget {
  const VeterinaryInfo({super.key});

  @override
  State<VeterinaryInfo> createState() => _VeterinaryInfoState();
}

class _VeterinaryInfoState extends State<VeterinaryInfo> {
  static List<String> mainDentistList = VeterinaryRepository.vetsNames;

  List<String> displayList = List.from(mainDentistList);

  List<Widget> vetCardgenerator() {
    List<Widget> list = [];
    displayList.forEach((name) {
      list.add(DentistItem(name: name));
    });
    return list;
  }

  List<Widget> dateCardGenerator() {
    List<Widget> list = [];
    int dayGen = 2;
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

  List<Widget> timeCardGenerator() {
    List<String> timeList = [
      '09:00',
      '09:30',
      '10:00',
      '10:30',
      '11:30',
      '12:00',
      '12:30',
      '13:00',
      '13:30',
      '14:00',
      '14:30',
      '15:00',
      '15:30',
    ];
    List<Widget> timeCardList = [];
    for (int i = 0; i < timeList.length; i++) {
      timeCardList.add(TimeCard(time: timeList[i]));
    }
    return timeCardList;
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
                  onTap: () {},
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
                        Navigator.pop(context);
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
                                    'Alekseenco Vasily',
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
                                            color: Color(0xff070821),
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
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 4, right: 4),
                                      child: Row(
                                        children: timeCardGenerator(),
                                      ),
                                    ),
                                  )
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
                                  Container(
                                    height: scaleH(135, context),
                                    width: scaleH(342, context),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                        image: DecorationImage(
                                          image:
                                              AssetImage('assets/imgs/map.png'),
                                          fit: BoxFit.fitWidth,
                                        )),
                                  ),
                                ],
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
                                    const SizedBox(
                                      height: 112,
                                    ),
                                    Text(
                                      'Education',
                                      style: AppTheme.textTheme.headlineMedium,
                                      textAlign: TextAlign.left,
                                    ),
                                    const SizedBox(
                                      height: 112,
                                    ),
                                    Text(
                                      'Professional Experience',
                                      style: AppTheme.textTheme.headlineMedium,
                                      textAlign: TextAlign.left,
                                    ),
                                    const SizedBox(
                                      height: 112,
                                    ),
                                    Text(
                                      'Personal Infomation',
                                      style: AppTheme.textTheme.headlineMedium,
                                      textAlign: TextAlign.left,
                                    ),
                                    const SizedBox(
                                      height: 112,
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
