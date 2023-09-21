import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/routes/routes.dart';
import 'package:petcare_search/screens/home_screen.dart';
import 'package:petcare_search/screens/profile_tab/loader_screen.dart';
import 'package:petcare_search/screens/search_tab/search_tks.dart';
import 'package:petcare_search/utils/widget_utils.dart';
import 'package:petcare_search/widgets/appointmentCard.dart';
import 'package:petcare_search/widgets/bottomButton.dart';

class UpcomingScreen extends StatefulWidget {
  @override
  State<UpcomingScreen> createState() => _UpcomingScreenState();
}

class _UpcomingScreenState extends State<UpcomingScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('Appointments').snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoaderScreen();
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: scaleH(94, context)),
                    child: Image.asset('assets/imgs/appointmentImgs/Clock.png'),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: scaleH(11, context)),
                    child: Text(
                      'No appointments yet',
                      style: Theme.of(context).textTheme.bodyText1?.apply(
                            color: AppColors.gray,
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 200),
                    child: BottomButtom(
                        'Find a specialist',
                        () => Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                builder: (_) => SearchThanks(
                                  datePicked: DateTime.now(),
                                  timePicked: '10:20 pm',
                                ),
                              ),
                            )),
                  ),
                ],
              ),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong...!'),
            );
          }

          final loadedData = snapshot.data!.docs;

          return ListView.builder(
            itemCount: loadedData.length,
            itemBuilder: (ctx, index) => CustomAppointmentCard(
              dateTime: loadedData[index].data()['bookedDate'].toString(),
            ),
          );
        });
  }
}
