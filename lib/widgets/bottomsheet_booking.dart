import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/constants/time.dart';
import 'package:petcare_search/screens/search_tab/search_tks.dart';
import 'package:petcare_search/utils/widget_utils.dart';

final formatter = DateFormat('MMMM d, y');

class BottomSheetBooking extends StatefulWidget {
  const BottomSheetBooking({super.key});

  @override
  State<BottomSheetBooking> createState() => _BottomSheetBookingState();
}

class _BottomSheetBookingState extends State<BottomSheetBooking> {
  TextEditingController dateInput = TextEditingController();
  int _isSelected = 0;
  var selectedDate = DateTime.now();
  var selectedTime = DateFormat.Hm().format(DateTime.now());

  @override
  void initState() {
    dateInput.text = DateFormat("EEE, MMM d").format(DateTime.now());
    ; //set the initial value of text field
    super.initState();
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != DateTime.now()) {
      String formattedDate = DateFormat("EEE, MMM d").format(picked);
      setState(() {
        dateInput.text = formattedDate;
        selectedDate = picked;
      });
    }
  }

  void _saveData() {
    FirebaseFirestore.instance.collection('Appointments').add({
      'bookedDate': '${formatter.format(selectedDate)} at $selectedTime UTC+7',
      'bookedOn': DateTime.now(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            color: Colors.white),
        height: scaleH(427, context),
        child: Container(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: scaleW(18, context)),
                  width: scaleW(30, context),
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: AppColors.violet,
                        size: scaleW(24, context),
                      )),
                ),
                Expanded(
                  child: Text(
                    'Booking confirmation',
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: scaleW(30, context),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: scaleW(18, context)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(scaleW(18, context)),
                    child: Image.asset(
                      'assets/imgs/profileImgs/photo.png',
                      fit: BoxFit.cover,
                      height: scaleH(96, context),
                      width: scaleH(96, context),
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: scaleW(20, context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Alekseenko Vasily ',
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Text(
                          'Veterinary Dentist ',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RatingBar(
                              ratingWidget: RatingWidget(
                                full: const Icon(
                                  Icons.star,
                                  color: Color(0xffFFCF6F),
                                ),
                                half: const Icon(
                                  Icons.star_half_outlined,
                                  color: Color(0xffFFCF6F),
                                ),
                                empty: const Icon(
                                  Icons.star_border,
                                  color: Color(0xffFFCF6F),
                                ),
                              ),
                              itemSize: 16,
                              unratedColor: Colors.white,
                              initialRating: 2.5,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              onRatingUpdate: (rating) {},
                              ignoreGestures: true,
                            ),
                            SizedBox(
                              width: scaleW(10, context),
                            ),
                            Text(
                              '125 Review',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .apply(color: AppColors.gray),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(scaleW(18, context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .apply(color: AppColors.gray),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        border: Border(
                      bottom: BorderSide(color: AppColors.gray),
                    )),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(0),
                      visualDensity: const VisualDensity(vertical: -4),
                      title: Text(
                        dateInput.text,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () => _selectDate(context),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
                height: scaleH(35, context),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: times.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(left: scaleW(15, context)),
                      child: ChoiceChip(
                        selectedColor: AppColors.violet,
                        label: Container(
                          height: scaleH(28, context),
                          width: scaleH(68, context),
                          child: Center(
                            child: Text(
                              times[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .apply(
                                      color: _isSelected == index
                                          ? Colors.white
                                          : Colors.black),
                            ),
                          ),
                        ),
                        selected: _isSelected == index,
                        onSelected: (bool selected) {
                          setState(() {
                            _isSelected = selected ? index : 0;
                            selectedTime = times[index];
                          });
                        },
                      ),
                    );
                  },
                )),
            Container(
              margin: EdgeInsets.symmetric(horizontal: scaleW(18, context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '\$20',
                        style: Theme.of(context).textTheme.headline2,
                      ),
                      Text(
                        ' / first visit',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  TextButton(
                      onPressed: () {
                        _saveData();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (ctx) => SearchThanks(
                              datePicked: selectedDate,
                              timePicked: selectedTime,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: scaleH(38, context),
                        width: scaleW(168, context),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(scaleW(24, context)),
                            color: AppColors.violet),
                        child: Center(
                          child: Text(
                            'Book',
                            style: Theme.of(context)
                                .textTheme
                                .button!
                                .apply(color: Colors.white),
                          ),
                        ),
                      ))
                ],
              ),
            )
          ],
        )));
  }
}
