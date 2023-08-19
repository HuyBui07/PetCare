import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcare_search/constants/colors.dart';
import 'package:petcare_search/utils/widget_utils.dart';
import 'package:petcare_search/widgets/bottomButton.dart';

class UpcomingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: scaleH(94, context)),
            child: Image.asset('assets/upComingImgs/Clock.png'),
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
            child: BottomButtom('Find a specialist'),
          ),
        ],
      ),
    );
  }
}
