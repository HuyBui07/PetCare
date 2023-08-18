import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../utils/widget_utils.dart';

class AppointmentScreen extends StatefulWidget {
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
              margin: EdgeInsetsDirectional.only(bottom: scaleH(10, context)),
              height: scaleH(176, context),
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
                child: Container(
                  
                  padding: EdgeInsets.only(top: scaleH(112, context)),
                  width: scaleW(335, context),
                  height: scaleH(38, context),
                  decoration: BoxDecoration(
                    color: AppColors.violet,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: TabBar(
                          unselectedLabelColor: Colors.white,
                          labelColor: Colors.white,
                          indicatorColor: Colors.black,
                          indicatorWeight: 2,
                          indicator: BoxDecoration(
                            color: AppColors.violet,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          controller: tabController,
                          tabs: const [
                            Tab(
                              text: 'Tab1',
                            ),
                            Tab(
                              text: 'Tab1',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
