import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/utils/addPetDetail/violetButton.dart';
import 'package:petcare_search/utils/widget_utils.dart';
import 'package:petcare_search/widgets/appointmentCard.dart';

class PastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: scaleW(20, context),
                top: scaleH(40, context),
                right: scaleW(20, context)),
            child: CustomAppointmentCard(),
          ),
        ],
      ),
    );
  }
}
