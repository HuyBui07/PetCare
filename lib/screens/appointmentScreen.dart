import 'package:flutter/material.dart';
import 'package:petcare_search/screens/pastScreen.dart';
import 'package:petcare_search/screens/upComingScreen.dart';
import 'package:petcare_search/widgets/customTabBart.dart';

import '../constants/colors.dart';
import '../utils/widget_utils.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Appointment',
          style: Theme.of(context).textTheme.headline3,
        ),
        centerTitle: true,
      ),
      body: Container(
        color: AppColors.lightgray,
        child: Column(
          children: [
            Container(
              height: scaleH(120, context),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xff2D368A).withOpacity(0.064),
                      offset: const Offset(
                        4.0,
                        6.0,
                      ),
                      blurRadius: 28.0,
                      spreadRadius: 0)
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(scaleW(34, context)),
                  bottomRight: Radius.circular(scaleW(34, context)),
                ),
              ),
              child: Center(
                child: CustomTabBar(
                    height: 38, width: 335, tab1: 'Upcoming', tab2: 'Past'),
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  UpcomingScreen(),
                  PastScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
